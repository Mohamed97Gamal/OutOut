import 'package:out_out/data/models/enums/venue_booking_status.dart';
import 'package:out_out/data/view_models/venue/venue_mini_summary_response.dart';

class VenueBookingResponse {
  late String id;

  late int bookingNumber;

  late int peopleNumber;

  late DateTime date;

  late VenueBookingStatus status;

  late VenueMiniSummaryResponse venue;

  VenueBookingResponse();

  @override
  String toString() {
    return 'VenueBookingResponse[id=$id, bookingNumber=$bookingNumber, peopleNumber=$peopleNumber, date=$date, status=$status, venue=$venue, ]';
  }

  VenueBookingResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    bookingNumber = json['bookingNumber'];
    peopleNumber = json['peopleNumber'];
    date = DateTime.parse(json['date']);
    status = new VenueBookingStatus.fromJson(json['status']);
    venue = new VenueMiniSummaryResponse.fromJson(json['venue']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingNumber': bookingNumber,
      'peopleNumber': peopleNumber,
      'date': date.toUtc().toIso8601String(),
      'status': status,
      'venue': venue
    };
  }

  static List<VenueBookingResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueBookingResponse>.empty()
        : json.map((value) => new VenueBookingResponse.fromJson(value)).toList();
  }

  static Map<String, VenueBookingResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueBookingResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new VenueBookingResponse.fromJson(value));
    }
    return map;
  }
}
