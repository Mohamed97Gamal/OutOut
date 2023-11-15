import 'package:out_out/data/view_models/faq/faq_response.dart';

class FAQResponseOperationResult {
  late bool status;

  late FAQResponse result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  FAQResponseOperationResult();

  @override
  String toString() {
    return 'FAQResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  FAQResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new FAQResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<FAQResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<FAQResponseOperationResult>.empty()
        : json.map((value) => new FAQResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, FAQResponseOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, FAQResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new FAQResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
