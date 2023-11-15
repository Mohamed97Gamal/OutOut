class SearchFilterationRequest {
  late String searchQuery;

  SearchFilterationRequest();

  @override
  String toString() {
    return 'SearchFilterationRequest[searchQuery=$searchQuery, ]';
  }

  SearchFilterationRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    searchQuery = json['searchQuery'];
  }

  Map<String, dynamic> toJson() {
    return {'searchQuery': searchQuery};
  }

  static List<SearchFilterationRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<SearchFilterationRequest>.empty()
        : json.map((value) => new SearchFilterationRequest.fromJson(value)).toList();
  }

  static Map<String, SearchFilterationRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, SearchFilterationRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new SearchFilterationRequest.fromJson(value));
    }
    return map;
  }
}
