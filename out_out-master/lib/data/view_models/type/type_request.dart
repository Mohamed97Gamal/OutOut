import 'package:out_out/data/models/enums/type_for.dart';

class TypeRequest {
  late String name;

  late String icon;

  late TypeFor typeFor;

  late bool isActive;

  TypeRequest();

  @override
  String toString() {
    return 'TypeRequest[name=$name, icon=$icon, typeFor=$typeFor, isActive=$isActive, ]';
  }

  TypeRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    name = json['name'];
    icon = json['icon'];
    typeFor = new TypeFor.fromJson(json['typeFor']);
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'icon': icon, 'typeFor': typeFor, 'isActive': isActive};
  }

  static List<TypeRequest> listFromJson(List<dynamic>? json) {
    return json == null ? new List<TypeRequest>.empty() : json.map((value) => new TypeRequest.fromJson(value)).toList();
  }

  static Map<String, TypeRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, TypeRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new TypeRequest.fromJson(value));
    }
    return map;
  }
}
