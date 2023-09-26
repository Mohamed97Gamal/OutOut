// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarDto _$CalendarDtoFromJson(Map<String, dynamic> json) {
  return CalendarDto(
    weekendDays: (json['weekendDays'] as List)?.map((e) => e as int)?.toList(),
    holidays: (json['holidays'] as List?)
        ?.map((e) => HolidayDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    leaveRequests: (json['leaveRequests'] as List?)
        ?.map((e) =>  PersonalLeavesDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CalendarDtoToJson(CalendarDto instance) =>
    <String, dynamic>{
      'weekendDays': instance.weekendDays,
      'holidays': instance.holidays,
      'leaveRequests': instance.leaveRequests,
    };

CalendarDtoResponse _$CalendarDtoResponseFromJson(Map<String, dynamic> json) {
  return CalendarDtoResponse(
    status: json['status'] as bool,
    result: json['result'] == null
        ? null
        : CalendarDto.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CalendarDtoResponseToJson(
        CalendarDtoResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };
