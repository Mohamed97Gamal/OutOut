import 'package:out_out/data/models/enums/type_for.dart';

class Type {
  late String id;

  late String name;

  late String icon;

  late TypeFor typeFor;

  late bool isActive;

  Type();

  @override
  String toString() {
    return 'Type[id=$id, name=$name, icon=$icon, typeFor=$typeFor, isActive=$isActive, ]';
  }

  Type.fromJson(Map<String, dynamic>? json) {
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

  static List<Type> listFromJson(List<dynamic>? json) {
    return json == null ? new List<Type>.empty() : json.map((value) => new Type.fromJson(value)).toList();
  }

  static Map<String, Type> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, Type>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Type.fromJson(value));
    }
    return map;
  }
}
