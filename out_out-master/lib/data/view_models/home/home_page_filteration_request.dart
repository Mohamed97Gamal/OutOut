class HomePageFilterationRequest {
  String? searchQuery;

  List<String>? venueCategories;

  List<String>? eventCategories;

  String? offerTypeId;

  String? cityId;

  List<String>? areas;

  DateTime? from;

  DateTime? to;

  HomePageFilterationRequest();

  @override
  String toString() {
    return 'HomePageFilterationRequest[searchQuery=$searchQuery, venueCategories=$venueCategories, eventCategories=$eventCategories, offerTypeId=$offerTypeId, cityId=$cityId, areas=$areas, from=$from, to=$to, ]';
  }

  HomePageFilterationRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    searchQuery = json['searchQuery'];
    venueCategories = (json['venueCategories'] as List).map((item) => item as String).toList();
    eventCategories = (json['eventCategories'] as List).map((item) => item as String).toList();
    offerTypeId = json['offerTypeId'];
    cityId = json['cityId'];
    areas = (json['areas'] as List).map((item) => item as String).toList();
    from = json['from'] == null ? null : DateTime.parse(json['from']);
    to = json['to'] == null ? null : DateTime.parse(json['to']);
  }

  Map<String, dynamic> toJson() {
    return {
      'searchQuery': searchQuery,
      'venueCategories': venueCategories,
      'eventCategories': eventCategories,
      'offerTypeId': offerTypeId,
      'cityId': cityId,
      'areas': areas,
      'from': from?.toUtc().toIso8601String(),
      'to': to?.toUtc().toIso8601String()
    };
  }

  static List<HomePageFilterationRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<HomePageFilterationRequest>.empty()
        : json.map((value) => new HomePageFilterationRequest.fromJson(value)).toList();
  }

  static Map<String, HomePageFilterationRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, HomePageFilterationRequest>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new HomePageFilterationRequest.fromJson(value));
    }
    return map;
  }
}
