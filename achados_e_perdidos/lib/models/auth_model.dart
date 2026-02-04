class AuthToken {
  final String accessToken;
  final String tokenType;

  AuthToken({required this.accessToken, required this.tokenType});

  // JSON (Python) -> Objeto (Flutter)
  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}
