import 'package:out_out/data/view_models/event/event_occurrence_response.dart';
import 'package:out_out/data/view_models/event/location_response.dart';

class EventSummaryResponse {
  String? id;

  String? name;

  String? image;
  String? detailsLogo;
  String? tableLogo;

  String? description;

  LocationResponse? location;

  EventOccurrenceResponse? occurrence;

  bool? isFavorite;

  bool? isFeatured;

  String? code;

  EventSummaryResponse();

  @override
  String toString() {
    return 'EventSummaryResponse[id=$id, name=$name, image=$image, description=$description, location=$location, occurrence=$occurrence, isFavorite=$isFavorite, isFeatured=$isFeatured, code=$code, ]';
  }

  EventSummaryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    detailsLogo = json['detailsLogo'];
    image = json['image'];
    tableLogo = json['tableLogo'];
    description = json['description'];
    location = new LocationResponse.fromJson(json['location']);
    occurrence = new EventOccurrenceResponse.fromJson(json['occurrence']);
    isFavorite = json['isFavorite'];
    isFeatured = json['isFeatured'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'tableLogo': tableLogo,
      'detailsLogo': detailsLogo,
      'description': description,
      'location': location,
      'occurrence': occurrence,
      'isFavorite': isFavorite,
      'isFeatured': isFeatured,
      'code': code
    };
  }

  static List<EventSummaryResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<EventSummaryResponse>.empty()
        : json.map((value) => new EventSummaryResponse.fromJson(value)).toList();
  }

  static Map<String, EventSummaryResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EventSummaryResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new EventSummaryResponse.fromJson(value));
    }
    return map;
  }
}
