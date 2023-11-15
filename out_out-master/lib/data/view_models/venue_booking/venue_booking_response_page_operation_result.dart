import 'package:out_out/data/view_models/venue_booking/venue_booking_response_page.dart';

class VenueBookingResponsePageOperationResult {
  late bool status;

  late VenueBookingResponsePage result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  VenueBookingResponsePageOperationResult();

  @override
  String toString() {
    return 'VenueBookingResponsePageOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  VenueBookingResponsePageOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new VenueBookingResponsePage.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<VenueBookingResponsePageOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueBookingResponsePageOperationResult>.empty()
        : json.map((value) => new VenueBookingResponsePageOperationResult.fromJson(value)).toList();
  }

  static Map<String, VenueBookingResponsePageOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueBookingResponsePageOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new VenueBookingResponsePageOperationResult.fromJson(value));
    }
    return map;
  }
}
