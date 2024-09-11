class LoginResponse {
  final String message;
  final String status;

  LoginResponse({required this.message, required this.status});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class LoginRequest {
  final String login;
  final String password;

  LoginRequest({required this.login, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
    };
  }
}
