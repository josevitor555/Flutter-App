# 🔐 Telas de Login e Cadastro - Achados e Perdidos

Documentação das telas de autenticação do aplicativo Flutter "Achados e Perdidos", desenvolvidas com **GetWidget** e **Material UI**.

---

## 🎨 Características do Design

### Tela de Login (`lib/screens/login_screen.dart`)

✨ **Recursos:**
- 🎨 **Card Material UI** com elevação e sombras suaves
- 🌟 **Hero Animation** no logo para transição suave entre telas
- 💚 **Gradiente verde** no logo e botão principal
- 💎 **Chip decorativo** "Login Seguro" com ícone
- 📧 Campos de email e senha com validação e ícones coloridos em verde
- 👁️ Botão para mostrar/ocultar senha
- ☑️ Checkbox "Lembrar-me" (circular do GetWidget)
- 🔗 TextButton Material para "Esqueceu a senha?"
- 🎯 Botão de login com gradiente verde e sombra
- 🎨 Fundo cinza claro para destacar o card branco
- ✅ SnackBars flutuantes com ícones e bordas arredondadas
- 🧹 **Design clean** - sem botões de login social

### Tela de Cadastro (`lib/screens/register_screen.dart`)

✨ **Recursos:**
- 🎨 **Card Material UI** com elevação e design consistente
- 🌟 **Hero Animation** compartilhada com tela de login
- 💚 **Gradiente verde** consistente (mesma cor do login)
- 💎 **Chip decorativo** "Cadastro Rápido" com ícone
- 📋 Formulário simplificado com **4 campos** validados:
  - Nome completo
  - Email
  - Senha
  - Confirmar senha
- 🎨 Ícones coloridos em verde nos campos
- ✅ Validação robusta em todos os campos
- ☑️ Checkbox para aceitar termos (verde)
- 🔗 Links clicáveis para termos e política
- 🎯 Botão de cadastro com gradiente verde e sombra
- ↩️ Botão voltar customizado com sombra
- 🎨 Fundo cinza claro consistente
- ✅ SnackBars flutuantes melhorados
- 🧹 **Design clean** - sem campo de telefone e sem botões sociais

## 🎨 Componentes Material UI Adicionados

### Componentes Material:
- `Card` - Container principal com elevação e sombras
- `Chip` - Badges decorativos informativos
- `Hero` - Animação de transição entre telas
- `SnackBar` com `SnackBarBehavior.floating` - Notificações flutuantes
- `TextButton` - Botões de texto do Material Design
- `ElevatedButton` - Botão principal com gradiente customizado
- `LinearGradient` - Gradientes nos botões e logo
- `BoxShadow` - Sombras suaves e profundidade

### Componentes GetWidget:
- `GFCheckbox` - Checkboxes circulares
- `GFColors.SUCCESS` - Cor verde padrão em TUDO
- `GFColors.WARNING` - Avisos em amarelo

## 🔒 Validações Implementadas

### Login:
- ✅ Email obrigatório e formato válido (deve conter @)
- ✅ Senha obrigatória com mínimo de 6 caracteres

### Cadastro:
- ✅ Nome obrigatório com mínimo de 3 caracteres
- ✅ Email obrigatório e formato válido (deve conter @ e .)
- ✅ Senha obrigatória com mínimo de 6 caracteres
- ✅ Confirmação de senha deve coincidir com a senha
- ✅ Termos de uso devem ser aceitos antes do cadastro

## 🎨 Paleta de Cores

**Cor Principal: Verde (`GFColors.SUCCESS`)**

- **Login e Cadastro**: Verde (`GFColors.SUCCESS`) - Cor consistente em ambas as telas
- **Gradientes**: Verde com opacidade variável para profundidade
- **Avisos**: Amarelo (`GFColors.WARNING`)
- **Fundo**: Cinza claro (`Colors.grey.shade100`)
- **Cards**: Branco puro com sombras
- **Campos**: Cinza claro (`Colors.grey.shade50`)
- **Bordas**: Cinza suave (`Colors.grey.shade300`)
- **Sombras**: Verde com opacidade para efeito de profundidade

**Nota**: A cor foi padronizada para **verde** em TODAS as telas para manter consistência visual!

## 📝 Próximos Passos

1. **Integração com Backend**
   - Conectar com API de autenticação
   - Implementar JWT ou similar para sessões

2. **Funcionalidades Adicionais**
   - Implementar recuperação de senha
   - Adicionar validação de email (código de verificação)
   - Implementar persistência de sessão (shared_preferences)

3. **Melhorias de UX**
   - Adicionar loading indicators durante requisições
   - Implementar animações de transição mais suaves
   - Adicionar feedback tátil (haptic feedback)

4. **Segurança**
   - Implementar rate limiting
   - Adicionar captcha se necessário
   - Criptografia de dados sensíveis

---

## 🚀 Como Usar

1. O app inicia na tela de **Login**
2. Usuários novos podem clicar em "Cadastre-se" para criar uma conta
3. Após cadastro bem-sucedido, o usuário retorna automaticamente para o login
4. Campos são validados em tempo real ao submeter o formulário
5. Mensagens de feedback são exibidas via SnackBars flutuantes

---

**Desenvolvido com ❤️ usando Flutter, GetWidget e Material UI**
