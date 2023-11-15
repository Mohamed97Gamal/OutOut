class VerifyResetPasswordRequest {
  late String email;

  late String otp;

  VerifyResetPasswordRequest();

  @override
  String toString() {
    return 'VerifyResetPasswordRequest[email=$email, otp=$otp ]';
  }

  VerifyResetPasswordRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    email = json['email'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'otp': otp};
  }

  static List<VerifyResetPasswordRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<VerifyResetPasswordRequest>.empty()
        : json.map((value) => new VerifyResetPasswordRequest.fromJson(value)).toList();
  }

  static Map<String, VerifyResetPasswordRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VerifyResetPasswordRequest>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new VerifyResetPasswordRequest.fromJson(value));
    }
    return map;
  }
}
