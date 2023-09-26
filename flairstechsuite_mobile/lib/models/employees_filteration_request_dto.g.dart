// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employees_filteration_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeesFilterationRequestDTO _$EmployeesFilterationRequestDTOFromJson(
    Map<String, dynamic> json) {
  return EmployeesFilterationRequestDTO(
    searchQueries:
        (json['searchQueries'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$EmployeesFilterationRequestDTOToJson(
        EmployeesFilterationRequestDTO instance) =>
    <String, dynamic>{
      'searchQueries': instance.searchQueries,
    };
