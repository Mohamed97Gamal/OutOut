import 'package:out_out/data/models/enums/payment_status.dart';
import 'package:out_out/data/models/enums/reminder_type.dart';
import 'package:out_out/data/view_models/event_booking/ticket_response.dart';

class EventBookingMiniSummaryResponse {
  late String id;

  late int quantity;

  late num totalAmount;

  late String currency;

  late PaymentStatus status;

  late List<TicketResponse> tickets = [];

  late List<ReminderType> reminders = [];

  EventBookingMiniSummaryResponse();

  @override
  String toString() {
    return 'EventBookingMiniSummaryResponse[id=$id, quantity=$quantity, totalAmount=$totalAmount, currency=$currency, status=$status, tickets=$tickets, reminders=$reminders, ]';
  }

  EventBookingMiniSummaryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    quantity = json['quantity'];
    totalAmount = json['totalAmount'].toDouble();
    currency = json['currency'];
    status = new PaymentStatus.fromJson(json['status']);
    tickets = TicketResponse.listFromJson(json['tickets']);
    reminders = ReminderType.listFromJson(json['reminders']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'totalAmount': totalAmount,
      'currency': currency,
      'status': status,
      'tickets': tickets,
      'reminders': reminders
    };
  }

  static List<EventBookingMiniSummaryResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<EventBookingMiniSummaryResponse>.empty()
        : json.map((value) => new EventBookingMiniSummaryResponse.fromJson(value)).toList();
  }

  static Map<String, EventBookingMiniSummaryResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EventBookingMiniSummaryResponse>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new EventBookingMiniSummaryResponse.fromJson(value));
    }
    return map;
  }
}
