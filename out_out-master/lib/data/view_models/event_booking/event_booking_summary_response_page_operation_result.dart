import 'package:out_out/data/view_models/event_booking/event_booking_summary_response_page.dart';

class EventBookingSummaryResponsePageOperationResult {
  late bool status;

  late EventBookingSummaryResponsePage result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  EventBookingSummaryResponsePageOperationResult();

  @override
  String toString() {
    return 'EventBookingSummaryResponsePageOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  EventBookingSummaryResponsePageOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new EventBookingSummaryResponsePage.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<EventBookingSummaryResponsePageOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<EventBookingSummaryResponsePageOperationResult>.empty()
        : json.map((value) => new EventBookingSummaryResponsePageOperationResult.fromJson(value)).toList();
  }

  static Map<String, EventBookingSummaryResponsePageOperationResult> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EventBookingSummaryResponsePageOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new EventBookingSummaryResponsePageOperationResult.fromJson(value));
    }
    return map;
  }
}
