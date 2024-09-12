import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> userLogin(String login, String password) async {
  final response = await http.post(
    Uri.parse('https://hrd.enseval.com:8082/HCM_API_demo/api/ERF/demoLogin/'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'username': login,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    if (response.body == "SUCCEED") {
      return {
        'message': 'Login successful',
      };
    }
    return {
      'message': 'Login failed',
    };
  } else {
    throw Exception('Failed to login');
  }
}
