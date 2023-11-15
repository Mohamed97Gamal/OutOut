
import 'package:out_out/data/view_models/profile/customer_support_response.dart';

class CustomerSupportResponseOperationResult {
  late bool status;

  late CustomerSupportResponse result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  CustomerSupportResponseOperationResult();

  @override
  String toString() {
    return 'CustomerSupportResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  CustomerSupportResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new CustomerSupportResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<CustomerSupportResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<CustomerSupportResponseOperationResult>.empty()
        : json.map((value) => new CustomerSupportResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, CustomerSupportResponseOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, CustomerSupportResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CustomerSupportResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
