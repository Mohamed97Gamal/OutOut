class ActivatedOffer {
  late bool status;

   bool? result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  ActivatedOffer();

  @override
  String toString() {
    return 'ActivatedOffer[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  ActivatedOffer.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = json['result'];
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'result': result,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
      'errors': errors
    };
  }

  static List<ActivatedOffer> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<ActivatedOffer>.empty()
        : json.map((value) => new ActivatedOffer.fromJson(value)).toList();
  }

  static Map<String, ActivatedOffer> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, ActivatedOffer>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ActivatedOffer.fromJson(value));
    }
    return map;
  }
}
