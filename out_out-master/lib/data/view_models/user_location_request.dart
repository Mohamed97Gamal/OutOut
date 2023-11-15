class UserLocationRequest {
  late num latitude;

  late num longitude;

  late String description;

  UserLocationRequest();

  @override
  String toString() {
    return 'UserLocationRequest[latitude=$latitude, longitude=$longitude, description=$description, ]';
  }

  UserLocationRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    latitude = json['latitude'];
    longitude = json['longitude'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude, 'description': description};
  }

  static List<UserLocationRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<UserLocationRequest>.empty()
        : json.map((value) => new UserLocationRequest.fromJson(value)).toList();
  }

  static Map<String, UserLocationRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, UserLocationRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new UserLocationRequest.fromJson(value));
    }
    return map;
  }
}
