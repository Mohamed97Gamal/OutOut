class FAQRequest {
  late String question;

  late String answer;

  FAQRequest();

  @override
  String toString() {
    return 'FAQRequest[question=$question, answer=$answer, ]';
  }

  FAQRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    return {'question': question, 'answer': answer};
  }

  static List<FAQRequest> listFromJson(List<dynamic>? json) {
    return json == null ? new List<FAQRequest>.empty() : json.map((value) => new FAQRequest.fromJson(value)).toList();
  }

  static Map<String, FAQRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, FAQRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new FAQRequest.fromJson(value));
    }
    return map;
  }
}
