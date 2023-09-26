// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HolidayDTO _$HolidayDTOFromJson(Map<String, dynamic> json) {
  return HolidayDTO(
    id: json['id'] as String,
    name: json['name'] as String,
    from: json['from'] == null ? null : DateTime.parse(json['from'] as String),
    to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
  );
}

Map<String, dynamic> _$HolidayDTOToJson(HolidayDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'from': instance.from?.toIso8601String(),
      'to': instance.to?.toIso8601String(),
    };

HolidayDTOResponse _$HolidayDTOResponseFromJson(Map<String, dynamic> json) {
  return HolidayDTOResponse(
    status: json['status'] as bool,
    result: json['result'] == null
        ? null
        : HolidayDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$HolidayDTOResponseToJson(HolidayDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

HolidayDTOListResponse _$HolidayDTOListResponseFromJson(
    Map<String, dynamic> json) {
  return HolidayDTOListResponse(
    status: json['status'] as bool,
    result: (json['result'] as List?)
        ?.map((e) => HolidayDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$HolidayDTOListResponseToJson(
        HolidayDTOListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };
