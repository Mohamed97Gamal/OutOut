class TermsAndConditionsResponse {
  late String id;

  late String termCondition;

  TermsAndConditionsResponse();

  @override
  String toString() {
    return 'TermsAndConditionsResponse[id=$id, termCondition=$termCondition, ]';
  }

  TermsAndConditionsResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    termCondition = json['termCondition'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'termCondition': termCondition};
  }

  static List<TermsAndConditionsResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<TermsAndConditionsResponse>.empty()
        : json.map((value) => new TermsAndConditionsResponse.fromJson(value)).toList();
  }

  static Map<String, TermsAndConditionsResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, TermsAndConditionsResponse>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new TermsAndConditionsResponse.fromJson(value));
    }
    return map;
  }
}
