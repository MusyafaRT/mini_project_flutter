import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> userLogin(String login, String password) async {
  final response = await http.post(
    Uri.parse('https://recruitment-api.pyt1.stg.jmr.pl/login'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'login': login,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}
