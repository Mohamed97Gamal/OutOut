import 'package:out_out/data/models/enums/payment_status.dart';
import 'package:out_out/data/models/enums/reminder_type.dart';
import 'package:out_out/data/view_models/event/event_summary_response.dart';
import 'package:out_out/data/view_models/event_booking/ticket_response.dart';
import 'package:out_out/data/view_models/venue/venue_mini_summary_response.dart';

class SingleEventBookingTicketSummaryResponse {

  late String id;

  late EventSummaryResponse event;

  late VenueMiniSummaryResponse venue;

  late TicketResponse ticket;

  late PaymentStatus status;

  late List<ReminderType> reminders = [];

  SingleEventBookingTicketSummaryResponse();

  @override
  String toString() {
    return 'SingleEventBookingTicketSummaryResponse[id=$id, event=$event, venue=$venue, ticket=$ticket, status=$status, reminders=$reminders, ]';
  }

  SingleEventBookingTicketSummaryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    event = new EventSummaryResponse.fromJson(json['event']);
    venue = new VenueMiniSummaryResponse.fromJson(json['venue']);
    ticket = new TicketResponse.fromJson(json['ticket']);
    status = new PaymentStatus.fromJson(json['status']);
    reminders = ReminderType.listFromJson(json['reminders']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event': event,
      'venue': venue,
      'ticket': ticket,
      'status': status,
      'reminders': reminders
     };
  }

  static List<SingleEventBookingTicketSummaryResponse> listFromJson(List<dynamic>? json) {
    return json == null ? new List<SingleEventBookingTicketSummaryResponse>.empty() : json.map((value) => new SingleEventBookingTicketSummaryResponse.fromJson(value)).toList();
  }

  static Map<String, SingleEventBookingTicketSummaryResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, SingleEventBookingTicketSummaryResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new SingleEventBookingTicketSummaryResponse.fromJson(value));
    }
    return map;
  }
}
