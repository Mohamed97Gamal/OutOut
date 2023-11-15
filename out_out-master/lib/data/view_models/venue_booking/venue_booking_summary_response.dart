import 'package:out_out/data/models/enums/reminder_type.dart';
import 'package:out_out/data/models/enums/venue_booking_status.dart';

class VenueBookingSummaryResponse {
  late String id;

  late int bookingNumber;

  late int peopleNumber;

  late DateTime date;

  late VenueBookingStatus status;

  late List<ReminderType> remindersTypes;

  VenueBookingSummaryResponse();

  @override
  String toString() {
    return 'VenueBookingSummaryResponse[id=$id, bookingNumber=$bookingNumber, peopleNumber=$peopleNumber, date=$date, status=$status, remindersTypes= $remindersTypes]';
  }

  VenueBookingSummaryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    bookingNumber = json['bookingNumber'];
    peopleNumber = json['peopleNumber'];
    date = DateTime.parse(json['date']);
    status = new VenueBookingStatus.fromJson(json['status']);
    remindersTypes = ReminderType.listFromJson(json['remindersTypes']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingNumber': bookingNumber,
      'peopleNumber': peopleNumber,
      'date': date,
      'status': status,
      'remindersTypes': remindersTypes,
    };
  }

  static List<VenueBookingSummaryResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueBookingSummaryResponse>.empty()
        : json.map((value) => new VenueBookingSummaryResponse.fromJson(value)).toList();
  }

  static Map<String, VenueBookingSummaryResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueBookingSummaryResponse>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new VenueBookingSummaryResponse.fromJson(value));
    }
    return map;
  }
}
