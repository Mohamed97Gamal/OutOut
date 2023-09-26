

class ClientProfileAppointmentIssueResponse {
  
  String? description = null;

  ClientProfileAppointmentIssueResponse();

  @override
  String toString() {
    return 'ClientProfileAppointmentIssueResponse[description=$description, ]';
  }

  ClientProfileAppointmentIssueResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description
     };
  }

  static List<ClientProfileAppointmentIssueResponse> listFromJson(List<dynamic>? json) {
    return json == null ? new List<ClientProfileAppointmentIssueResponse>.empty() : json.map((value) => new ClientProfileAppointmentIssueResponse.fromJson(value)).toList();
  }

  static Map<String, ClientProfileAppointmentIssueResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, ClientProfileAppointmentIssueResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ClientProfileAppointmentIssueResponse.fromJson(value));
    }
    return map;
  }
}
