import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_appointment_issue_response.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_appointment_opportunity_response.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_mood.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/embedded_client_profile_response.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/embedded_profile_response.dart';

class ClientProfileAppointmentResponse {
  String? id = null;

  EmbeddedProfileResponse? profile = null;

  EmbeddedClientProfileResponse? clientProfile = null;

  DateTime? scheduledDate = null;

  ClientProfileMood? mood = null;

  List<ClientProfileAppointmentIssueResponse> issues = [];

  List<ClientProfileAppointmentOpportunityResponse> opportunities = [];

  String? notes = null;

  DateTime? loggedOnDate = null;

  ClientProfileAppointmentResponse();

  ClientProfileAppointmentResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    profile = EmbeddedProfileResponse.fromJson(json['profile']);
    clientProfile = EmbeddedClientProfileResponse.fromJson(json['clientProfile']);
    scheduledDate = json['scheduledDate'] == null ? null : DateTime.parse(json['scheduledDate']);
    mood = json['mood'] == null ? null : ClientProfileMood.fromJson(json['mood']);
    issues = ClientProfileAppointmentIssueResponse.listFromJson(json['issues']);
    opportunities = ClientProfileAppointmentOpportunityResponse.listFromJson(json['opportunities']);
    notes = json['notes'];
    loggedOnDate = json['loggedOnDate'] == null ? null : DateTime.parse(json['loggedOnDate']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile': profile,
      'clientProfile': clientProfile,
      'scheduledDate': scheduledDate == null ? '' : scheduledDate!.toUtc().toIso8601String(),
      'mood': mood,
      'issues': issues,
      'opportunities': opportunities,
      'notes': notes,
      'loggedOnDate': loggedOnDate == null ? '' : loggedOnDate!.toUtc().toIso8601String()
    };
  }

  static List<ClientProfileAppointmentResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<ClientProfileAppointmentResponse>.empty()
        : json.map((value) => ClientProfileAppointmentResponse.fromJson(value)).toList();
  }

  static Map<String, ClientProfileAppointmentResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = Map<String, ClientProfileAppointmentResponse>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = ClientProfileAppointmentResponse.fromJson(value));
    }
    return map;
  }
}
