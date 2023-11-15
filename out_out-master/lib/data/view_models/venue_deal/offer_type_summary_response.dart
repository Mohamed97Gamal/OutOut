class OfferTypeSummaryResponse {
  late String id;

  late String name;

  OfferTypeSummaryResponse();

  @override
  String toString() {
    return 'OfferResponse[id=$id, name=$name, ]';
  }

  OfferTypeSummaryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static List<OfferTypeSummaryResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<OfferTypeSummaryResponse>.empty()
        : json.map((value) => new OfferTypeSummaryResponse.fromJson(value)).toList();
  }

  static Map<String, OfferTypeSummaryResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, OfferTypeSummaryResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new OfferTypeSummaryResponse.fromJson(value));
    }
    return map;
  }
}
