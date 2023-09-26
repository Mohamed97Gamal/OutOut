// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllLocationFilterRequest _$AllLocationFilterRequestFromJson(
    Map<String, dynamic> json) {
  return AllLocationFilterRequest(
    statuses: (json['statuses'] as List)
        ?.map((e) => _$enumDecodeNullable(_$LocationStatusEnumMap, e))
        ?.toSet(),
    employeeIds:
        (json['employeeIds'] as List)?.map((e) => e as String)?.toSet(),
    searchQueries:
        (json['searchQueries'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AllLocationFilterRequestToJson(
        AllLocationFilterRequest instance) =>
    <String, dynamic>{
      'searchQueries': instance.searchQueries,
      'employeeIds': instance.employeeIds?.toList(),
      'statuses':
          instance.statuses?.map((e) => _$LocationStatusEnumMap[e])?.toList(),
    };

T? _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T? _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$LocationStatusEnumMap = {
  LocationStatus.pending: 0,
  LocationStatus.approved: 1,
  LocationStatus.rejected: 2,
};
