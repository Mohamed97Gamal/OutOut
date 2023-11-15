class CitySummaryResponse {
  late String id;
  late String name;
  late bool isActive;

  CitySummaryResponse();

  @override
  String toString() {
    return 'CitySummaryResponse[id=$id, name=$name, isActive=$isActive]';
  }

  CitySummaryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'isActive': isActive};
  }

  static List<CitySummaryResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<CitySummaryResponse>.empty()
        : json.map((value) => new CitySummaryResponse.fromJson(value)).toList();
  }

  static Map<String, CitySummaryResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, CitySummaryResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CitySummaryResponse.fromJson(value));
    }
    return map;
  }
}
