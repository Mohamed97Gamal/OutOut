import 'package:out_out/data/view_models/city/city_response.dart';

class CityResponseOperationResult {
  late bool status;

  late CityResponse result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  CityResponseOperationResult();

  @override
  String toString() {
    return 'CityResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  CityResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new CityResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<CityResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<CityResponseOperationResult>.empty()
        : json.map((value) => new CityResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, CityResponseOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, CityResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new CityResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
