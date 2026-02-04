import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_model.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:8000';

  // Método para realizar o login e obter o token
  static Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final authToken = AuthToken.fromJson(data);

      // Salvar authToken.accessToken no celular (SharedPreferences)
      await _saveToken(authToken.accessToken);
      return authToken.accessToken;
    }
    return null;
  }

  // Método para registrar um novo usuário
  static Future<bool> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
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
