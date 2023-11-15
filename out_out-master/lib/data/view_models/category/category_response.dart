import 'package:out_out/data/models/enums/type_for.dart';

class CategoryResponse {
  late String id;

  late String name;

  String? icon;

  late TypeFor typeFor;

  late bool isActive;

  CategoryResponse();

  @override
  String toString() {
    return 'CategoryResponse[id=$id, name=$name, icon=$icon, typeFor=$typeFor, isActive=$isActive, ]';
  }

  CategoryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    typeFor = new TypeFor.fromJson(json['typeFor']);
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon': icon, 'typeFor': typeFor, 'isActive': isActive};
  }

  static List<CategoryResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<CategoryResponse>.empty()
        : json.map((value) => new CategoryResponse.fromJson(value)).toList();
  }

  static Map<String, CategoryResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, CategoryResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CategoryResponse.fromJson(value));
    }
    return map;
  }
}
