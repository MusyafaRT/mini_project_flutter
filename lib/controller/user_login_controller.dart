import "package:http/http.dart" as http;

Future<http.Response> userLogin(String email, String password) async {
  final response = await http.post(
      Uri.parse(
          'https://api.example.com/user/login?email=$email&password=$password'),
      body: {
        'email': email,
        'password': password,
      });
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to login');
  }
}
