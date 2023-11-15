import 'package:out_out/data/models/enums/type_for.dart';

class CategoryRequest {
  late String name;

  late String icon;

  late TypeFor typeFor;

  late bool isActive;

  CategoryRequest();

  @override
  String toString() {
    return 'CategoryRequest[name=$name, icon=$icon, typeFor=$typeFor, isActive=$isActive, ]';
  }

  CategoryRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    name = json['name'];
    icon = json['icon'];
    typeFor = new TypeFor.fromJson(json['typeFor']);
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'icon': icon, 'typeFor': typeFor, 'isActive': isActive};
  }

  static List<CategoryRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<CategoryRequest>.empty()
        : json.map((value) => new CategoryRequest.fromJson(value)).toList();
  }

  static Map<String, CategoryRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, CategoryRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CategoryRequest.fromJson(value));
    }
    return map;
  }
}
