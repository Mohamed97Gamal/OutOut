import 'package:out_out/data/view_models/event_booking/event_booking_summary_response.dart';

class EventBookingSummaryResponseOperationResult {
  late bool status;

  late EventBookingSummaryResponse result;

  late int errorCode;

  late String errorMessage;

  late List<String> errors = [];

  EventBookingSummaryResponseOperationResult();

  @override
  String toString() {
    return 'EventBookingSummaryResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  EventBookingSummaryResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new EventBookingSummaryResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<EventBookingSummaryResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<EventBookingSummaryResponseOperationResult>.empty()
        : json.map((value) => new EventBookingSummaryResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, EventBookingSummaryResponseOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EventBookingSummaryResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new EventBookingSummaryResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
