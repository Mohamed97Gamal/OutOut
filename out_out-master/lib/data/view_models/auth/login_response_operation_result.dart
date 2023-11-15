import 'package:out_out/data/view_models/auth/login_response.dart';

class LoginResponseOperationResult {
  late bool status;

  late LoginResponse result;

  late int errorCode;

   String? errorMessage;

  late List<String> errors = [];

  LoginResponseOperationResult();

  @override
  String toString() {
    return 'LoginResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  LoginResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new LoginResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<LoginResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<LoginResponseOperationResult>.empty()
        : json.map((value) => new LoginResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, LoginResponseOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, LoginResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new LoginResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
