class TicketRedemptionRequest {
  late String ticketId;

  late String eventCode;

  late String ticketSecret;

  TicketRedemptionRequest();

  @override
  String toString() {
    return 'TicketRedemptionRequest[ticketId=$ticketId, eventCode=$eventCode, ticketSecret=$ticketSecret, ]';
  }

  TicketRedemptionRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    ticketId = json['ticketId'];
    eventCode = json['eventCode'];
    ticketSecret = json['ticketSecret'];
  }

  Map<String, dynamic> toJson() {
    return {'ticketId': ticketId, 'eventCode': eventCode, 'ticketSecret': ticketSecret};
  }

  static List<TicketRedemptionRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<TicketRedemptionRequest>.empty()
        : json.map((value) => new TicketRedemptionRequest.fromJson(value)).toList();
  }

  static Map<String, TicketRedemptionRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, TicketRedemptionRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new TicketRedemptionRequest.fromJson(value));
    }
    return map;
  }
}
