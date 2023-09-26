import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/my_appointments_history_summary_response.dart';

class MyAppointmentsHistorySummaryResponseOperationResult {
  bool? status = null;

  String? errorMessage = null;

  List<String> errors = [];

  MyAppointmentsHistorySummaryResponse? result = null;

  MyAppointmentsHistorySummaryResponseOperationResult();

  @override
  String toString() {
    return 'MyAppointmentsHistorySummaryResponseOperationResult[status=$status, errorMessage=$errorMessage, errors=$errors, result=$result, ]';
  }

  MyAppointmentsHistorySummaryResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List?)?.map((item) => item as String).toList() ?? [];
    result = new MyAppointmentsHistorySummaryResponse.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'errorMessage': errorMessage, 'errors': errors, 'result': result};
  }

  static List<MyAppointmentsHistorySummaryResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<MyAppointmentsHistorySummaryResponseOperationResult>.empty()
        : json.map((value) => new MyAppointmentsHistorySummaryResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, MyAppointmentsHistorySummaryResponseOperationResult> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, MyAppointmentsHistorySummaryResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MyAppointmentsHistorySummaryResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
