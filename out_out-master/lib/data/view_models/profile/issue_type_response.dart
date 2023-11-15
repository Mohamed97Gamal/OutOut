class IssueTypeResponse {
  late int id;

  late String name;

  IssueTypeResponse();

  @override
  String toString() {
    return 'IssueTypeResponse[id=$id, name=$name, ]';
  }

  IssueTypeResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  static List<IssueTypeResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<IssueTypeResponse>.empty()
        : json.map((value) => new IssueTypeResponse.fromJson(value)).toList();
  }

  static Map<String, IssueTypeResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, IssueTypeResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new IssueTypeResponse.fromJson(value));
    }
    return map;
  }
}
