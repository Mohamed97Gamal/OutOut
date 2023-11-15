class UserLocation {
  late num latitude;

  late num longitude;

  late String description;

  UserLocation();

  @override
  String toString() {
    return 'UserLocation[latitude=$latitude, longitude=$longitude, description=$description, ]';
  }

  UserLocation.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    latitude = json['latitude'];
    longitude = json['longitude'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude, 'description': description};
  }

  static List<UserLocation> listFromJson(List<dynamic>? json) {
    return json == null ? List<UserLocation>.empty() : json.map((value) => new UserLocation.fromJson(value)).toList();
  }

  static Map<String, UserLocation> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, UserLocation>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new UserLocation.fromJson(value));
    }
    return map;
  }
}
