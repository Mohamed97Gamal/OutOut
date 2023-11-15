import 'package:out_out/data/view_models/venue_loyalty/loyalty_response.dart';

class LoyaltyResponseOperationResult {
  late bool status;

  late LoyaltyResponse result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  LoyaltyResponseOperationResult();

  @override
  String toString() {
    return 'LoyaltyResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  LoyaltyResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new LoyaltyResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<LoyaltyResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<LoyaltyResponseOperationResult>.empty()
        : json.map((value) => new LoyaltyResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, LoyaltyResponseOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, LoyaltyResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new LoyaltyResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
