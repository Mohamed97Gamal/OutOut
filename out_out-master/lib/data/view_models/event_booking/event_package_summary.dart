class EventPackageSummary {
  late String id;

  late String title;

  late num price;

  EventPackageSummary();

  @override
  String toString() {
    return 'EventPackageSummary[id=$id, title=$title, price=$price, ]';
  }

  EventPackageSummary.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    title = json['title'];
    price = json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'price': price};
  }

  static List<EventPackageSummary> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<EventPackageSummary>.empty()
        : json.map((value) => new EventPackageSummary.fromJson(value)).toList();
  }

  static Map<String, EventPackageSummary> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EventPackageSummary>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new EventPackageSummary.fromJson(value));
    }
    return map;
  }
}
