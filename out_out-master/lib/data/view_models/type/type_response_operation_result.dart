import 'package:out_out/data/view_models/type/type_response.dart';

class TypeResponseOperationResult {
  late bool status;

  late TypeResponse result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  TypeResponseOperationResult();

  @override
  String toString() {
    return 'TypeResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  TypeResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new TypeResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<TypeResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<TypeResponseOperationResult>.empty()
        : json.map((value) => new TypeResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, TypeResponseOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, TypeResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new TypeResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
