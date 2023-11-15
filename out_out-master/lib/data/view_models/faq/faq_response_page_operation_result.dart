
import 'package:out_out/data/view_models/faq/faq_response_page.dart';

class FAQResponsePageOperationResult {
  late bool status;

  late FAQResponsePage result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  FAQResponsePageOperationResult();

  @override
  String toString() {
    return 'FAQResponsePageOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  FAQResponsePageOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new FAQResponsePage.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<FAQResponsePageOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<FAQResponsePageOperationResult>.empty()
        : json.map((value) => new FAQResponsePageOperationResult.fromJson(value)).toList();
  }

  static Map<String, FAQResponsePageOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, FAQResponsePageOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new FAQResponsePageOperationResult.fromJson(value));
    }
    return map;
  }
}
