class LoginResponse {
  final String message;

  LoginResponse({required this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
    );
  }
}

class LoginRequest {
  final String login;
  final String password;

  LoginRequest({required this.login, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': login,
      'password': password,
    };
  }
}
