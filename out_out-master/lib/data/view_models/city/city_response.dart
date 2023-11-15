import 'package:out_out/data/view_models/city/country_response.dart';

class CityResponse {
  late String id;

  late String name;

  late List<String> areas = [];

  late bool isActive;

  late CountryResponse country;

  CityResponse();

  @override
  String toString() {
    return 'CityResponse[id=$id, name=$name, areas=$areas, isActive=$isActive, country=$country, ]';
  }

  CityResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    areas = (json['areas'] as List).map((item) => item as String).toList();
    isActive = json['isActive'];
    country = CountryResponse.fromJson(json['country']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'areas': areas, 'isActive': isActive, 'country': country};
  }

  static List<CityResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<CityResponse>.empty()
        : json.map((value) => new CityResponse.fromJson(value)).toList();
  }

  static Map<String, CityResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, CityResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CityResponse.fromJson(value));
    }
    return map;
  }
}
