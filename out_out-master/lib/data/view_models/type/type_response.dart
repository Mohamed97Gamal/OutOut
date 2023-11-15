import 'package:out_out/data/models/enums/type_for.dart';

class TypeResponse {
  late String id;

  late String name;

  late String icon;

  late TypeFor typeFor;

  late bool isActive;

  TypeResponse();

  @override
  String toString() {
    return 'TypeResponse[id=$id, name=$name, icon=$icon, typeFor=$typeFor, isActive=$isActive, ]';
  }

  TypeResponse.fromJson(Map<String, dynamic>? json) {
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

  static List<TypeResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<TypeResponse>.empty()
        : json.map((value) => new TypeResponse.fromJson(value)).toList();
  }

  static Map<String, TypeResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, TypeResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new TypeResponse.fromJson(value));
    }
    return map;
  }
}
