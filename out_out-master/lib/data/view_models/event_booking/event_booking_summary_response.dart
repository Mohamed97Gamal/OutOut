import 'package:out_out/data/models/enums/payment_status.dart';
import 'package:out_out/data/models/enums/reminder_type.dart';
import 'package:out_out/data/view_models/event/event_summary_response.dart';
import 'package:out_out/data/view_models/event_booking/ticket_response.dart';
import 'package:out_out/data/view_models/venue/venue_mini_summary_response.dart';

class EventBookingSummaryResponse {
  late String id;

  late EventSummaryResponse event;

  late VenueMiniSummaryResponse venue;

  late int quantity;

  late num totalAmount;

  late String currency;

  late PaymentStatus status;

  late List<TicketResponse> tickets = [];

  late List<ReminderType> reminders = [];

  EventBookingSummaryResponse();

  @override
  String toString() {
    return 'EventBookingSummaryResponse[id=$id, event=$event, venue=$venue, quantity=$quantity, totalAmount=$totalAmount, currency=$currency, status=$status, tickets=$tickets, reminders=$reminders, ]';
  }

  EventBookingSummaryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    event = new EventSummaryResponse.fromJson(json['event']);
    venue = new VenueMiniSummaryResponse.fromJson(json['venue']);
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
      'event': event,
      'venue': venue,
      'quantity': quantity,
      'totalAmount': totalAmount,
      'currency': currency,
      'status': status,
      'tickets': tickets,
      'reminders': reminders
    };
  }

  static List<EventBookingSummaryResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<EventBookingSummaryResponse>.empty()
        : json.map((value) => new EventBookingSummaryResponse.fromJson(value)).toList();
  }

  static Map<String, EventBookingSummaryResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EventBookingSummaryResponse>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new EventBookingSummaryResponse.fromJson(value));
    }
    return map;
  }
}
