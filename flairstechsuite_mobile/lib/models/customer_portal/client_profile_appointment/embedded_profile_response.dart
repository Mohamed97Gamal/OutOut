

class EmbeddedProfileResponse {
  
  String? id = null;

  String? fullName = null;

  String? organizationEmail = null;

  EmbeddedProfileResponse();

  @override
  String toString() {
    return 'EmbeddedProfileResponse[id=$id, fullName=$fullName, organizationEmail=$organizationEmail, ]';
  }

  EmbeddedProfileResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    fullName = json['fullName'];
    organizationEmail = json['organizationEmail'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'organizationEmail': organizationEmail
     };
  }

  static List<EmbeddedProfileResponse> listFromJson(List<dynamic>? json) {
    return json == null ? new List<EmbeddedProfileResponse>.empty() : json.map((value) => new EmbeddedProfileResponse.fromJson(value)).toList();
  }

  static Map<String, EmbeddedProfileResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EmbeddedProfileResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new EmbeddedProfileResponse.fromJson(value));
    }
    return map;
  }
}
