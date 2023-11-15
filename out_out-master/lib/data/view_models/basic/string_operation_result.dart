class StringOperationResult {
  late bool status;

  String? result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  StringOperationResult();

  @override
  String toString() {
    return 'StringOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  StringOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = json['result'];
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<StringOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<StringOperationResult>.empty()
        : json.map((value) => new StringOperationResult.fromJson(value)).toList();
  }

  static Map<String, StringOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, StringOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StringOperationResult.fromJson(value));
    }
    return map;
  }
}
