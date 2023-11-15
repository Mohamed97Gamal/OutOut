class OfferFilterationRequest {
  String? searchQuery;
  int? sortBy;

  OfferFilterationRequest();

  @override
  String toString() {
    return 'OfferFilterationRequest[searchQuery=$searchQuery, sortBy=$sortBy]';
  }

  OfferFilterationRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    searchQuery = json['searchQuery'];
    sortBy = json['sortBy'];
  }

  Map<String, dynamic> toJson() {
    return {'searchQuery': searchQuery, 'sortBy': sortBy};
  }

  static List<OfferFilterationRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<OfferFilterationRequest>.empty()
        : json
            .map((value) => new OfferFilterationRequest.fromJson(value))
            .toList();
  }

  static Map<String, OfferFilterationRequest> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, OfferFilterationRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new OfferFilterationRequest.fromJson(value));
    }
    return map;
  }
}
