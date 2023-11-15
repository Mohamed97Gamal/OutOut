class FAQFilterationRequest {
  String? searchQuery;

  FAQFilterationRequest();

  @override
  String toString() {
    return 'FAQFilterationRequest[searchQuery=$searchQuery, ]';
  }

  FAQFilterationRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    searchQuery = json['searchQuery'];
  }

  Map<String, dynamic> toJson() {
    return {'searchQuery': searchQuery};
  }

  static List<FAQFilterationRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<FAQFilterationRequest>.empty()
        : json.map((value) => new FAQFilterationRequest.fromJson(value)).toList();
  }

  static Map<String, FAQFilterationRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, FAQFilterationRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new FAQFilterationRequest.fromJson(value));
    }
    return map;
  }
}
