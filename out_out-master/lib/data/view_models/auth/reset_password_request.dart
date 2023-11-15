class ResetPasswordRequest {
  late String email;

  late String hashedOtp;

  late String newPassword;

  ResetPasswordRequest();

  @override
  String toString() {
    return 'ResetPasswordRequest[email=$email, hashedOtp=$hashedOtp, newPassword=$newPassword, ]';
  }

  ResetPasswordRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    email = json['email'];
    hashedOtp = json['hashedOtp'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'hashedOtp': hashedOtp, 'newPassword': newPassword};
  }

  static List<ResetPasswordRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<ResetPasswordRequest>.empty()
        : json.map((value) => new ResetPasswordRequest.fromJson(value)).toList();
  }

  static Map<String, ResetPasswordRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, ResetPasswordRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ResetPasswordRequest.fromJson(value));
    }
    return map;
  }
}
