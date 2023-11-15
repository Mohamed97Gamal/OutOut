import 'package:out_out/data/models/enums/venue_time_filter.dart';

class VenueFilterationRequest {
  late String searchQuery;

  late VenueTimeFilter timeFilter;

  late List<String> categoriesIds = [];

  late List<String> typesIds = [];

  VenueFilterationRequest();

  @override
  String toString() {
    return 'VenueFilterationRequest[searchQuery=$searchQuery, timeFilter=$timeFilter, categoriesIds=$categoriesIds, typesIds=$typesIds, ]';
  }

  VenueFilterationRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    searchQuery = json['searchQuery'];
    timeFilter = new VenueTimeFilter.fromJson(json['timeFilter']);
    categoriesIds = (json['categoriesIds'] as List).map((item) => item as String).toList();
    typesIds = (json['typesIds'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'searchQuery': searchQuery,
      'timeFilter': timeFilter.value,
      'categoriesIds': categoriesIds,
      'typesIds': typesIds,
    };
  }

  static List<VenueFilterationRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueFilterationRequest>.empty()
        : json.map((value) => new VenueFilterationRequest.fromJson(value)).toList();
  }

  static Map<String, VenueFilterationRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueFilterationRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new VenueFilterationRequest.fromJson(value));
    }
    return map;
  }
}
