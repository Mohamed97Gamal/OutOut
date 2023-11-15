import 'package:out_out/data/view_models/category/category_response.dart';

class CategoryResponseOperationResult {
  late bool status;

  late CategoryResponse result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  CategoryResponseOperationResult();

  @override
  String toString() {
    return 'CategoryResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  CategoryResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new CategoryResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<CategoryResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<CategoryResponseOperationResult>.empty()
        : json.map((value) => new CategoryResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, CategoryResponseOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, CategoryResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new CategoryResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
