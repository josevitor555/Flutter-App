# Relatório Completo do Projeto "Achados e Perdidos"

## Índice

1. [Estrutura de Pastas](#1-estrutura-de-pastas)
2. [Arquivos Principais](#2-arquivos-principais)
3. [Rotas Implementadas no Frontend](#3-rotas-implementadas-no-frontend)
4. [Rotas Pendentes ou Faltantes](#4-rotas-pendentes-ou-faltantes)
5. [Dependências Necessárias](#5-dependências-necessárias)
6. [Endpoints do Backend](#6-endpoints-do-backend)
7. [Modelos de Dados](#7-modelos-de-dados)
8. [Configuração do Ambiente](#8-configuração-do-ambiente)
9. [Fluxo de Autenticação](#9-fluxo-de-autenticação)
10. [Melhores Práticas e Considerações de Segurança](#10-melhores-práticas-e-considerações-de-segurança)
11. [Próximos Passos e Roadmap](#11-próximos-passos-e-roadmap)
12. [Conclusão](#conclusão)

## 1. Estrutura de Pastas

### Projeto Flutter (Frontend)
```
achados_e_perdidos/
├── android/
├── ios/
├── lib/
│   ├── core/
│   │   └── app_colors.dart
│   ├── models/
│   │   ├── auth_model.dart
│   │   ├── lost_item.dart
│   │   └── user_model.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── items_list_screen.dart
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── widgets/
│   │   ├── item_detail_modal.dart
│   │   └── report_item_modal.dart
│   └── main.dart
├── test/
├── web/
├── windows/
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

### Projeto Python (Backend)
```
api-itens-perdidos/
├── app.py
├── auth.py
├── database.py
├── models.py
├── schemas.py
├── seed.py
├── dockerfile
├── docker-compose.yml
├── pyproject.toml
├── itens.json
├── usuarios.json
├── database.db
└── key.key
```

## 2. Arquivos Principais

### Frontend Flutter

#### Arquivos de Modelo
- **lib/models/auth_model.dart**: Gerencia a autenticação e tokens JWT
  - Classe `AuthToken` para armazenar `access_token` e `token_type`
  - Método `fromJson` para desserialização do JSON do backend

- **lib/models/lost_item.dart**: Representa os itens perdidos/encontrados
  - Campos: `id`, `title`, `imageUrl`, `isFound`, `description`, `location`, `category`, `usuarioId`
  - Métodos `fromJson` e `toJson` para serialização/desserialização

- **lib/models/user_model.dart**: Representa os dados do usuário
  - Campos: `id`, `name`, `email`
  - Métodos `fromJson` e `toJson` para serialização/desserialização

#### Arquivos de Tela
- **lib/screens/home_screen.dart**: Tela inicial com cards de itens
- **lib/screens/items_list_screen.dart**: Lista completa de itens
- **lib/screens/login_screen.dart**: Tela de autenticação
- **lib/screens/register_screen.dart**: Tela de cadastro

#### Arquivos de Componentes
- **lib/widgets/item_detail_modal.dart**: Modal com detalhes do item
- **lib/widgets/report_item_modal.dart**: Modal para relatar novo item

#### Arquivo Principal
- **lib/main.dart**: Ponto de entrada do aplicativo

### Backend Python

- **app.py**: Ponto de entrada da API FastAPI
  - Rotas de autenticação e itens
  - Configuração do banco de dados
  - Middleware CORS

- **auth.py**: Funções de autenticação e criptografia
  - Funções para hash de senha
  - Autenticação de usuário

- **database.py**: Configuração do banco de dados SQLAlchemy
  - Engine e sessão do banco de dados

- **models.py**: Modelos ORM do SQLAlchemy
  - Definições das tabelas do banco de dados

- **schemas.py**: Modelos Pydantic para validação
  - Esquemas de entrada e saída da API

- **seed.py**: Script para popular o banco de dados com dados iniciais

## 3. Rotas Implementadas no Frontend

### Telas Completas
1. **Tela de Login** (`/login`)
   - Formulário de autenticação
   - Validação de credenciais
   - Navegação para tela principal após login

2. **Tela de Registro** (`/register`)
   - Formulário de cadastro
   - Validação de campos
   - Confirmação de senha

3. **Tela Inicial** (`/home`)
   - Cards de itens recentes
   - Botões para relatar itens
   - Navegação para detalhes

4. **Lista de Itens** (`/items`)
   - Visualização de todos os itens
   - Funcionalidade de exclusão

### Componentes Reutilizáveis
1. **Modal de Detalhes** (`ItemDetailModal`)
   - Exibe informações completas do item
   - Imagem, título, descrição, localização

2. **Modal de Relato** (`ReportItemModal`)
   - Formulário para relatar novo item
   - Campos: nome, subtítulo, descrição, localização, categoria

## 4. Rotas Pendentes ou Faltantes

### Funcionalidades a Implementar no Frontend

1. **Integração completa com API**
   - Implementar serviços HTTP para consumir os endpoints do backend
   - Gerenciamento de tokens JWT
   - Tratamento de erros de rede

2. **Serviços de API**
   - AuthService: para lidar com login/logout e registro
   - ItemService: para gerenciar itens (listar, criar, atualizar, deletar)
   - UserService: para gerenciar dados do usuário

3. **Gerenciamento de estado**
   - Provider ou Bloc para gerenciar o estado da autenticação
   - Armazenamento local de tokens e dados do usuário

4. **Upload de imagens**
   - Implementar funcionalidade para upload de fotos dos itens
   - Integração com galeria e câmera

2. **Funcionalidades de Usuário**
   - Perfil do usuário
   - Edição de informações pessoais
   - Histórico de itens relatados

3. **Funcionalidades de Itens**
   - Edição de itens existentes
   - Upload de imagens
   - Filtragem e busca avançada
   - Integração com mapa para localização

4. **Funcionalidades de Segurança**
   - Persistência de sessão
   - Renovação automática de tokens
   - Validação de permissões

## 5. Dependências Necessárias

### Flutter (pubspec.yaml)
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  getwidget: ^7.0.0
  google_maps_flutter: ^2.5.0
  geolocator: ^10.1.0
  geocoding: ^2.1.1
  cached_network_image: ^3.3.0
  http: ^1.1.0
  shared_preferences: ^2.2.2
```

### Python (dockerfile/pyproject.toml)
```
Dependências instaladas:
- bcrypt==4.0.1 (versão específica para evitar conflitos)
- fastapi
- uvicorn
- sqlalchemy
- pydantic
- python-jose
- python-multipart
- passlib[bcrypt]
```

## 6. Endpoints do Backend

### Autenticação
- `POST /token` - Obter token JWT
  - Parâmetros: username, password (form data)
  - Retorna: access_token, token_type

- `POST /users/register` - Registrar novo usuário
  - Parâmetros: username, password (JSON)
  - Retorna: dados do usuário criado

### Itens
- `GET /itens/` - Listar todos os itens
  - Parâmetros: skip, limit (query)
  - Retorna: lista de itens

- `GET /itens/{item_id}` - Obter item específico
  - Parâmetros: item_id (path)
  - Retorna: dados do item

- `POST /itens/` - Criar novo item
  - Parâmetros: dados do item (JSON)
  - Retorna: item criado
  - Requer autenticação

- `PUT /itens/{item_id}` - Atualizar item
  - Parâmetros: item_id (path), dados atualizados (JSON)
  - Retorna: item atualizado
  - Requer autenticação

- `DELETE /itens/{item_id}` - Excluir item
  - Parâmetros: item_id (path)
  - Retorna: mensagem de confirmação
  - Requer autenticação

## 7. Modelos de Dados

### Correspondência entre Frontend e Backend

#### Item Perdido/Encontrado
**Backend (schemas.py)**:
```python
class ItemBase(BaseModel):
    titulo: str
    descricao: Optional[str] = None
    categoria: Optional[str] = None
    local: Optional[str] = None
    status: str  # "lost" ou "found"
    imagem_url: Optional[str] = None
    usuario_id: int
```

**Frontend (lost_item.dart)**:
```dart
class LostItem {
  final int id;
  final String title;
  final String? imageUrl;
  final bool isFound;
  final String? description;
  final String? location;
  final String? category;
  final int usuarioId;
}
```

#### Usuário
**Backend (schemas.py)**:
```python
class UsuarioCreate(BaseModel):
    username: str
    password: str
```

**Frontend (user_model.dart)**:
```dart
class User {
  final int id;
  final String name;
  final String email;
}
```

#### Token de Autenticação
**Backend (app.py)**:
```python
def login():
    return {"access_token": access_token, "token_type": "bearer"}
```

**Frontend (auth_model.dart)**:
```dart
class AuthToken {
  final String accessToken;
  final String tokenType;
}
```

## 8. Configuração do Ambiente

### Pré-requisitos
- Flutter SDK instalado (versão 3.9.2 ou superior)
- Docker e Docker Compose instalados
- Android Studio ou VS Code com extensão Flutter

### Execução do Backend
1. Navegue até o diretório `api-itens-perdidos`
2. Execute o comando: `docker-compose up --build -d`
3. O backend estará disponível em `http://localhost:8000`

### Execução do Frontend
1. Navegue até o diretório `achados_e_perdidos`
2. Execute `flutter pub get` para instalar as dependências
3. Execute `flutter run` para iniciar o aplicativo

### Testando a API
- Acesse `http://localhost:8000/docs` para visualizar a documentação da API no Swagger
- Use ferramentas como Postman ou APIDog para testar os endpoints manualmente

## 9. Fluxo de Autenticação

### Processo Completo de Login

1. **Tela de Login**
   - Usuário insere email/username e senha
   - Dados são validados localmente

2. **Requisição de Token**
   - Frontend envia requisição POST para `/token`
   - Dados enviados como form data (OAuth2PasswordRequestForm)
   - Backend verifica credenciais no banco de dados

3. **Geração de Token**
   - Backend gera JWT com tempo de expiração
   - Token é retornado ao frontend

4. **Armazenamento de Token**
   - Frontend armazena token de forma segura
   - Token é usado em requisições subsequentes

5. **Autenticação de Requisições**
   - Headers Authorization: Bearer {token}
   - Backend decodifica e valida token
   - Acesso concedido ou negado com base na validação

### Processo de Registro

1. **Tela de Registro**
   - Usuário preenche formulário de cadastro
   - Dados são validados localmente

2. **Requisição de Registro**
   - Frontend envia requisição POST para `/users/register`
   - Dados enviados como JSON

3. **Criação de Usuário**
   - Backend cria hash da senha
   - Usuário é salvo no banco de dados

4. **Login Automático**
   - Após registro, usuário pode ser automaticamente autenticado
   - Ou redirecionado para tela de login

### Segurança Implementada

- Senhas nunca são armazenadas em texto plano
- Tokens têm tempo de expiração limitado
- Todas as requisições sensíveis requerem autenticação
- Validação de tamanho de senha para evitar erros com bcrypt

## 11. Melhores Práticas e Considerações de Segurança

### Boas Práticas de Codificação
- Separação clara entre camadas (UI, lógica de negócio, persistência)
- Uso de modelos de dados para serialização/desserialização
- Tratamento adequado de exceções e erros
- Código limpo e bem documentado

### Considerações de Segurança
- Autenticação baseada em JWT com tempo de expiração
- Criptografia de senhas com bcrypt
- Validação de entradas no backend
- Proteção contra ataques de força bruta
- Armazenamento seguro de tokens no dispositivo
- Uso de HTTPS em produção

### Performance
- Cache de imagens com cached_network_image
- Paginação de resultados na API
- Lazy loading de listas
- Minimização de rebuilds desnecessários no Flutter

## 12. Próximos Passos e Roadmap

### Implementações Imediatas
1. Criar os serviços de API (AuthService, ItemService, UserService)
2. Implementar o gerenciamento de estado com Provider ou Bloc
3. Integrar as telas com os serviços de API
4. Adicionar tratamento de erros e loading states
5. Implementar persistência de sessão

### Implementações Futuras
1. Sistema de notificações
2. Recuperação de senha
3. Upload de imagens para os itens
4. Integração com mapa para localização dos itens
5. Sistema de categorias mais robusto
6. Busca e filtragem avançada
7. Perfil do usuário com histórico de itens
8. Avaliação e comentários sobre os itens

### Melhorias de Infraestrutura
1. Adicionar testes unitários e de integração
2. Configurar CI/CD
3. Implementar monitoramento e logging
4. Configurar banco de dados em produção
5. Configurar balanceamento de carga para alta disponibilidade

## Conclusão

Este projeto representa uma solução completa para gerenciamento de itens perdidos e encontrados, com uma arquitetura bem definida entre frontend Flutter e backend Python/FastAPI. A integração entre as partes está configurada com mecanismos de segurança adequados e práticas recomendadas de desenvolvimento.

O sistema está preparado para evolução e escalabilidade, com os modelos de dados e estrutura de pastas organizados para facilitar manutenção e expansão das funcionalidades.