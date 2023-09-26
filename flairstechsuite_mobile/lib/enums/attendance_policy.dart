import 'package:json_annotation/json_annotation.dart';

enum AttendancePolicy {
  @JsonValue(0)
  Restrict,
  @JsonValue(1)
  Flexible,
  @JsonValue(2)
  Careless
}
