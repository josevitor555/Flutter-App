import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_model.dart';
import '../models/lost_item.dart';
import '../models/user_model.dart';

class ApiService {
  // URL base do seu backend Python
  static const String baseUrl =
      'http://localhost:8000'; // Altere para o IP correto do seu Docker

  // Headers padrão para requisições
  static Map<String, String> getHeaders([String? token]) {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  // Método para login
  static Future<AuthToken?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/token'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return AuthToken.fromJson(data);
      } else {
        print('Erro no login: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro na requisição de login: $e');
      return null;
    }
  }

  // Método para registrar um novo usuário
  static Future<User?> register(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        print('Erro no registro: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro na requisição de registro: $e');
      return null;
    }
  }

  // Método para obter itens (com ou sem token de autenticação)
  static Future<List<LostItem>> getItems({String? token}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/itens'),
        headers: getHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => LostItem.fromJson(json)).toList();
      } else {
        print(
          'Erro ao buscar itens: ${response.statusCode} - ${response.body}',
        );
        return [];
      }
    } catch (e) {
      print('Erro na requisição de itens: $e');
      return [];
    }
  }

  // Método para criar um novo item
  static Future<LostItem?> createItem(
    LostItem item, {
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/itens'),
        headers: getHeaders(token),
        body: jsonEncode(item.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return LostItem.fromJson(data);
      } else {
        print('Erro ao criar item: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro na requisição de criação de item: $e');
      return null;
    }
  }

  // Método para atualizar um item existente
  static Future<LostItem?> updateItem(
    int itemId,
    LostItem item, {
    required String token,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/itens/$itemId'),
        headers: getHeaders(token),
        body: jsonEncode(item.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return LostItem.fromJson(data);
      } else {
        print(
          'Erro ao atualizar item: ${response.statusCode} - ${response.body}',
        );
        return null;
      }
    } catch (e) {
      print('Erro na requisição de atualização de item: $e');
      return null;
    }
  }

  // Método para deletar um item
  static Future<bool> deleteItem(int itemId, {required String token}) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/itens/$itemId'),
        headers: getHeaders(token),
      );

      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print('Erro na requisição de exclusão de item: $e');
      return false;
    }
  }
}
