import 'package:out_out/data/view_models/auth/otp_verification_time_left_response.dart';

class OTPVerificationTimeLeftResponseOperationResult {
  late bool status;

  late OTPVerificationTimeLeftResponse result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  OTPVerificationTimeLeftResponseOperationResult();

  @override
  String toString() {
    return 'OTPVerificationTimeLeftResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  OTPVerificationTimeLeftResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new OTPVerificationTimeLeftResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<OTPVerificationTimeLeftResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<OTPVerificationTimeLeftResponseOperationResult>.empty()
        : json.map((value) => new OTPVerificationTimeLeftResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, OTPVerificationTimeLeftResponseOperationResult> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, OTPVerificationTimeLeftResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new OTPVerificationTimeLeftResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
