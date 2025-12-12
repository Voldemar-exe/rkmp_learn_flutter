class ApiAuthDto {
  final String id;
  final String login;
  final String email;
  final String password;
  final String createdAt;

  ApiAuthDto({
    required this.id,
    required this.login,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  factory ApiAuthDto.fromJson(Map<String, dynamic> json) {
    return ApiAuthDto(
      id: json['id'] as String,
      login: json['login'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'email': email,
      'password': password,
      'created_at': createdAt,
    };
  }
}
