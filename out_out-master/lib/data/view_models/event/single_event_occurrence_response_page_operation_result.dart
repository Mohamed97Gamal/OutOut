import 'package:out_out/data/view_models/event/single_event_occurrence_response_page.dart';

class SingleEventOccurrenceResponsePageOperationResult {
  late bool status;

  late SingleEventOccurrenceResponsePage result;

  late int errorCode;

   String? errorMessage;

  late List<String> errors = [];

  SingleEventOccurrenceResponsePageOperationResult();

  @override
  String toString() {
    return 'SingleEventOccurrenceResponsePageOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  SingleEventOccurrenceResponsePageOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new SingleEventOccurrenceResponsePage.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<SingleEventOccurrenceResponsePageOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<SingleEventOccurrenceResponsePageOperationResult>.empty()
        : json.map((value) => new SingleEventOccurrenceResponsePageOperationResult.fromJson(value)).toList();
  }

  static Map<String, SingleEventOccurrenceResponsePageOperationResult> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, SingleEventOccurrenceResponsePageOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SingleEventOccurrenceResponsePageOperationResult.fromJson(value));
    }
    return map;
  }
}
