Vou analisar o backend 'api-itens-perdidos' e compará-lo com os requisitos funcionais da aplicação frontend Flutter para identificar discrepâncias e necessidades de implementação. Primeiro, preciso entender melhor a estrutura de ambos os sistemas.


Agora, vou examinar os arquivos principais do backend para entender as rotas, modelos e autenticação:


Agora, vou examinar os arquivos do frontend Flutter para entender quais funcionalidades são esperadas:


Vou agora analisar o código existente e identificar as lacunas entre o backend e as necessidades do frontend. Primeiro, vou criar uma análise detalhada para mapear as diferenças.


Vamos analisar as rotas e endpoints disponíveis no backend Python/FastAPI:

**Endpoints do Backend:**

1. `POST /token` - Para autenticação e obtenção de token JWT
2. `GET /usuarios/me` - Para obter informações do usuário autenticado
3. `POST /itens` - Para criar um novo item perdido/encontrado
4. `GET /itens` - Para listar todos os itens
5. `GET /itens/{item_id}` - Para obter detalhes de um item específico

Agora, vamos atualizar a tarefa e passar para a próxima:


Vamos comparar os modelos de dados do backend com os modelos do frontend Flutter:

**Modelo do Backend (models.py e schemas.py):**
- **Usuario**: id, username, password
- **Item**: id, titulo, descricao, categoria, local, status, usuario_id
- **ItemCreate (schema)**: titulo, descricao, categoria, local, status
- **ItemResponse (schema)**: id, titulo, descricao, categoria, local, status, usuario_id

**Modelo do Frontend (lost_item.dart):**
- **LostItem**: id, title, imageUrl, isFound, description, location, category
- O modelo usa `isFound` (booleano) para distinguir entre perdido/encontrado
- Usa `imageUrl` para imagem do item
- Usa `title` em vez de `titulo`
- Usa `location` em vez de `local`
- Usa `description` em vez de `descricao`
- Tem campo `category` semelhante ao backend

**Discrepâncias identificadas:**
1. O backend não tem campo para imagem (`imageUrl`)
2. O backend não distingue claramente entre "perdido" e "encontrado" - apenas tem um campo `status` genérico
3. Diferenças de nomenclatura: `title` vs `titulo`, `location` vs `local`, `description` vs `descricao`

Vamos atualizar esta tarefa e passar para a próxima:


Vamos verificar a estrutura de autenticação e autorização implementada:

**Autenticação no Backend:**
- Utiliza JWT (JSON Web Token) com OAuth2PasswordBearer
- Rota `/token` para login que retorna `access_token` e `token_type`
- Função `authenticate_user()` para verificar credenciais
- Função `get_current_user()` para obter usuário autenticado a partir do token
- O token é necessário para acessar rotas protegidas como `/itens` (criação)
- O usuário autenticado é associado aos itens criados via `usuario_id`

**Requisitos de Autenticação no Frontend:**
- Tela de login (login_screen.dart) - implementada
- Tela de registro (register_screen.dart) - implementada (mas apenas simulação)
- O frontend parece estar preparado para armazenar e usar tokens JWT

**Discrepâncias:**
1. O backend não tem endpoint para registro de novos usuários
2. O frontend tem uma tela de registro, mas o backend não suporta criação de usuários

Vamos atualizar esta tarefa:


Vamos identificar funcionalidades do frontend que não têm suporte no backend:

**Funcionalidades do Frontend:**
1. **Registro de usuário** - A tela de registro existe, mas não há endpoint correspondente no backend
2. **Upload de imagens** - O modelo `LostItem` tem campo `imageUrl`, mas o backend não suporta upload de imagens
3. **Distinção clara entre perdido/encontrado** - O frontend usa `isFound` (booleano), mas o backend só tem `status` (string genérica)
4. **Edição de itens** - O frontend permite visualizar/editar itens, mas o backend não tem endpoint PUT/PATCH para edição
5. **Exclusão de itens** - O frontend tem funcionalidade de exclusão, mas o backend não tem endpoint DELETE para itens
6. **Filtragem avançada** - O frontend parece preparado para filtros por categoria, localização, etc., mas o backend não tem endpoints com esses parâmetros
7. **Atualização de status** - O frontend distingue entre "Perdido" e "Encontrado", mas o backend não tem lógica específica para isso

Vamos atualizar esta tarefa:


Vamos mapear as lacunas identificadas entre frontend e backend:

## Mapeamento de Lacunas entre Frontend e Backend

### 1. Funcionalidades Ausentes no Backend

| Requisito do Frontend | Status no Backend | Impacto |
|----------------------|-------------------|---------|
| Registro de novos usuários | Não implementado | Crítico - tela de cadastro não funciona |
| Upload de imagens para itens | Não implementado | Médio - campo `imageUrl` não é preenchido |
| Distinção entre "Perdido" e "Encontrado" | Apenas campo genérico `status` | Médio - lógica de negócios não clara |
| Edição de itens existentes | Não implementado | Médio - não é possível atualizar itens |
| Exclusão de itens | Não implementado | Médio - não é possível remover itens |
| Filtragem avançada de itens | Não implementada | Baixo/Médio - não é possível filtrar por critérios |

