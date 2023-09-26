// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_leave_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuickLeaveDTO _$QuickLeaveDTOFromJson(Map<String, dynamic> json) {
  return QuickLeaveDTO(
    imagePaths: (json['imagePaths'] as List)?.map((e) => e as String)?.toList(),
    reason: json['reason'] as String,
    from: json['from'] == null ? null : DateTime.parse(json['from'] as String),
    to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
    halfDayType: json['halfDayType'] as int,
  );
}

Map<String, dynamic> _$QuickLeaveDTOToJson(QuickLeaveDTO instance) =>
    <String, dynamic>{
      'imagePaths': instance.imagePaths,
      'reason': instance.reason,
      'from': instance.from?.toIso8601String(),
      'to': instance.to?.toIso8601String(),
      'halfDayType': instance.halfDayType,
    };

QuickLeaveDTOResponse _$QuickLeaveDTOResponseFromJson(
    Map<String, dynamic> json) {
  return QuickLeaveDTOResponse(
    status: json['status'] as bool,
    result: json['result'] == null
        ? null
        : QuickLeaveDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$QuickLeaveDTOResponseToJson(
        QuickLeaveDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };
