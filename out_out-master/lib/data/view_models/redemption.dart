class Redemption {
  late DateTime date;

  late String code;

  Redemption();

  @override
  String toString() {
    return 'Redemption[date=$date, code=$code, ]';
  }

  Redemption.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    date = DateTime.parse(json['date']);
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    return {'date': date.toUtc().toIso8601String(), 'code': code};
  }

  static List<Redemption> listFromJson(List<dynamic>? json) {
    return json == null ? new List<Redemption>.empty() : json.map((value) => new Redemption.fromJson(value)).toList();
  }

  static Map<String, Redemption> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, Redemption>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Redemption.fromJson(value));
    }
    return map;
  }
}
