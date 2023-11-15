class LogoutRequest {
  String? firebaseMessagingToken = null;

  LogoutRequest();

  @override
  String toString() {
    return 'LogoutRequest[firebaseMessagingToken=$firebaseMessagingToken, ]';
  }

  LogoutRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    firebaseMessagingToken = json['firebaseMessagingToken'];
  }

  Map<String, dynamic> toJson() {
    return {'firebaseMessagingToken': firebaseMessagingToken};
  }

  static List<LogoutRequest> listFromJson(List<dynamic>? json) {
    return json == null ? List<LogoutRequest>.empty() : json.map((value) => new LogoutRequest.fromJson(value)).toList();
  }

  static Map<String, LogoutRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, LogoutRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new LogoutRequest.fromJson(value));
    }
    return map;
  }
}