### 2. Inconsistências de Modelos de Dados

| Campo | Frontend | Backend | Compatibilidade |
|-------|----------|---------|-----------------|
| Título | `title` | `titulo` | Nomenclatura diferente |
| Localização | `location` | `local` | Nomenclatura diferente |
| Descrição | `description` | `descricao` | Nomenclatura diferente |
| Status | `isFound` (booleano) | `status` (string) | Tipagem e lógica diferentes |
| Imagem | `imageUrl` | Ausente | Campo ausente no backend |

### 3. Endpoint Faltantes

| Operação | Método | Endpoint | Descrição |
|----------|--------|----------|-----------|
| Registro de usuário | POST | `/users/register` | Criar novos usuários |
| Atualização de usuário | PUT/PATCH | `/users/me` | Atualizar perfil do usuário |
| Atualização de item | PUT/PATCH | `/itens/{id}` | Editar item existente |
| Exclusão de item | DELETE | `/itens/{id}` | Remover item |
| Upload de imagem | POST | `/upload/image` | Fazer upload de imagens |
| Filtragem de itens | GET | `/itens?categoria=&local=&status=` | Filtrar itens por critérios |

### 4. Problemas de Autenticação

| Aspecto | Situação | Observação |
|---------|----------|------------|
| Registro de usuários | Não disponível | Apenas usuário "admin" pré-configurado |
| Recuperação de senha | Não implementada | Nenhuma funcionalidade de recuperação |
| Atualização de perfil | Não disponível | Não é possível editar dados do usuário |

Vamos atualizar esta tarefa:


Vamos propor as alterações necessárias no backend para garantir compatibilidade com o frontend:

## Proposta de Alterações no Backend

### 1. Novos Endpoints

#### A. Registro de Usuários
```python
@app.post("/users/register")
def register_user(
    username: str,
    password: str,
    db: Session = Depends(get_db)
):
    # Verifica se o usuário já existe
    existing_user = db.query(Usuario).filter(Usuario.username == username).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="Usuário já existe")
    
    # Criptografa a senha (idealmente usando hashing)
    hashed_password = password  # Deveria usar bcrypt
    
    # Cria novo usuário
    new_user = Usuario(username=username, password=hashed_password)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    # Retorna token para login automático
    token = create_access_token({"sub": new_user.username, "id": new_user.id})
    return {"access_token": token, "token_type": "bearer"}
```

#### B. Endpoints CRUD para Itens
```python
@app.put("/itens/{item_id}", response_model=ItemResponse)
def update_item(
    item_id: int,
    item: ItemCreate,  # ou um novo schema ItemUpdate
    db: Session = Depends(get_db),
    user: Usuario = Depends(get_current_user)
):
    db_item = db.query(Item).filter(Item.id == item_id).first()
    if not db_item:
        raise HTTPException(status_code=404, detail="Item não encontrado")
    
    if db_item.usuario_id != user.id:
        raise HTTPException(status_code=403, detail="Acesso não autorizado")
    
    # Atualiza campos
    for key, value in item.dict().items():
        setattr(db_item, key, value)
    
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
```

### 2. Atualização dos Modelos

#### A. Modificação do Modelo Item
```python
class Item(Base):
    __tablename__ = "itens"

    id = Column(Integer, primary_key=True, index=True)
    titulo = Column(String)
    descricao = Column(String)
    categoria = Column(String)
    local = Column(String)
    status = Column(String)  # "lost" ou "found"
    imagem_url = Column(String)  # Novo campo para URL da imagem
    usuario_id = Column(Integer, ForeignKey("usuarios.id"))
    usuario = relationship("Usuario", back_populates="itens")
```

#### B. Atualização dos Schemas
```python
class ItemCreate(BaseModel):
    titulo: str
    descricao: str
    categoria: str
    local: str
    status: str  # Deve ser "lost" ou "found"
    imagem_url: Optional[str] = None  # Novo campo opcional

class ItemUpdate(ItemCreate):
    titulo: Optional[str] = None
    descricao: Optional[str] = None
    categoria: Optional[str] = None
    local: Optional[str] = None
    status: Optional[str] = None
    imagem_url: Optional[str] = None
```

### 3. Sistema de Upload de Imagens

Adicionar rota para upload de imagens:
```python
from fastapi import UploadFile, File
import uuid
import os

@app.post("/upload/image")
async def upload_image(file: UploadFile = File(...)):
    # Gera nome único para arquivo
    file_extension = file.filename.split(".")[-1]
    unique_filename = f"{uuid.uuid4()}.{file_extension}"
    
    # Caminho para salvar
    upload_dir = "uploads/"
    os.makedirs(upload_dir, exist_ok=True)
    file_path = os.path.join(upload_dir, unique_filename)
    
    # Salva arquivo
    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)
    
    # Retorna URL da imagem
    image_url = f"/static/images/{unique_filename}"
    return {"image_url": image_url}
```

### 4. Melhorias na Autenticação

Adicionar criptografia de senha:
```python
from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    return pwd_context.hash(password)
```

