import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/my_partner_response.dart';

class MyPartnerResponseOperationResult {
  bool? status;
  String? errorMessage;
  List<String> errors = [];
  MyPartnerResponse? result;

  MyPartnerResponseOperationResult();

  @override
  String toString() {
    return 'MyPartnerResponseOperationResult[status=$status, errorMessage=$errorMessage, errors=$errors, result=$result, ]';
  }

  MyPartnerResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List?)?.map((item) => item as String).toList() ?? [];
    result = MyPartnerResponse.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'errorMessage': errorMessage, 'errors': errors, 'result': result};
  }

  static List<MyPartnerResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? <MyPartnerResponseOperationResult>[]
        : json.map((value) => MyPartnerResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, MyPartnerResponseOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = Map<String, MyPartnerResponseOperationResult>();
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = MyPartnerResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
