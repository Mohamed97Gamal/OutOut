import 'package:out_out/data/models/enums/my_booking.dart';

class MyBookingFilterationRequest {
  String? searchQuery;

  MyBooking? myBooking;

  MyBookingFilterationRequest();

  @override
  String toString() {
    return 'MyBookingFilterationRequest[searchQuery=$searchQuery, myBooking=$myBooking, ]';
  }

  MyBookingFilterationRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    searchQuery = json['searchQuery'];
    myBooking = new MyBooking.fromJson(json['myBooking']);
  }

  Map<String, dynamic> toJson() {
    return {'searchQuery': searchQuery, 'myBooking': myBooking?.value};
  }

  static List<MyBookingFilterationRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<MyBookingFilterationRequest>.empty()
        : json.map((value) => new MyBookingFilterationRequest.fromJson(value)).toList();
  }

  static Map<String, MyBookingFilterationRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, MyBookingFilterationRequest>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new MyBookingFilterationRequest.fromJson(value));
    }
    return map;
  }
}
