import 'package:out_out/data/view_models/available_time_response.dart';

class VenueMiniSummaryResponse {
  String? id;

  String? logo;

  late String name = "";

  late List<AvailableTimeResponse> openTimes = [];

  VenueMiniSummaryResponse();

  @override
  String toString() {
    return 'VenueMiniSummaryResponse[id=$id, logo=$logo, name=$name, openTimes=$openTimes, ]';
  }

  VenueMiniSummaryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    logo = json['logo'];
    name = json['name'];
    openTimes = AvailableTimeResponse.listFromJson(json['openTimes']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'logo': logo, 'name': name, 'openTimes': openTimes};
  }

  static List<VenueMiniSummaryResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueMiniSummaryResponse>.empty()
        : json.map((value) => new VenueMiniSummaryResponse.fromJson(value)).toList();
  }

  static Map<String, VenueMiniSummaryResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueMiniSummaryResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new VenueMiniSummaryResponse.fromJson(value));
    }
    return map;
  }
}
