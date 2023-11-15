import 'package:out_out/data/models/enums/day_of_week.dart';
import 'package:out_out/data/view_models/time_span.dart';

class AvailableTimeResponse {
  late List<DayOfWeek> days = [];

  late TimeSpan from;

  late TimeSpan to;

  AvailableTimeResponse();

  bool isMatchingDate(DateTime date) {
    return days.any((day) => day.equalWeekDay(date.weekday));
  }

  bool isMatchingTime(DateTime time) {
    var timeInMinutes = (time.hour * 60) + time.minute;
    if (from.inMinutes <= timeInMinutes && timeInMinutes < to.inMinutes) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return 'AvailableTimeResponse[days=$days, from=$from, to=$to, ]';
  }

  AvailableTimeResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    days = DayOfWeek.listFromJson(json['days']);
    from = TimeSpan(json['from']);
    to = TimeSpan(json['to']);
  }

  Map<String, dynamic> toJson() {
    return {'days': days.map((e) => e.value).toList(), 'from': from.encode(), 'to': to.encode()};
  }

  static List<AvailableTimeResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<AvailableTimeResponse>.empty()
        : json.map((value) => new AvailableTimeResponse.fromJson(value)).toList();
  }

  static Map<String, AvailableTimeResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, AvailableTimeResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new AvailableTimeResponse.fromJson(value));
    }
    return map;
  }
}
