class BooleanOperationResult {
  late bool status;

  late bool result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  BooleanOperationResult();

  @override
  String toString() {
    return 'BooleanOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  BooleanOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = json['result'] ?? false;
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<BooleanOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<BooleanOperationResult>.empty()
        : json.map((value) => new BooleanOperationResult.fromJson(value)).toList();
  }

  static Map<String, BooleanOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, BooleanOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new BooleanOperationResult.fromJson(value));
    }
    return map;
  }
}
