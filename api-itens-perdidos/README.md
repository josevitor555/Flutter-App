# 📦 API de Itens Perdidos e Encontrados

API desenvolvida em **Python com FastAPI** como trabalho final da disciplina.  
A API é responsável por gerenciar **usuários** e **itens perdidos/encontrados**, sendo consumida por um aplicativo externo.

---

## 🚀 Tecnologias

- Python 3
- FastAPI
- Uvicorn
- JWT (JSON Web Token)
- SQLAlchemy
- Pydantic
- SQLite
- Docker
- Docker Compose
- UV (gerenciamento de dependências)

---

## 📁 Estrutura do Projeto

.
├── app.py
├── database.py
├── models.py
├── schemas.py
├── seed.py
├── key.key
├── database.db
├── docker-compose.yml
├── pyproject.toml
├── /docs
└── README.md


---

## 🔐 Autenticação (JWT)

A API utiliza **JWT** para autenticação.

### Fluxo:
1. Usuário envia **username** e **password**
2. API gera um **token JWT**
3. O token é usado para acessar rotas protegidas

---

## 👤 Usuário de teste (Seed)

Usuário criado automaticamente ao iniciar a API:

username: admin
password: 123


---

## 🔓 Como autenticar no Swagger

1. Acesse:
http://localhost:8000/docs


2. Use o endpoint:
POST /token


3. Envie:
```json
{
  "username": "admin",
  "password": "123"
}
Copie o access_token

Clique em Authorize e cole:

Bearer SEU_TOKEN_AQUI
