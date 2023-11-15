class LoginRequest {
  late String email;

  late String password;

  String? firebaseMessagingToken;

  LoginRequest();

  @override
  String toString() {
    return 'LoginRequest[email=$email, password=$password, firebaseMessagingToken=$firebaseMessagingToken, ]';
  }

  LoginRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    email = json['email'];
    password = json['password'];
    firebaseMessagingToken = json['firebaseMessagingToken'];
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'firebaseMessagingToken': firebaseMessagingToken};
  }

  static List<LoginRequest> listFromJson(List<dynamic>? json) {
    return json == null ? List<LoginRequest>.empty() : json.map((value) => new LoginRequest.fromJson(value)).toList();
  }

  static Map<String, LoginRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, LoginRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new LoginRequest.fromJson(value));
    }
    return map;
  }
}
