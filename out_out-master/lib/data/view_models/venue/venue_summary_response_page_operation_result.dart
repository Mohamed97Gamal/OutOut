import 'package:out_out/data/view_models/venue/venue_summary_response_page.dart';

class VenueSummaryResponsePageOperationResult {
  late bool status;

  late VenueSummaryResponsePage result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  VenueSummaryResponsePageOperationResult();

  @override
  String toString() {
    return 'VenueSummaryResponsePageOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  VenueSummaryResponsePageOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new VenueSummaryResponsePage.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<VenueSummaryResponsePageOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueSummaryResponsePageOperationResult>.empty()
        : json.map((value) => new VenueSummaryResponsePageOperationResult.fromJson(value)).toList();
  }

  static Map<String, VenueSummaryResponsePageOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueSummaryResponsePageOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new VenueSummaryResponsePageOperationResult.fromJson(value));
    }
    return map;
  }
}
