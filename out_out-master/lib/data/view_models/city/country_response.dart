class CountryResponse {
  late String id;
  late String name;
  late String symbol;

  CountryResponse();

  @override
  String toString() {
    return 'CountryResponse[id=$id, name=$name, symbol=$symbol ]';
  }

  CountryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'symbol': symbol};
  }

  static List<CountryResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<CountryResponse>.empty()
        : json.map((value) => new CountryResponse.fromJson(value)).toList();
  }

  static Map<String, CountryResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, CountryResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CountryResponse.fromJson(value));
    }
    return map;
  }
}
