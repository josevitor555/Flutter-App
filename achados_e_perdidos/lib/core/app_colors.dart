import 'package:flutter/material.dart';

/// Paleta de cores oficial do aplicativo Achados e Perdidos
/// Baseada na paleta definida em PALETA_CORES.md
class AppColors {
  // Cores Principais
  static const Color primary = Color(0xFFCDDC39); // Verde Lima
  static const Color secondary = Color(0xFF1E90FF); // Azul
  static const Color error = Color(0xFFFF0000); // Vermelho

  // Neutros
  static const Color black = Color(0xFF171717); // Preto
  static const Color grey = Color(0xFF797979); // Cinza
  static const Color iceWhite = Color(0xFFF7F7F7); // Branco Gelo
  static const Color white = Color(0xFFFFFFFF); // Branco Puro

  // Variações da cor primária
  static Color primaryLight = primary.withOpacity(0.1);
  static Color primaryMedium = primary.withOpacity(0.3);
  static Color primaryDark = primary.withOpacity(0.8);

  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xCCCDDC39)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Sombras
  static BoxShadow primaryShadow = BoxShadow(
    color: primary.withOpacity(0.3),
    blurRadius: 20,
    offset: const Offset(0, 10),
  );

  static BoxShadow cardShadow = BoxShadow(
    color: primary.withOpacity(0.2),
    blurRadius: 8,
    offset: const Offset(0, 4),
  );

  static BoxShadow buttonShadow = BoxShadow(
    color: primary.withOpacity(0.4),
    blurRadius: 15,
    offset: const Offset(0, 8),
  );
}
