from pydantic import BaseModel

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
