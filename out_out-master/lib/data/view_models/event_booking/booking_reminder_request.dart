import 'package:out_out/data/models/enums/reminder_type.dart';

class BookingReminderRequest {
  late String bookingId;

  late List<ReminderType> reminderTypes = [];

  BookingReminderRequest();

  @override
  String toString() {
    return 'BookingReminderRequest[bookingId=$bookingId, reminderTypes=$reminderTypes, ]';
  }

  BookingReminderRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    bookingId = json['bookingId'];
    reminderTypes = ReminderType.listFromJson(json['reminderTypes']);
  }

  Map<String, dynamic> toJson() {
    return {'bookingId': bookingId, 'reminderTypes': reminderTypes.map((type) => type.value).toList()};
  }

  static List<BookingReminderRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<BookingReminderRequest>.empty()
        : json.map((value) => new BookingReminderRequest.fromJson(value)).toList();
  }

  static Map<String, BookingReminderRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, BookingReminderRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new BookingReminderRequest.fromJson(value));
    }
    return map;
  }
}
