// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_leave_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalLeavesDTO _$PersonalLeavesDTOFromJson(Map<String, dynamic> json) {
  return PersonalLeavesDTO(
    id: json['id'] as String,
    name: json['name'] as String,
    from: json['from'] == null ? null : DateTime.parse(json['from'] as String),
    to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
  );
}

Map<String, dynamic> _$PersonalLeavesDTOToJson(PersonalLeavesDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'from': instance.from?.toIso8601String(),
      'to': instance.to?.toIso8601String(),
    };

PersonalLeavesDTOResponse _$PersonalLeavesDTOResponseFromJson(
    Map<String, dynamic> json) {
  return PersonalLeavesDTOResponse(
    status: json['status'] as bool,
    result: json['result'] == null
        ? null
        : PersonalLeavesDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PersonalLeavesDTOResponseToJson(
        PersonalLeavesDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };
