import 'package:out_out/data/view_models/venue_loyalty/loyalty_response_page.dart';

class LoyaltyResponsePageOperationResult {
  late bool status;

  late LoyaltyResponsePage result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  LoyaltyResponsePageOperationResult();

  @override
  String toString() {
    return 'LoyaltyResponsePageOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  LoyaltyResponsePageOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new LoyaltyResponsePage.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<LoyaltyResponsePageOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<LoyaltyResponsePageOperationResult>.empty()
        : json.map((value) => new LoyaltyResponsePageOperationResult.fromJson(value)).toList();
  }

  static Map<String, LoyaltyResponsePageOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, LoyaltyResponsePageOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new LoyaltyResponsePageOperationResult.fromJson(value));
    }
    return map;
  }
}
