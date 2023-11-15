import 'package:out_out/data/models/enums/reminder_type.dart';

class VenueBookingReminderRequest {
  late String bookingId;

  late List<ReminderType> reminderTypes = [];

  VenueBookingReminderRequest();

  @override
  String toString() {
    return 'VenueBookingReminderRequest[bookingId=$bookingId, reminderTypes=$reminderTypes, ]';
  }

  VenueBookingReminderRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    bookingId = json['bookingId'];
    reminderTypes = ReminderType.listFromJson(json['reminderTypes']);
  }

  Map<String, dynamic> toJson() {
    return {'bookingId': bookingId, 'reminderTypes': reminderTypes.map((type) => type.value).toList()};
  }

  static List<VenueBookingReminderRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueBookingReminderRequest>.empty()
        : json.map((value) => new VenueBookingReminderRequest.fromJson(value)).toList();
  }

  static Map<String, VenueBookingReminderRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueBookingReminderRequest>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new VenueBookingReminderRequest.fromJson(value));
    }
    return map;
  }
}
