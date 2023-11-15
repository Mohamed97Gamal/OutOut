
class ShareTicketRequest {
  
  late String ticketId;

  late String ticketSecret;

  ShareTicketRequest();

  @override
  String toString() {
    return 'ShareTicketRequest[ticketId=$ticketId, ticketSecret=$ticketSecret, ]';
  }

  ShareTicketRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    ticketId = json['ticketId'];
    ticketSecret = json['ticketSecret'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'ticketSecret': ticketSecret
     };
  }

  static List<ShareTicketRequest> listFromJson(List<dynamic>? json) {
    return json == null ? new List<ShareTicketRequest>.empty() : json.map((value) => new ShareTicketRequest.fromJson(value)).toList();
  }

  static Map<String, ShareTicketRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, ShareTicketRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ShareTicketRequest.fromJson(value));
    }
    return map;
  }
}
