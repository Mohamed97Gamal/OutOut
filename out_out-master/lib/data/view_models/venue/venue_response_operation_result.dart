import 'package:out_out/data/view_models/venue/venue_response.dart';

class VenueResponseOperationResult {
  late bool status;

  late VenueResponse result;

  late int errorCode;

   String? errorMessage;

  late List<String> errors = [];

  VenueResponseOperationResult();

  @override
  String toString() {
    return 'VenueResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  VenueResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new VenueResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<VenueResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueResponseOperationResult>.empty()
        : json.map((value) => new VenueResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, VenueResponseOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new VenueResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
