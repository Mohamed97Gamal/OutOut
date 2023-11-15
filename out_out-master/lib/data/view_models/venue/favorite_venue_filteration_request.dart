class FavoriteVenueFilterationRequest {
  late String searchQuery;

  FavoriteVenueFilterationRequest();

  @override
  String toString() {
    return 'FavoriteVenueFilterationRequest[searchQuery=$searchQuery, ]';
  }

  FavoriteVenueFilterationRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    searchQuery = json['searchQuery'];
  }

  Map<String, dynamic> toJson() {
    return {'searchQuery': searchQuery};
  }

  static List<FavoriteVenueFilterationRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<FavoriteVenueFilterationRequest>.empty()
        : json.map((value) => new FavoriteVenueFilterationRequest.fromJson(value)).toList();
  }

  static Map<String, FavoriteVenueFilterationRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, FavoriteVenueFilterationRequest>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new FavoriteVenueFilterationRequest.fromJson(value));
    }
    return map;
  }
}
