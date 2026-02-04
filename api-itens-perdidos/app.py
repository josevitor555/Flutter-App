from fastapi import FastAPI, Depends, HTTPException, status, UploadFile, File
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import declarative_base, sessionmaker, Session, relationship
from jose import jwt, JWTError
from pydantic import BaseModel
from datetime import datetime, timedelta
from sqlalchemy import create_engine
from typing import Optional
import uuid
import shutil
import os
from passlib.context import CryptContext
from schemas import ItemBase, ItemResponse, ItemUpdate, UserCreate, Token, ItemCreate

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
    status = Column(String)  # "lost" ou "found"
    imagem_url = Column(String, nullable=True)  # URL da imagem do item

    usuario_id = Column(Integer, ForeignKey("usuarios.id"))
    usuario = relationship("Usuario", back_populates="itens")


Base.metadata.create_all(bind=engine)


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
    if user and verify_password(password, user.password):
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
            raise HTTPException(
                status_code=401, detail="Usuário não encontrado")
        return user
    except JWTError:
        raise HTTPException(status_code=401, detail="Token inválido")


pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)


def get_password_hash(password):
    return pwd_context.hash(password)


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


@app.post("/users/register", response_model=Token)
def register_user(user: UserCreate, db: Session = Depends(get_db)):
    # Verificar se o usuário já existe
    existing_user = db.query(Usuario).filter(
        Usuario.username == user.username).first()
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Username já está em uso"
        )

    # Criar novo usuário com senha hash
    hashed_password = get_password_hash(user.password)
    new_user = Usuario(username=user.username, password=hashed_password)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    # Gerar token para o novo usuário
    token_data = {"sub": new_user.username, "id": new_user.id}
    token = create_access_token(token_data)

    return {"access_token": token, "token_type": "bearer"}


@app.put("/itens/{item_id}", response_model=ItemResponse)
def update_item(
    item_id: int,
    item_update: ItemUpdate,
    db: Session = Depends(get_db),
    user: Usuario = Depends(get_current_user)
):
    db_item = db.query(Item).filter(Item.id == item_id).first()

    if not db_item:
        raise HTTPException(status_code=404, detail="Item não encontrado")

    if db_item.usuario_id != user.id:
        raise HTTPException(status_code=403, detail="Acesso não autorizado")

    # Atualizar apenas os campos fornecidos
    update_data = item_update.dict(exclude_unset=True)
    for field, value in update_data.items():
        setattr(db_item, field, value)

    db.commit()
    db.refresh(db_item)
    return db_item


@app.delete("/itens/{item_id}")
def delete_item(
    item_id: int,
    db: Session = Depends(get_db),
    user: Usuario = Depends(get_current_user)
):
    db_item = db.query(Item).filter(Item.id == item_id).first()

    if not db_item:
        raise HTTPException(status_code=404, detail="Item não encontrado")

    if db_item.usuario_id != user.id:
        raise HTTPException(status_code=403, detail="Acesso não autorizado")

    db.delete(db_item)
    db.commit()
    return {"message": "Item excluído com sucesso"}


@app.post("/upload/image")
async def upload_image(file: UploadFile = File(...)):
    # Criar diretório de uploads se não existir
    upload_dir = "uploads"
    os.makedirs(upload_dir, exist_ok=True)

    # Gerar nome único para o arquivo
    file_extension = file.filename.split(
        ".")[-1] if "." in file.filename else "jpg"
    unique_filename = f"{uuid.uuid4()}.{file_extension}"
    file_path = os.path.join(upload_dir, unique_filename)

    # Salvar arquivo
    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    # Retornar URL da imagem
    image_url = f"http://localhost:8000/static/uploads/{unique_filename}"
    return {"image_url": image_url}


@app.get("/itens", response_model=list[ItemResponse])
def listar_itens(
    categoria: Optional[str] = None,
    local: Optional[str] = None,
    status: Optional[str] = None,
    db: Session = Depends(get_db)
):
    query = db.query(Item)

    if categoria:
        query = query.filter(Item.categoria == categoria)
    if local:
        query = query.filter(Item.local == local)
    if status:
        query = query.filter(Item.status == status)

    return query.all()


@app.get("/itens/mine", response_model=list[ItemResponse])
def listar_meus_itens(
    db: Session = Depends(get_db),
    user: Usuario = Depends(get_current_user)
):
    return db.query(Item).filter(Item.usuario_id == user.id).all()

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
        titulo=item.titulo,
        descricao=item.descricao,
        categoria=item.categoria,
        local=item.local,
        status=item.status,
        imagem_url=item.imagem_url,
        usuario_id=user.id
    )
    db.add(novo_item)
    db.commit()
    db.refresh(novo_item)
    return novo_item


@app.get("/itens/{item_id}", response_model=ItemResponse)
def detalhe_item(item_id: int, db: Session = Depends(get_db)):
    item = db.query(Item).filter(Item.id == item_id).first()
    if not item:
        raise HTTPException(status_code=404, detail="Item não encontrado")
    return item
