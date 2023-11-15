import 'package:out_out/data/view_models/auth/application_user_response.dart';

class LoginResponse {
  late ApplicationUserResponse user;

  late List<String> userRoles = [];

  late bool isVerifiedEmail;

  late String token;

  late DateTime expiration;

  late String refreshToken;

  late DateTime refreshTokenExpiration;

  LoginResponse();

  @override
  String toString() {
    return 'LoginResponse[user=$user, userRoles=$userRoles, isVerifiedEmail=$isVerifiedEmail, token=$token, expiration=$expiration, refreshToken=$refreshToken, refreshTokenExpiration=$refreshTokenExpiration, ]';
  }

  LoginResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    user = new ApplicationUserResponse.fromJson(json['user']);
    userRoles = (json['userRoles'] as List?)?.map((item) => item as String).toList() ?? [];
    isVerifiedEmail = json['isVerifiedEmail'];
    token = json['token'];
    expiration = DateTime.parse(json['expiration']);
    refreshToken = json['refreshToken'];
    refreshTokenExpiration = DateTime.parse(json['refreshTokenExpiration']);
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'userRoles': userRoles,
      'isVerifiedEmail': isVerifiedEmail,
      'token': token,
      'expiration': expiration.toUtc().toIso8601String(),
      'refreshToken': refreshToken,
      'refreshTokenExpiration': refreshTokenExpiration.toUtc().toIso8601String()
    };
  }

  static List<LoginResponse> listFromJson(List<dynamic>? json) {
    return json == null ? List<LoginResponse>.empty() : json.map((value) => new LoginResponse.fromJson(value)).toList();
  }

  static Map<String, LoginResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, LoginResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new LoginResponse.fromJson(value));
    }
    return map;
  }
}
