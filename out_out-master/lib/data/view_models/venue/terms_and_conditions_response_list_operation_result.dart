import 'package:out_out/data/view_models/venue/terms_and_conditions_response.dart';

class TermsAndConditionsResponseListOperationResult {
  late bool status;

  late List<TermsAndConditionsResponse> result = [];

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  TermsAndConditionsResponseListOperationResult();

  @override
  String toString() {
    return 'TermsAndConditionsResponseListOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  TermsAndConditionsResponseListOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = TermsAndConditionsResponse.listFromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<TermsAndConditionsResponseListOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<TermsAndConditionsResponseListOperationResult>.empty()
        : json.map((value) => new TermsAndConditionsResponseListOperationResult.fromJson(value)).toList();
  }

  static Map<String, TermsAndConditionsResponseListOperationResult> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, TermsAndConditionsResponseListOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new TermsAndConditionsResponseListOperationResult.fromJson(value));
    }
    return map;
  }
}
