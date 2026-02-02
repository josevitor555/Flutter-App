from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import declarative_base, sessionmaker, relationship, Session
from jose import jwt, JWTError
from pydantic import BaseModel
from datetime import datetime, timedelta
from sqlalchemy import create_engine

# ======================
# CONFIG
# ======================

DATABASE_URL = "sqlite:///./database.db"
SECRET_KEY = open("key.key").read()
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_HOURS = 2

# ======================
# DATABASE
# ======================

engine = create_engine(
    DATABASE_URL, connect_args={"check_same_thread": False}
)
SessionLocal = sessionmaker(bind=engine)
Base = declarative_base()

# ======================
# MODELS (SQLAlchemy)
# ======================

class Usuario(Base):
    __tablename__ = "usuarios"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True)
    password = Column(String)

    itens = relationship("Item", back_populates="usuario")


class Item(Base):
    __tablename__ = "itens"

    id = Column(Integer, primary_key=True, index=True)
    titulo = Column(String)
    descricao = Column(String)
    categoria = Column(String)
    local = Column(String)
    status = Column(String)

    usuario_id = Column(Integer, ForeignKey("usuarios.id"))
    usuario = relationship("Usuario", back_populates="itens")


Base.metadata.create_all(bind=engine)

# ======================
# SCHEMAS (Pydantic)
# ======================

class ItemCreate(BaseModel):
    titulo: str
    descricao: str
    categoria: str
    local: str
    status: str


class ItemResponse(ItemCreate):
    id: int
    usuario_id: int

    class Config:
        from_attributes = True


# ======================
# FASTAPI
# ======================

app = FastAPI(title="API Itens Perdidos")

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# ======================
# DEPENDENCIES
# ======================

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def authenticate_user(username: str, password: str, db: Session):
    user = db.query(Usuario).filter(Usuario.username == username).first()
    if user and user.password == password:
        return user
    return None


def create_access_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(hours=ACCESS_TOKEN_EXPIRE_HOURS)
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)


def get_current_user(
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(get_db)
):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        user_id = payload.get("id")
        user = db.query(Usuario).filter(Usuario.id == user_id).first()
        if not user:
            raise HTTPException(status_code=401, detail="Usuário não encontrado")
        return user
    except JWTError:
        raise HTTPException(status_code=401, detail="Token inválido")


# ======================
# AUTH
# ======================

@app.post("/token")
def login(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db)
):
    user = authenticate_user(form_data.username, form_data.password, db)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Usuário ou senha incorretos"
        )

    token = create_access_token({"sub": user.username, "id": user.id})
    return {"access_token": token, "token_type": "bearer"}


@app.get("/usuarios/me")
def usuarios_me(user: Usuario = Depends(get_current_user)):
    return {
        "id": user.id,
        "username": user.username
    }

# ======================
# ITENS
# ======================

@app.post("/itens", response_model=ItemResponse)
def criar_item(
    item: ItemCreate,
    db: Session = Depends(get_db),
    user: Usuario = Depends(get_current_user)
):
    novo_item = Item(
        **item.dict(),
        usuario_id=user.id
    )
    db.add(novo_item)
    db.commit()
    db.refresh(novo_item)
    return novo_item


@app.get("/itens", response_model=list[ItemResponse])
def listar_itens(db: Session = Depends(get_db)):
    return db.query(Item).all()


@app.get("/itens/{item_id}", response_model=ItemResponse)
def detalhe_item(item_id: int, db: Session = Depends(get_db)):
    item = db.query(Item).filter(Item.id == item_id).first()
    if not item:
        raise HTTPException(status_code=404, detail="Item não encontrado")
    return item