### 5. Endpoints de Filtragem

```python
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
```

Vamos atualizar a última tarefa:


Vou agora criar um plano detalhado com todas as modificações necessárias no backend para garantir compatibilidade total com o frontend Flutter.

# Plano de Modificação do Backend

## Resumo da Análise

Após análise completa do backend `api-itens-perdidos` e do frontend Flutter, identifiquei várias lacunas críticas que impedem a integração adequada entre ambos os sistemas.

## Lacunas Identificadas

### 1. Funcionalidades Críticas Ausentes
- **Registro de novos usuários**: O frontend tem tela de cadastro, mas o backend não tem endpoint correspondente
- **Endpoint de exclusão de itens**: O frontend permite excluir itens, mas o backend não suporta essa operação
- **Endpoint de edição de itens**: O frontend permite edição, mas o backend não tem suporte

### 2. Inconsistências nos Modelos de Dados
- O frontend usa `isFound` (booleano) para distinguir entre perdido/encontrado, enquanto o backend tem apenas um campo `status` genérico
- O frontend espera um campo `imageUrl` para imagens, que não existe no backend
- Diferenças de nomenclatura: `title` vs `titulo`, `location` vs `local`, `description` vs `descricao`

### 3. Recursos Avançados Faltantes
- Upload de imagens para itens
- Filtragem avançada de itens
- Atualização de perfis de usuário

## Modificações Necessárias

### Etapa 1: Atualizar o modelo de dados

Vamos modificar o arquivo `models.py` para adicionar os campos necessários:

```python
from sqlalchemy import Column, Integer, String, ForeignKey, Boolean
from database import Base

class Usuario(Base):
    __tablename__ = "usuarios"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True)
    password = Column(String)  # Deveria ser hash da senha

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
```

### Etapa 2: Atualizar os schemas do Pydantic

Vamos atualizar o arquivo `schemas.py` para refletir as mudanças:

```python
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
```

### Etapa 3: Implementar endpoints de registro de usuários

Vamos adicionar ao arquivo `app.py`:

```python
from fastapi import FastAPI, Depends, HTTPException, status, UploadFile, File
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from jose import jwt, JWTError
from pydantic import BaseModel
from datetime import datetime, timedelta
from sqlalchemy import create_engine, and_, or_
from sqlalchemy.orm import sessionmaker
from typing import Optional
import uuid
import shutil
import os

# ... (partes existentes do código permanecem iguais até a seção de autenticação)

# Adicionando função para hash de senha (deveria usar bcrypt em produção)
def fake_hash_password(password: str):
    return password  # Isso é apenas para demonstração - usar bcrypt em produção

# Endpoint para registro de novos usuários
@app.post("/users/register", response_model=Token)
def register_user(user: UserCreate, db: Session = Depends(get_db)):
    # Verificar se o usuário já existe
    existing_user = db.query(Usuario).filter(Usuario.username == user.username).first()
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Username já está em uso"
        )
    
    # Criar novo usuário com senha hash
    hashed_password = fake_hash_password(user.password)
    new_user = Usuario(username=user.username, password=hashed_password)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    # Gerar token para o novo usuário
    token_data = {"sub": new_user.username, "id": new_user.id}
    token = create_access_token(token_data)
    
    return {"access_token": token, "token_type": "bearer"}

# Endpoint para atualizar itens
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

# Endpoint para deletar itens
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

# Endpoint para upload de imagens
@app.post("/upload/image")
async def upload_image(file: UploadFile = File(...)):
    # Criar diretório de uploads se não existir
    upload_dir = "uploads"
    os.makedirs(upload_dir, exist_ok=True)
    
    # Gerar nome único para o arquivo
    file_extension = file.filename.split(".")[-1] if "." in file.filename else "jpg"
    unique_filename = f"{uuid.uuid4()}.{file_extension}"
    file_path = os.path.join(upload_dir, unique_filename)
    
    # Salvar arquivo
    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)
    
    # Retornar URL da imagem
    image_url = f"http://localhost:8000/static/uploads/{unique_filename}"
    return {"image_url": image_url}

# Endpoint para buscar itens com filtros
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

# Adicionando endpoint para obter itens do usuário logado
@app.get("/itens/mine", response_model=list[ItemResponse])
def listar_meus_itens(
    db: Session = Depends(get_db),
    user: Usuario = Depends(get_current_user)
):
    return db.query(Item).filter(Item.usuario_id == user.id).all()
```

### Etapa 4: Melhorias de segurança

Para implementar corretamente a segurança, seria ideal adicionar bcrypt:

```bash
pip install bcrypt
```

E então atualizar a função de hash de senha:

```python
from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    return pwd_context.hash(password)
```

## Implementação no Backend

A seguir, vou implementar todas as modificações necessárias nos arquivos do backend:


Percebi que esqueci de importar o `relationship` no modelo. Vou corrigir isso:


Agora vou atualizar o arquivo schemas.py:


Agora vou atualizar o arquivo principal app.py com todos os endpoints necessários:


Agora vamos testar se o backend está funcionando corretamente com as novas funcionalidades. Primeiro, vamos iniciar o servidor:

