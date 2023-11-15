import 'package:out_out/data/view_models/type/type_response.dart';

class TypeResponseListOperationResult {
  late bool status;

  late List<TypeResponse> result = [];

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  TypeResponseListOperationResult();

  @override
  String toString() {
    return 'TypeResponseListOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  TypeResponseListOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = TypeResponse.listFromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<TypeResponseListOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<TypeResponseListOperationResult>.empty()
        : json.map((value) => new TypeResponseListOperationResult.fromJson(value)).toList();
  }

  static Map<String, TypeResponseListOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, TypeResponseListOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new TypeResponseListOperationResult.fromJson(value));
    }
    return map;
  }
}
