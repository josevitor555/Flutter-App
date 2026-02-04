from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from database import Base

class Usuario(Base):
    __tablename__ = "usuarios"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True)
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
