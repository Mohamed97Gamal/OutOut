class TelrBookingResponse {
  String? bookingUrl;

  late String bookingId;

  TelrBookingResponse();

  @override
  String toString() {
    return 'TelrBookingResponse[bookingUrl=$bookingUrl, bookingId=$bookingId, ]';
  }

  TelrBookingResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    bookingUrl = json['bookingUrl'];
    bookingId = json['bookingId'];
  }

  Map<String, dynamic> toJson() {
    return {'bookingUrl': bookingUrl, 'bookingId': bookingId};
  }

  static List<TelrBookingResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<TelrBookingResponse>.empty()
        : json.map((value) => new TelrBookingResponse.fromJson(value)).toList();
  }

  static Map<String, TelrBookingResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, TelrBookingResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new TelrBookingResponse.fromJson(value));
    }
    return map;
  }
}
