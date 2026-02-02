# 🎨 Paleta de Cores - Achados e Perdidos

Documentação oficial da paleta de cores do aplicativo Flutter "Achados e Perdidos".

---

## 📊 Cores Principais

### 🔴 Vermelho (Primária)
- **HEX**: `#FF0000`
- **RGB**: `rgb(255, 0, 0)`
- **Uso**: Alertas, erros, ações de destaque crítico

### 🔵 Azul (Secundária)
- **HEX**: `#1E90FF`
- **RGB**: `rgb(30, 144, 255)`
- **Uso**: Links, informações, ações secundárias

### 💚 Verde Lima (Sucesso)
- **HEX**: `#CDDC39`
- **RGB**: `rgb(205, 220, 57)`
- **Uso**: Sucesso, confirmações, botões principais, ícones de destaque

### ⚫ Cinza Escuro
- **HEX**: `#797979`
- **RGB**: `rgb(121, 121, 121)`
- **Uso**: Textos secundários, bordas, ícones inativos

### ⚪ Branco Gelo
- **HEX**: `#F7F7F7`
- **RGB**: `rgb(247, 247, 247)`
- **Uso**: Fundos, cards, áreas de destaque

### ⬜ Branco Puro
- **HEX**: `#FFFFFF`
- **RGB**: `rgb(255, 255, 255)`
- **Uso**: Fundos principais, textos em fundos escuros

### ⬛ Preto
- **HEX**: `#171717`
- **RGB**: `rgb(23, 23, 23)`
- **Uso**: Textos principais, elementos de alto contraste

---

## 🎯 Aplicação das Cores

### Telas de Login e Cadastro
- **Cor Principal**: Verde Lima (`#CDDC39`)
- **Fundo**: Branco Gelo (`#F7F7F7`)
- **Cards**: Branco Puro (`#FFFFFF`)
- **Textos**: Preto (`#171717`)
- **Bordas**: Cinza Escuro (`#797979`)
- **Links**: Azul (`#1E90FF`)
- **Alertas**: Vermelho (`#FF0000`)

### Gradientes
- **Verde**: `#CDDC39` → `#CDDC39` com 80% opacidade
- **Sombras**: Cor base com 30-40% opacidade

---

## 📱 Implementação no Flutter

As cores estão definidas no arquivo `lib/core/theme/app_colors.dart`:

```dart
class AppColors {
  // Cores Principais
  static const Color primary = Color(0xFFCDDC39);      // Verde Lima
  static const Color secondary = Color(0xFF1E90FF);    // Azul
  static const Color error = Color(0xFFFF0000);        // Vermelho
  
  // Neutros
  static const Color black = Color(0xFF171717);        // Preto
  static const Color grey = Color(0xFF797979);         // Cinza
  static const Color iceWhite = Color(0xFFF7F7F7);     // Branco Gelo
  static const Color white = Color(0xFFFFFFFF);        // Branco Puro
  
  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xCCCDDC39)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
```

---

## 🔄 Histórico de Alterações

### v1.0 - 02/02/2026
- ✅ Definição inicial da paleta de cores
- ✅ Implementação nas telas de Login e Cadastro
- ✅ Substituição de `GFColors.SUCCESS` por cor customizada `#CDDC39`

---

**Última atualização**: 02/02/2026
