import 'package:out_out/data/view_models/event/single_event_occurrence_response.dart';

class SingleEventOccurrenceResponseOperationResult {
  late bool status;

  late SingleEventOccurrenceResponse result;

  late int errorCode;

   String? errorMessage;

  late List<String> errors = [];

  SingleEventOccurrenceResponseOperationResult();

  @override
  String toString() {
    return 'SingleEventOccurrenceResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  SingleEventOccurrenceResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new SingleEventOccurrenceResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<SingleEventOccurrenceResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<SingleEventOccurrenceResponseOperationResult>.empty()
        : json.map((value) => new SingleEventOccurrenceResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, SingleEventOccurrenceResponseOperationResult> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, SingleEventOccurrenceResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SingleEventOccurrenceResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
