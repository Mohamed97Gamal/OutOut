// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_balance_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeBalanceDTO _$EmployeeBalanceDTOFromJson(Map<String, dynamic> json) {
  return EmployeeBalanceDTO(
    cycle: json['cycle'] == null
        ? null
        : CycleDTO.fromJson(json['cycle'] as Map<String, dynamic>),
    annualLeave: json['annualLeave'] as num?,
    totalAnnualLeave: json['totalAnnualLeave'] as num?,
    sickLeave: json['sickLeave'] as num?,
    totalSickLeave: json['totalSickLeave'] as num?,
    emergencyLeave: json['emergencyLeave'] as num?,
    totalEmergencyLeave: json['totalEmergencyLeave'] as num?,
    allocationLeave: json['allocationLeave'] as num?,
    totalAllocationLeave: json['totalAllocationLeave'] as num?,
    militaryLeave: json['militaryLeave'] as num?,
    totalMilitaryLeave: json['totalMilitaryLeave'] as num?,
    maternityLeave: json['maternityLeave'] as num?,
    totalMaternityLeave: json['totalMaternityLeave'] as num?,
    bereavementLeave: json['bereavementLeave'] as num?,
    totalBereavementLeave: json['totalBereavementLeave'] as num?,
    assignedShift: json['assignedShift'] == null
        ? null
        : AssignedShiftDTO.fromJson(
            json['assignedShift'] as Map<String, dynamic>),
    weekendDays: (json['weekendDays'] as List)?.map((e) => e as int)?.toList(),
    holidays: (json['holidays'] as List?)
        ?.map((e) => HolidayDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    leaveRequests: (json['leaveRequests'] as List?)
        ?.map((e) =>  PersonalLeavesDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EmployeeBalanceDTOToJson(EmployeeBalanceDTO instance) =>
    <String, dynamic>{
      'cycle': instance.cycle,
      'annualLeave': instance.annualLeave,
      'totalAnnualLeave': instance.totalAnnualLeave,
      'sickLeave': instance.sickLeave,
      'totalSickLeave': instance.totalSickLeave,
      'emergencyLeave': instance.emergencyLeave,
      'totalEmergencyLeave': instance.totalEmergencyLeave,
      'allocationLeave': instance.allocationLeave,
      'totalAllocationLeave': instance.totalAllocationLeave,
      'militaryLeave': instance.militaryLeave,
      'totalMilitaryLeave': instance.totalMilitaryLeave,
      'maternityLeave': instance.maternityLeave,
      'totalMaternityLeave': instance.totalMaternityLeave,
      'bereavementLeave': instance.bereavementLeave,
      'totalBereavementLeave': instance.totalBereavementLeave,
      'assignedShift': instance.assignedShift,
      'weekendDays': instance.weekendDays,
      'holidays': instance.holidays,
      'leaveRequests': instance.leaveRequests,
    };
