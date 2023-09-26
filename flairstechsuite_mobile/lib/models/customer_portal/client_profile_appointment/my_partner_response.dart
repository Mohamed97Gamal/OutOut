import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_appointment_response.dart';

class MyPartnerResponse {
  String? id;
  String? fullName;
  String? title;
  ClientProfileAppointmentResponse? nextAppointment;
  ClientProfileAppointmentResponse? lastAppointment;

  MyPartnerResponse();

  MyPartnerResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    fullName = json['fullName'];
    title = json['title'];
    nextAppointment =
        json['nextAppointment'] == null ? null : ClientProfileAppointmentResponse.fromJson(json['nextAppointment']);
    lastAppointment =
        json['lastAppointment'] == null ? null : ClientProfileAppointmentResponse.fromJson(json['lastAppointment']);
  }

  static List<MyPartnerResponse> listFromJson(List<dynamic>? json) {
    return json == null ? List<MyPartnerResponse>.empty() : json.map((value) => MyPartnerResponse.fromJson(value)).toList();
  }

  static Map<String, MyPartnerResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = Map<String, MyPartnerResponse>();
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = MyPartnerResponse.fromJson(value));
    }
    return map;
  }
}
