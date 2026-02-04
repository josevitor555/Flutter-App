from pydantic import BaseModel
from typing import Optional

class ItemBase(BaseModel):
    titulo: str
    descricao: str
    categoria: str
    local: str
    status: str  # "lost" ou "found"
    imagem_url: Optional[str] = None

class ItemCreate(ItemBase):
    pass

class ItemUpdate(BaseModel):
    titulo: Optional[str] = None
    descricao: Optional[str] = None
    categoria: Optional[str] = None
    local: Optional[str] = None
    status: Optional[str] = None
    imagem_url: Optional[str] = None

class ItemResponse(ItemBase):
    id: int
    usuario_id: int

    class Config:
        from_attributes = True

class UserCreate(BaseModel):
    username: str
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    username: Optional[str] = None
