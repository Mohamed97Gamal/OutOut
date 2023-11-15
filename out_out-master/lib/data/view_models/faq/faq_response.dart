class FAQResponse {
  late String id;

  late int questionNumber;

  late String question;

  late String answer;

  FAQResponse();

  @override
  String toString() {
    return 'FAQResponse[id=$id, questionNumber=$questionNumber, question=$question, answer=$answer, ]';
  }

  FAQResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    questionNumber = json['questionNumber'];
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'questionNumber': questionNumber, 'question': question, 'answer': answer};
  }

  static List<FAQResponse> listFromJson(List<dynamic>? json) {
    return json == null ? new List<FAQResponse>.empty() : json.map((value) => new FAQResponse.fromJson(value)).toList();
  }

  static Map<String, FAQResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, FAQResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new FAQResponse.fromJson(value));
    }
    return map;
  }
}
