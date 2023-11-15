class VerifyAccountRequest {
  late String email;

  late String otp;

  VerifyAccountRequest();

  @override
  String toString() {
    return 'VerifyAccountRequest[email=$email, otp=$otp, ]';
  }

  VerifyAccountRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    email = json['email'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'otp': otp};
  }

  static List<VerifyAccountRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<VerifyAccountRequest>.empty()
        : json.map((value) => new VerifyAccountRequest.fromJson(value)).toList();
  }

  static Map<String, VerifyAccountRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VerifyAccountRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new VerifyAccountRequest.fromJson(value));
    }
    return map;
  }
}
