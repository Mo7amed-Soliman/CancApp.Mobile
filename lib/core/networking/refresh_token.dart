class RefreshTokenData {
  final String accessToken;
  final String refreshToken;

  const RefreshTokenData({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RefreshTokenData.fromJson(Map<String, dynamic> json) {
    return RefreshTokenData(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
