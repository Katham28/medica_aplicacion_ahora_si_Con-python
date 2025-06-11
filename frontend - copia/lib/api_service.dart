import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const _base = 'http://10.0.2.2:8000';
  static String? _token;

  static Future<void> _saveToken(String token) async {
    final p = await SharedPreferences.getInstance();
    await p.setString('token', token);
  }

  static Future<bool> login(String user, String pass) async {
    final r = await http.post(
      Uri.parse('$_base/login'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: 'username=$user&password=$pass',
    );
    if (r.statusCode == 200) {
      final d = jsonDecode(r.body);
      _token = d['access_token'];
      await _saveToken(_token!);
      return true;
    }
    return false;
  }

  static Future<List<dynamic>> getTasks() async {
    final p = await SharedPreferences.getInstance();
    _token = p.getString('token');
    final r = await http.get(
      Uri.parse('$_base/tasks'),
      headers: {'Authorization': 'Bearer $_token'},
    );
    return jsonDecode(r.body);
  }

  static Future<void> enviarCodigo(String email) async {
    await http.post(
      Uri.parse('$_base/auth/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
  }

  static Future<String> verificarCodigo(String email, String codigo) async {
    final r = await http.post(
      Uri.parse('$_base/auth/verify-code'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'code': codigo}),
    );
    if (r.statusCode != 200) throw Exception(r.body);
    return jsonDecode(r.body)['token'];
  }

  static Future<void> resetearPassword(String token, String nueva) async {
    final r = await http.post(
      Uri.parse('$_base/auth/reset-password'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({'new_password': nueva}),
    );
    if (r.statusCode != 200) throw Exception(r.body);
  }
}
