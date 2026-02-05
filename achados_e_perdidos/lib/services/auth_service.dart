import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_model.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:8000';

  // Método para realizar o login e obter o token
  // Agora aceita somente email e senha
  static Future<String?> login(String email, String password) async {
    try {
      // Usa o endpoint padrão OAuth2 com form data
      // O campo 'username' do OAuth2 agora será usado para enviar o email
      final response = await http.post(
        Uri.parse('$baseUrl/token'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'username': email, 'password': password}, // Envia email no campo username do OAuth2
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final authToken = AuthToken.fromJson(data);

        // Salvar authToken.accessToken no celular (SharedPreferences)
        await _saveToken(authToken.accessToken);
        return authToken.accessToken;
      } else {
        print('Erro na autenticação: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro na requisição de login: $e');
      return null;
    }
  }

  // Método para registrar um novo usuário
  // Agora aceita username, email e password como campos separados
  static Future<bool> register(String username, String email, String password) async {
    final Map<String, dynamic> requestBody = {
      'username': username,
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final authToken = AuthToken.fromJson(data);

      // Salvar authToken.accessToken no celular (SharedPreferences)
      await _saveToken(authToken.accessToken);
      return true;
    }
    return false;
  }

  // Método para obter o token salvo
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Método para salvar o token
  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  // Método para remover o token (logout)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }

  // Método para verificar se o usuário está logado
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}