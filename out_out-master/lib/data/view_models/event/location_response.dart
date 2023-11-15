import 'package:out_out/data/view_models/city/city_summary_response.dart';

class LocationResponse {
  late num latitude;

  late num longitude;

  late CitySummaryResponse city;

  late String area;

  String? description;

  late num distance;

  LocationResponse();

  @override
  String toString() {
    return 'LocationResponse[latitude=$latitude, longitude=$longitude, city=$city, area=$area, description=$description, distance=$distance, ]';
  }

  LocationResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = new CitySummaryResponse.fromJson(json['city']);
    area = json['area'];
    description = json['description'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'area': area,
      'description': description,
      'distance': distance
    };
  }

  static List<LocationResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<LocationResponse>.empty()
        : json.map((value) => new LocationResponse.fromJson(value)).toList();
  }

  static Map<String, LocationResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, LocationResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new LocationResponse.fromJson(value));
    }
    return map;
  }
}
