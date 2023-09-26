

class EmbeddedClientProfileResponse {
  
  String? id = null;

  String? fullName = null;

  String? title = null;

  String? clientEmail = null;

  EmbeddedClientProfileResponse();

  @override
  String toString() {
    return 'EmbeddedClientProfileResponse[id=$id, fullName=$fullName, title=$title, clientEmail=$clientEmail, ]';
  }

  EmbeddedClientProfileResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    fullName = json['fullName'];
    title = json['title'];
    clientEmail = json['clientEmail'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'title': title,
      'clientEmail': clientEmail
     };
  }

  static List<EmbeddedClientProfileResponse> listFromJson(List<dynamic>? json) {
    return json == null ? new List<EmbeddedClientProfileResponse>.empty() : json.map((value) => new EmbeddedClientProfileResponse.fromJson(value)).toList();
  }

  static Map<String, EmbeddedClientProfileResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EmbeddedClientProfileResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new EmbeddedClientProfileResponse.fromJson(value));
    }
    return map;
  }
}
