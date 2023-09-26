import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/embedded_client_profile_response.dart';

class MyAppointmentsHistorySummaryResponse {
  EmbeddedClientProfileResponse? clientProfile;

  int? totalIssues, totalOpportunities;

  MyAppointmentsHistorySummaryResponse();

  @override
  String toString() {
    return 'MyAppointmentsHistorySummaryResponse[clientProfile=$clientProfile, totalIssues=$totalIssues, totalOpportunities=$totalOpportunities, ]';
  }

  MyAppointmentsHistorySummaryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    clientProfile = EmbeddedClientProfileResponse.fromJson(json['clientProfile']);
    totalIssues = json['totalIssues'];
    totalOpportunities = json['totalOpportunities'];
  }

  Map<String, dynamic> toJson() {
    return {'clientProfile': clientProfile, 'totalIssues': totalIssues, 'totalOpportunities': totalOpportunities};
  }

  static List<MyAppointmentsHistorySummaryResponse> listFromJson(List<dynamic> json) {
    return json == null
        ? <MyAppointmentsHistorySummaryResponse>[]
        : json.map((value) => MyAppointmentsHistorySummaryResponse.fromJson(value)).toList();
  }

  static Map<String, MyAppointmentsHistorySummaryResponse> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = Map<String, MyAppointmentsHistorySummaryResponse>();
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = MyAppointmentsHistorySummaryResponse.fromJson(value));
    }
    return map;
  }
}
