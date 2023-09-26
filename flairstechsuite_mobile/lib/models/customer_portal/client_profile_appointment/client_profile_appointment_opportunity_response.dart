

class ClientProfileAppointmentOpportunityResponse {
  
  String? description = null;

  ClientProfileAppointmentOpportunityResponse();

  @override
  String toString() {
    return 'ClientProfileAppointmentOpportunityResponse[description=$description, ]';
  }

  ClientProfileAppointmentOpportunityResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description
     };
  }

  static List<ClientProfileAppointmentOpportunityResponse> listFromJson(List<dynamic>? json) {
    return json == null ? new List<ClientProfileAppointmentOpportunityResponse>.empty() : json.map((value) => new ClientProfileAppointmentOpportunityResponse.fromJson(value)).toList();
  }

  static Map<String, ClientProfileAppointmentOpportunityResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, ClientProfileAppointmentOpportunityResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ClientProfileAppointmentOpportunityResponse.fromJson(value));
    }
    return map;
  }
}
