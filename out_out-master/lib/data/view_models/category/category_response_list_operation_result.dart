import 'package:out_out/data/view_models/category/category_response.dart';

class CategoryResponseListOperationResult {
  late bool status;

  late List<CategoryResponse> result = [];

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  CategoryResponseListOperationResult();

  @override
  String toString() {
    return 'CategoryResponseListOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  CategoryResponseListOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = CategoryResponse.listFromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<CategoryResponseListOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<CategoryResponseListOperationResult>.empty()
        : json.map((value) => new CategoryResponseListOperationResult.fromJson(value)).toList();
  }

  static Map<String, CategoryResponseListOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, CategoryResponseListOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CategoryResponseListOperationResult.fromJson(value));
    }
    return map;
  }
}
