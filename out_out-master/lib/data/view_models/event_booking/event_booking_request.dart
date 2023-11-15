part of swagger.api;

class EventBookingRequest {
  late String eventOccurrenceId;

  late int quantity;

  // range from 1 to 10//

  late String packageId;

  late double totalAmount;

  EventBookingRequest();

  @override
  String toString() {
    return 'EventBookingRequest[eventOccurrenceId=$eventOccurrenceId, quantity=$quantity, packageId=$packageId, totalAmount=$totalAmount, ]';
  }

  EventBookingRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    eventOccurrenceId = json['eventOccurrenceId'];
    quantity = json['quantity'];
    packageId = json['packageId'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    return {
      'eventOccurrenceId': eventOccurrenceId,
      'quantity': quantity,
      'packageId': packageId,
      'totalAmount': totalAmount
    };
  }

  static List<EventBookingRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<EventBookingRequest>.empty()
        : json.map((value) => new EventBookingRequest.fromJson(value)).toList();
  }

  static Map<String, EventBookingRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EventBookingRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new EventBookingRequest.fromJson(value));
    }
    return map;
  }
}
