class TicketQrcode {
  late String ticketId;
  late String ticketSecret;

  TicketQrcode();

  @override
  String toString() {
    return 'TicketQrcode[TicketId=$ticketId, ticketSecret=$ticketSecret, ]';
  }

  TicketQrcode.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    ticketId = json['ticketId'];
    ticketSecret = json['ticketSecret'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'ticketSecret': ticketSecret,
    };
  }

  static List<TicketQrcode> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<TicketQrcode>.empty()
        : json.map((value) => new TicketQrcode.fromJson(value)).toList();
  }

  static Map<String, TicketQrcode> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, TicketQrcode>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new TicketQrcode.fromJson(value));
    }
    return map;
  }
}
