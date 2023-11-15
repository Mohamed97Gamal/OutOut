import 'package:intl/intl.dart';
import 'package:out_out/data/view_models/event/event_package_response.dart';
import 'package:out_out/data/view_models/time_span.dart';
import 'package:out_out/utils/date_utils.dart';

class EventOccurrenceResponse {
  late String id;

  late DateTime startDate;

  late DateTime endDate;

  late TimeSpan startTime;

  late TimeSpan endTime;

  String explainDateOnly([DateFormat? format]) {
    format ??= EventDateFormat;
    return "${format.format(startDate)}";
  }

  String explain() {
    return "${EventDateFormat.format(startDate)} at ${startTime}";
  }

  List<EventPackageResponse> packages = [];

  EventOccurrenceResponse();

  @override
  String toString() {
    return 'EventOccurrenceResponse[id=$id, startDate=$startDate, endDate=$endDate, startTime=$startTime, endTime=$endTime, packages=$packages, ]';
  }

  EventOccurrenceResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    startDate = DateTime.parse(json['startDate']);
    endDate = DateTime.parse(json['endDate']);
    startTime = TimeSpan(json['startTime']);
    endTime = TimeSpan(json['endTime']);
    packages = EventPackageResponse.listFromJson(json['packages']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDate': startDate.toUtc().toIso8601String(),
      'endDate': endDate.toUtc().toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'packages': packages
    };
  }

  static List<EventOccurrenceResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<EventOccurrenceResponse>.empty()
        : json.map((value) => new EventOccurrenceResponse.fromJson(value)).toList();
  }

  static Map<String, EventOccurrenceResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EventOccurrenceResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new EventOccurrenceResponse.fromJson(value));
    }
    return map;
  }
}
