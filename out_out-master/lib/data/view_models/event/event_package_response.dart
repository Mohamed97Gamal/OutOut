class EventPackageResponse {
  String? id;

  late String title;

  late num price;

  String? note;

  int? ticketsNumber;

  bool? isSoldOut;

  EventPackageResponse();

  @override
  String toString() {
    return 'EventPackageResponse[id=$id, title=$title, price=$price, note=$note, ticketsNumber=$ticketsNumber, isSoldOut=$isSoldOut, ]';
  }

  EventPackageResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    title = json['title'];
    price = json['price'];
    note = json['note'];
    ticketsNumber = json['ticketsNumber'];
    isSoldOut = json['isSoldOut'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'note': note,
      'ticketsNumber': ticketsNumber,
      'isSoldOut': isSoldOut
    };
  }

  static List<EventPackageResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<EventPackageResponse>.empty()
        : json.map((value) => new EventPackageResponse.fromJson(value)).toList();
  }

  static Map<String, EventPackageResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EventPackageResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new EventPackageResponse.fromJson(value));
    }
    return map;
  }
}
