import 'package:json_annotation/json_annotation.dart';

enum LeaveType {
  @JsonValue(0)
  annualLeave,
  @JsonValue(1)
  sickLeave,
  @JsonValue(2)
  emergencyLeave,
  @JsonValue(3)
  militaryLeave,
  @JsonValue(4)
  maternityLeave,
  @JsonValue(5)
  bereavementLeave,
}

extension LeaveTypeProps on LeaveType {
  String? get name {
    switch (this) {
      case LeaveType.annualLeave:
        return "Annual Leave";
      case LeaveType.sickLeave:
        return "Sick Leave";
      case LeaveType.emergencyLeave:
        return "Emergency Leave";
      case LeaveType.militaryLeave:
        return "Military Leave";
      case LeaveType.maternityLeave:
        return "Maternity Leave";
      case LeaveType.bereavementLeave:
        return "Bereavement Leave";
      default:
        return null;
    }
  }
}
