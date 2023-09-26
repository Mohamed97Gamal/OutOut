import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_appointment_response.dart';

class ClientProfileAppointmentResponseOperationResult {
  bool? status;
  String? errorMessage;
  List<String> errors = [];
  ClientProfileAppointmentResponse? result;

  ClientProfileAppointmentResponseOperationResult();

  @override
  String toString() {
    return 'ClientProfileAppointmentResponseOperationResult[status=$status, errorMessage=$errorMessage, errors=$errors, result=$result, ]';
  }

  ClientProfileAppointmentResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List?)?.map((item) => item as String).toList() ?? [];
    result = ClientProfileAppointmentResponse.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'errorMessage': errorMessage, 'errors': errors, 'result': result};
  }

  static List<ClientProfileAppointmentResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<ClientProfileAppointmentResponseOperationResult>.empty()
        : json.map((value) => ClientProfileAppointmentResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, ClientProfileAppointmentResponseOperationResult> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = Map<String, ClientProfileAppointmentResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = ClientProfileAppointmentResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
