import 'package:out_out/data/view_models/home/home_page_response.dart';

class HomePageResponseOperationResult {
  late bool status;

  late HomePageResponse result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  HomePageResponseOperationResult();

  @override
  String toString() {
    return 'HomePageResponseOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  HomePageResponseOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new HomePageResponse.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<HomePageResponseOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<HomePageResponseOperationResult>.empty()
        : json.map((value) => new HomePageResponseOperationResult.fromJson(value)).toList();
  }

  static Map<String, HomePageResponseOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, HomePageResponseOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new HomePageResponseOperationResult.fromJson(value));
    }
    return map;
  }
}
