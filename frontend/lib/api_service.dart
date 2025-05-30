import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
        
class ApiService {
  static const String _baseUrl = "http://10.0.2.2:8000"; // Android: 10.0.2.2
  static String? _token;

  // Guardar token
  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Login
  static Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/login"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: "username=$username&password=$password",
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _token = data["access_token"];
      await _saveToken(_token!);
      return true;
    }
    return false;
  }

  // Obtener tareas
  static Future<List<dynamic>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    
    final response = await http.get(
      Uri.parse("$_baseUrl/tasks"),
      headers: {"Authorization": "Bearer $_token"},
    );
    return jsonDecode(response.body);
  }
}