import 'package:out_out/data/view_models/venue_booking/venue_booking_response.dart';

class VenueBookingResponseOperationResult {
  late bool status;

  late VenueBookingResponse result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  VenueBookingResponseOperationResult();

  @override
  String toString() {
    return 'VenueBookingResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  VenueBookingResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new VenueBookingResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<VenueBookingResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueBookingResponseOperationResult>.empty()
        : json.map((value) => new VenueBookingResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, VenueBookingResponseOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueBookingResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new VenueBookingResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
