class LoginResponse {
  final String jwtToken;
  final String username;
  final int expiresAt;

  const LoginResponse({
    this.jwtToken = '',
    this.username = '',
    this.expiresAt = 0,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      jwtToken: json['jwtToken'] ?? '',
      username: json['username'] ?? '',
      expiresAt: json['expiresAt'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'jwtToken': jwtToken, 'username': username, 'expiresAt': expiresAt};
  }

  LoginResponse copyWith({String? jwtToken, String? username, int? expiresAt}) {
    return LoginResponse(
      jwtToken: jwtToken ?? this.jwtToken,
      username: username ?? this.username,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
