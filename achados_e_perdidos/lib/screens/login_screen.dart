import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import '../core/app_colors.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.white),
              const SizedBox(width: 8),
              const Text('Login realizado com sucesso!'),
            ],
          ),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.iceWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // Logo/Ícone com Hero Animation
                Center(
                  child: Hero(
                    tag: 'app_logo',
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.search_rounded,
                        size: 50,
                        color: AppColors
                            .black, // Usando cor preta conforme PALETA_CORES.md 39-42
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Card Principal com Material UI
                Card(
                  elevation: 0, // Removendo sombra do card
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: AppColors.grey.withOpacity(0.2),
                    ), // Adicionando borda sutil
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Título
                          Text(
                            'Bem-vindo de volta!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors
                                  .black, // Usando cor preta conforme PALETA_CORES.md 39-42
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 30),

                          // Campo de Email
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'seu@email.com',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: AppColors
                                    .black, // Usando cor preta conforme PALETA_CORES.md 39-42
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.grey.withOpacity(0.3),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.iceWhite,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira seu email';
                              }
                              if (!value.contains('@')) {
                                return 'Por favor, insira um email válido';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          // Campo de Senha
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              hintText: '••••••••',
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: AppColors
                                    .black, // Usando cor preta conforme PALETA_CORES.md 39-42
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors
                                      .black, // Usando cor preta conforme PALETA_CORES.md 39-42
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.grey.withOpacity(0.3),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.iceWhite,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira sua senha';
                              }
                              if (value.length < 6) {
                                return 'A senha deve ter no mínimo 6 caracteres';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          // Lembrar-me e Esqueceu a senha
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GFCheckbox(
                                    size: 20,
                                    activeBgColor: AppColors.primary,
                                    type: GFCheckboxType.circle,
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Lembrar-me',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.info_outline,
                                            color: AppColors.white,
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Funcionalidade em desenvolvimento',
                                          ),
                                        ],
                                      ),
                                      backgroundColor: AppColors.secondary,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors
                                        .grey, // Usando cor cinza conforme PALETA_CORES.md 24-27
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // Botão de Login com gradiente
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: ElevatedButton(
                              onPressed: _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                              child: Text(
                                'ENTRAR',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Link para Cadastro
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Não tem uma conta? ',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                      ), // Usando cor cinza conforme PALETA_CORES.md 23-27
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Cadastre-se',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors
                              .grey, // Usando cor cinza conforme PALETA_CORES.md 23-27
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
