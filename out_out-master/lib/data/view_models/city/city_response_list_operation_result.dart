import 'package:out_out/data/view_models/city/city_response.dart';

class CityResponseListOperationResult {
  late bool status;

  late List<CityResponse> result = [];

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  CityResponseListOperationResult();

  @override
  String toString() {
    return 'CityResponseListOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  CityResponseListOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = CityResponse.listFromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<CityResponseListOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<CityResponseListOperationResult>.empty()
        : json.map((value) => new CityResponseListOperationResult.fromJson(value)).toList();
  }

  static Map<String, CityResponseListOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, CityResponseListOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new CityResponseListOperationResult.fromJson(value));
    }
    return map;
  }
}
