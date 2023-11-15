import 'package:out_out/data/view_models/auth/application_user_response.dart';

class ApplicationUserResponseOperationResult {
  late bool status;

  late ApplicationUserResponse result;

  late int? errorCode;

  String? errorMessage;

  late List<String> errors;

  ApplicationUserResponseOperationResult();

  @override
  String toString() {
    return 'ApplicationUserResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  ApplicationUserResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new ApplicationUserResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<ApplicationUserResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<ApplicationUserResponseOperationResult>.empty()
        : json.map((value) => new ApplicationUserResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, ApplicationUserResponseOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, ApplicationUserResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ApplicationUserResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
