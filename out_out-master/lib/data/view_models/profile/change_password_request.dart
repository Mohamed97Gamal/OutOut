class ChangePasswordRequest {
  String? oldPassword;

  late String newPassword;

  ChangePasswordRequest();

  @override
  String toString() {
    return 'ChangePasswordRequest[oldPassword=$oldPassword, newPassword=$newPassword, ]';
  }

  ChangePasswordRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    return {'oldPassword': oldPassword, 'newPassword': newPassword};
  }

  static List<ChangePasswordRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<ChangePasswordRequest>.empty()
        : json.map((value) => new ChangePasswordRequest.fromJson(value)).toList();
  }

  static Map<String, ChangePasswordRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, ChangePasswordRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ChangePasswordRequest.fromJson(value));
    }
    return map;
  }
}
