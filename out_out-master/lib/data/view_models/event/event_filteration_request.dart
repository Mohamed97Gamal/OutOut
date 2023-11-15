import 'package:out_out/data/models/enums/event_filter.dart';

class EventFilterationRequest {
  late String searchQuery;

  late EventFilter eventFilter;

  late List<String> categoriesIds = [];

  EventFilterationRequest();

  @override
  String toString() {
    return 'EventFilterationRequest[searchQuery=$searchQuery, eventFilter=$eventFilter, categoriesIds=$categoriesIds, ]';
  }

  EventFilterationRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    searchQuery = json['searchQuery'];
    eventFilter = new EventFilter.fromJson(json['eventFilter']);
    categoriesIds = (json['categoriesIds'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'searchQuery': searchQuery, 'eventFilter': eventFilter.value, 'categoriesIds': categoriesIds};
  }

  static List<EventFilterationRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<EventFilterationRequest>.empty()
        : json.map((value) => new EventFilterationRequest.fromJson(value)).toList();
  }

  static Map<String, EventFilterationRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EventFilterationRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new EventFilterationRequest.fromJson(value));
    }
    return map;
  }
}
