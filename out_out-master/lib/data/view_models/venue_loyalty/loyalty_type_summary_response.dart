class LoyaltyTypeSummaryResponse {
  late String id;

  late String name;

  LoyaltyTypeSummaryResponse();

  @override
  String toString() {
    return 'OfferResponse[id=$id, name=$name, ]';
  }

  LoyaltyTypeSummaryResponse.fromJson(Map<String, dynamic>? json) {
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

  static List<LoyaltyTypeSummaryResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<LoyaltyTypeSummaryResponse>.empty()
        : json.map((value) => new LoyaltyTypeSummaryResponse.fromJson(value)).toList();
  }

  static Map<String, LoyaltyTypeSummaryResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, LoyaltyTypeSummaryResponse>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new LoyaltyTypeSummaryResponse.fromJson(value));
    }
    return map;
  }
}
