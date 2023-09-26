import 'package:json_annotation/json_annotation.dart';

enum DayOfWeek {
  @JsonValue(0)
  sunday,
  @JsonValue(1)
  monday,
  @JsonValue(2)
  tuesday,
  @JsonValue(3)
  wednesday,
  @JsonValue(4)
  thursday,
  @JsonValue(5)
  friday,
  @JsonValue(6)
  saturday
}

extension DayOfWeekProps on DayOfWeek? {
  String? get name {
    switch (this) {
      case DayOfWeek.sunday:
        return "Sun";
      case DayOfWeek.monday:
        return "Mon";
      case DayOfWeek.tuesday:
        return "Tue";
      case DayOfWeek.wednesday:
        return "Wed";
      case DayOfWeek.thursday:
        return "Thu";
      case DayOfWeek.friday:
        return "Fri";
      case DayOfWeek.saturday:
        return "Sat";
      default:
        return null;
    }
  }
}
