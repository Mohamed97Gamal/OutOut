// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_holiday_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CycleHoliday _$CycleHolidayFromJson(Map<String, dynamic> json) {
  return CycleHoliday(
    cycleId: json['cycleId'] as String,
    holidays: (json['holidays'] as List?)
        ?.map((e) => HolidayDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CycleHolidayToJson(CycleHoliday instance) =>
    <String, dynamic>{
      'cycleId': instance.cycleId,
      'holidays': instance.holidays,
    };

CycleHolidayResponse _$CycleHolidayResponseFromJson(Map<String, dynamic> json) {
  return CycleHolidayResponse(
    status: json['status'] as bool,
    result: json['result'] as bool,
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CycleHolidayResponseToJson(
        CycleHolidayResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };
