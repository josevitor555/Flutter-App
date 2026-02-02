from database import SessionLocal, engine
from models import Base, Usuario, Item

Base.metadata.create_all(bind=engine)
db = SessionLocal()

if not db.query(Usuario).first():
    user = Usuario(username="admin", password="1234")
    db.add(user)
    db.commit()
    db.refresh(user)

    item = Item(
        titulo="Celular perdido",
        descricao="Samsung preto",
        categoria="Eletrônico",
        local="Biblioteca",
        status="Perdido",
        usuario_id=user.id
    )

    db.add(item)
    db.commit()

db.close()
