import 'package:out_out/data/view_models/venue/venue_response_page.dart';

class VenueResponsePageOperationResult {
  late bool status;

  late VenueResponsePage result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  VenueResponsePageOperationResult();

  @override
  String toString() {
    return 'VenueResponsePageOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  VenueResponsePageOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new VenueResponsePage.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<VenueResponsePageOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueResponsePageOperationResult>.empty()
        : json.map((value) => new VenueResponsePageOperationResult.fromJson(value)).toList();
  }

  static Map<String, VenueResponsePageOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueResponsePageOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new VenueResponsePageOperationResult.fromJson(value));
    }
    return map;
  }
}
