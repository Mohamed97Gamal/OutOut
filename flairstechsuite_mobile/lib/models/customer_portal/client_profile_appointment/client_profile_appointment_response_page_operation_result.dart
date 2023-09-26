import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_appointment_response_page.dart';

class ClientProfileAppointmentResponsePageOperationResult {
  bool? status;

  String? errorMessage;

  List<String> errors = [];

  ClientProfileAppointmentResponsePage? result;

  ClientProfileAppointmentResponsePageOperationResult();

  @override
  String toString() {
    return 'ClientProfileAppointmentResponsePageOperationResult[status=$status, errorMessage=$errorMessage, errors=$errors, result=$result, ]';
  }

  ClientProfileAppointmentResponsePageOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List?)?.map((item) => item as String).toList() ?? [];
    result = ClientProfileAppointmentResponsePage.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'errorMessage': errorMessage, 'errors': errors, 'result': result};
  }

  static List<ClientProfileAppointmentResponsePageOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<ClientProfileAppointmentResponsePageOperationResult>.empty()
        : json.map((value) => ClientProfileAppointmentResponsePageOperationResult.fromJson(value)).toList();
  }

  static Map<String, ClientProfileAppointmentResponsePageOperationResult> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = Map<String, ClientProfileAppointmentResponsePageOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = ClientProfileAppointmentResponsePageOperationResult.fromJson(value));
    }
    return map;
  }
}
