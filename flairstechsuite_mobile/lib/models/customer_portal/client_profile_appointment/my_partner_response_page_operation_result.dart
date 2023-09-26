import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/my_partner_response_page.dart';

class MyPartnerResponsePageOperationResult {
  bool? status = null;

  String? errorMessage = null;

  List<String> errors = [];

  MyPartnerResponsePage? result = null;

  MyPartnerResponsePageOperationResult();

  @override
  String toString() {
    return 'MyPartnerResponsePageOperationResult[status=$status, errorMessage=$errorMessage, errors=$errors, result=$result, ]';
  }

  MyPartnerResponsePageOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List?)?.map((item) => item as String).toList() ?? [];
    result = new MyPartnerResponsePage.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'errorMessage': errorMessage, 'errors': errors, 'result': result};
  }

  static List<MyPartnerResponsePageOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<MyPartnerResponsePageOperationResult>.empty()
        : json.map((value) => new MyPartnerResponsePageOperationResult.fromJson(value)).toList();
  }

  static Map<String, MyPartnerResponsePageOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, MyPartnerResponsePageOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MyPartnerResponsePageOperationResult.fromJson(value));
    }
    return map;
  }
}
