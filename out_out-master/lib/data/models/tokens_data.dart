import 'package:out_out/data/view_models/auth/login_response.dart';

class TokensData {
  String accessToken, refreshToken;
  DateTime accessTokenExpirationDate, refreshTokenExpirationDate;

  TokensData(
    this.accessToken,
    this.accessTokenExpirationDate,
    this.refreshToken,
    this.refreshTokenExpirationDate,
  );

  factory TokensData.fromLoginResponse(LoginResponse loginResponse) {
    return TokensData(
      loginResponse.token,
      loginResponse.expiration,
      loginResponse.refreshToken,
      loginResponse.refreshTokenExpiration,
    );
  }

  @override
  String toString() {
    return accessToken +
        "," +
        accessTokenExpirationDate.toIso8601String() +
        "," +
        refreshToken +
        "," +
        refreshTokenExpirationDate.toIso8601String();
  }

  factory TokensData.parse(String value) {
    final parts = value.split(",");
    if (parts.length != 4) {
      throw ("Couldn't decode Tokens Data.");
    }
    return TokensData(
      parts[0],
      DateTime.parse(parts[1]),
      parts[2],
      DateTime.parse(parts[3]),
    );
  }
}
