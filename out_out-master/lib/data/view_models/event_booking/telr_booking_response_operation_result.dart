import 'package:out_out/data/view_models/event_booking/telr_booking_response.dart';

class TelrBookingResponseOperationResult {
  late bool status;

  late TelrBookingResponse result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  TelrBookingResponseOperationResult();

  @override
  String toString() {
    return 'TelrBookingResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  TelrBookingResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new TelrBookingResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<TelrBookingResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<TelrBookingResponseOperationResult>.empty()
        : json.map((value) => new TelrBookingResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, TelrBookingResponseOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, TelrBookingResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new TelrBookingResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
