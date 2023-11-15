class CustomerRegistrationRequest {
  late String fullName;

  late String email;

  late String password;

  String? phoneNumber;

  String? firebaseMessagingToken;

  CustomerRegistrationRequest();

  @override
  String toString() {
    return 'CustomerRegistrationRequest[fullName=$fullName, email=$email, password=$password, phoneNumber=$phoneNumber, firebaseMessagingToken=$firebaseMessagingToken, ]';
  }

  CustomerRegistrationRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    firebaseMessagingToken = json['firebaseMessagingToken'];
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'firebaseMessagingToken': firebaseMessagingToken
    };
  }

  static List<CustomerRegistrationRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<CustomerRegistrationRequest>.empty()
        : json.map((value) => new CustomerRegistrationRequest.fromJson(value)).toList();
  }

  static Map<String, CustomerRegistrationRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, CustomerRegistrationRequest>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new CustomerRegistrationRequest.fromJson(value));
    }
    return map;
  }
}
