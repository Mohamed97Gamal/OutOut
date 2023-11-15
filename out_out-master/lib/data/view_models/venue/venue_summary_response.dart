import 'package:out_out/data/view_models/available_time_response.dart';
import 'package:out_out/data/view_models/category/category_response.dart';
import 'package:out_out/data/view_models/event/location_response.dart';

class VenueSummaryResponse {
  late String id;

  String? logo;

  String? detailsLogo;

  String? tableLogo;

  late String name;

  late List<AvailableTimeResponse> openTimes = [];

  LocationResponse? location;

  List<CategoryResponse> categories = [];

  late bool isFavorite;

  VenueSummaryResponse();

  @override
  String toString() {
    return 'VenueSummaryResponse[id=$id, logo=$logo, name=$name, openTimes=$openTimes, location=$location, categories=$categories, isFavorite=$isFavorite, detailsLogo=$detailsLogo, tableLogo=$tableLogo ]';
  }

  VenueSummaryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    logo = json['logo'];
    detailsLogo = json['detailsLogo'];
    tableLogo = json['tableLogo'];
    name = json['name'];
    openTimes = AvailableTimeResponse.listFromJson(json['openTimes']);
    location = json['location'] != null ? new LocationResponse.fromJson(json['location']) : null;
    categories = CategoryResponse.listFromJson(json['categories']);
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo': logo,
      'detailsLogo': detailsLogo,
      'tableLogo': tableLogo,
      'name': name,
      'openTimes': openTimes,
      'location': location,
      'categories': categories,
      'isFavorite': isFavorite,
    };
  }

  static List<VenueSummaryResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueSummaryResponse>.empty()
        : json.map((value) => new VenueSummaryResponse.fromJson(value)).toList();
  }

  static Map<String, VenueSummaryResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueSummaryResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new VenueSummaryResponse.fromJson(value));
    }
    return map;
  }
}
