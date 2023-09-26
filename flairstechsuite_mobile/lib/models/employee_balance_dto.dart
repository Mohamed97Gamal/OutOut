import 'package:flairstechsuite_mobile/features/my_calendar/data/models/personal_leave_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../features/cycles/data/model/cycle/cycle_dto.dart';
import '../features/cycles/data/model/holiday/holiday_dto.dart';
import 'api/responses.dart';

part 'employee_balance_dto.g.dart';

@JsonSerializable()
class EmployeeBalanceDTO {
  CycleDTO? cycle;
  num? annualLeave;
  num? totalAnnualLeave;
  num? sickLeave;
  num? totalSickLeave;
  num? emergencyLeave;
  num? totalEmergencyLeave;
  num? allocationLeave;
  num? totalAllocationLeave;
  num? militaryLeave;
  num? totalMilitaryLeave;
  num? maternityLeave;
  num? totalMaternityLeave;
  num? bereavementLeave;
  num? totalBereavementLeave;
  AssignedShiftDTO? assignedShift;
  List<int>? weekendDays;
  List<HolidayDTO>? holidays;
  List<PersonalLeavesDTO>? leaveRequests;

  EmployeeBalanceDTO({
    this.cycle,
    this.annualLeave,
    this.totalAnnualLeave,
    this.sickLeave,
    this.totalSickLeave,
    this.emergencyLeave,
    this.totalEmergencyLeave,
    this.allocationLeave,
    this.totalAllocationLeave,
    this.militaryLeave,
    this.totalMilitaryLeave,
    this.maternityLeave,
    this.totalMaternityLeave,
    this.bereavementLeave,
    this.totalBereavementLeave,
    this.assignedShift,
    this.weekendDays,
    this.holidays,
    this.leaveRequests,
});


  factory EmployeeBalanceDTO.fromJson(Map<String, dynamic> json) => _$EmployeeBalanceDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeBalanceDTOToJson(this);


}
