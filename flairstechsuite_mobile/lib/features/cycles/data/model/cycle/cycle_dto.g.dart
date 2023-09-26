// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CycleDTO _$CycleDTOFromJson(Map<String, dynamic> json) {
  return CycleDTO(
    id: json['id'] as String?,
    name: json['name'] as String?,
    from: json['from'] == null ? null : DateTime.parse(json['from'] as String),
    to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
    isCurrent: json['isCurrent'] as bool?,
    country: json['country'] as int?,
    holidays: (json['holidays'] as List?)
        ?.map((e) => HolidayDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CycleDTOToJson(CycleDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'from': instance.from?.toIso8601String(),
      'to': instance.to?.toIso8601String(),
      'isCurrent': instance.isCurrent,
      'country': instance.country,
      'holidays': instance.holidays,
    };

CycleDTOResponse _$CycleDTOResponseFromJson(Map<String, dynamic> json) {
  return CycleDTOResponse(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : CycleDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CycleDTOResponseToJson(CycleDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

CycleDTOListResponse _$CycleDTOListResponseFromJson(Map<String, dynamic> json) {
  return CycleDTOListResponse(
    status: json['status'] as bool?,
    result: (json['result'] as List?)
        ?.map((e) => CycleDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CycleDTOListResponseToJson(
        CycleDTOListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

CycleCountryDTO _$CycleCountryDTOFromJson(Map<String, dynamic> json) {
  return CycleCountryDTO(
    name: json['name'] as String?,
    value: json['value'] as int?,
  );
}

Map<String, dynamic> _$CycleCountryDTOToJson(CycleCountryDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

CycleCountryDTOResponse _$CycleCountryDTOResponseFromJson(
    Map<String, dynamic> json) {
  return CycleCountryDTOResponse(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : CycleCountryDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CycleCountryDTOResponseToJson(
        CycleCountryDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

CycleCountryDTOListResponse _$CycleCountryDTOListResponseFromJson(
    Map<String, dynamic> json) {
  return CycleCountryDTOListResponse(
    status: json['status'] as bool?,
    result: (json['result'] as List?)
        ?.map((e) => CycleCountryDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CycleCountryDTOListResponseToJson(
        CycleCountryDTOListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };
