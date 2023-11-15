import 'package:out_out/data/view_models/event/event_summary_response_page.dart';

class EventSummaryResponsePageOperationResult {
  late bool status;

  late EventSummaryResponsePage result;

  late int errorCode;

   String? errorMessage;

  late List<String> errors = [];

  EventSummaryResponsePageOperationResult();

  @override
  String toString() {
    return 'EventSummaryResponsePageOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  EventSummaryResponsePageOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new EventSummaryResponsePage.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<EventSummaryResponsePageOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<EventSummaryResponsePageOperationResult>.empty()
        : json.map((value) => new EventSummaryResponsePageOperationResult.fromJson(value)).toList();
  }

  static Map<String, EventSummaryResponsePageOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EventSummaryResponsePageOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new EventSummaryResponsePageOperationResult.fromJson(value));
    }
    return map;
  }
}
