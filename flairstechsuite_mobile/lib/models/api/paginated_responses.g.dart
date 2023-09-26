// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePaginatedResponseWrapper _$BasePaginatedResponseWrapperFromJson(
    Map<String, dynamic> json) {
  return BasePaginatedResponseWrapper(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : PaginatedLocationRequestDTOList.fromJson(
            json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$BasePaginatedResponseWrapperToJson(
        BasePaginatedResponseWrapper instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

BasePaginatedResponse _$BasePaginatedResponseFromJson(
    Map<String, dynamic> json) {
  return BasePaginatedResponse(
    pageNumber: json['pageNumber'] as int?,
    pageSize: json['pageSize'] as int?,
    pagesTotalCount: json['pagesTotalCount'] as int?,
    recordsTotalCount: json['recordsTotalCount'] as int?,
    hasNext: json['hasNext'] as bool?,
    hasPrevious: json['hasPrevious'] as bool?,
  );
}

Map<String, dynamic> _$BasePaginatedResponseToJson(
        BasePaginatedResponse instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'pagesTotalCount': instance.pagesTotalCount,
      'recordsTotalCount': instance.recordsTotalCount,
      'hasNext': instance.hasNext,
      'hasPrevious': instance.hasPrevious,
    };

LeaveRequestDTOPageDTO _$LeaveRequestDTOPageDTOFromJson(
    Map<String, dynamic> json) {
  return LeaveRequestDTOPageDTO(
    pagesTotalCount: json['pagesTotalCount'] as int?,
    pageNumber: json['pageNumber'] as int?,
    pageSize: json['pageSize'] as int?,
    hasNext: json['hasNext'] as bool?,
    hasPrevious: json['hasPrevious'] as bool?,
    recordsTotalCount: json['recordsTotalCount'] as int?,
    records: (json['records'] as List?)
        ?.map((e) => LeaveRequestDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LeaveRequestDTOPageDTOToJson(
        LeaveRequestDTOPageDTO instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'pagesTotalCount': instance.pagesTotalCount,
      'recordsTotalCount': instance.recordsTotalCount,
      'hasNext': instance.hasNext,
      'hasPrevious': instance.hasPrevious,
      'records': instance.records,
    };

EmployeeMinimizedDTOPageDTO _$EmployeeMinimizedDTOPageDTOFromJson(
    Map<String, dynamic> json) {
  return EmployeeMinimizedDTOPageDTO(
    pagesTotalCount: json['pagesTotalCount'] as int?,
    pageNumber: json['pageNumber'] as int?,
    pageSize: json['pageSize'] as int?,
    hasNext: json['hasNext'] as bool?,
    hasPrevious: json['hasPrevious'] as bool?,
    recordsTotalCount: json['recordsTotalCount'] as int?,
    records: (json['records'] as List?)
        ?.map((e) =>  EmployeeProfileDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EmployeeMinimizedDTOPageDTOToJson(
        EmployeeMinimizedDTOPageDTO instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'pagesTotalCount': instance.pagesTotalCount,
      'recordsTotalCount': instance.recordsTotalCount,
      'hasNext': instance.hasNext,
      'hasPrevious': instance.hasPrevious,
      'records': instance.records,
    };

PaginatedLocationDTOList _$PaginatedLocationDTOListFromJson(
    Map<String, dynamic> json) {
  return PaginatedLocationDTOList(
    pagesTotalCount: json['pagesTotalCount'] as int?,
    pageNumber: json['pageNumber'] as int?,
    pageSize: json['pageSize'] as int?,
    recordsTotalCount: json['recordsTotalCount'] as int?,
    records: (json['records'] as List?)
        ?.map((e) => LocationDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PaginatedLocationDTOListToJson(
        PaginatedLocationDTOList instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'pagesTotalCount': instance.pagesTotalCount,
      'recordsTotalCount': instance.recordsTotalCount,
      'records': instance.records,
    };

PaginatedLocationRequestDTOList _$PaginatedLocationRequestDTOListFromJson(
    Map<String, dynamic> json) {
  return PaginatedLocationRequestDTOList(
    pagesTotalCount: json['pagesTotalCount'] as int?,
    pageNumber: json['pageNumber'] as int?,
    pageSize: json['pageSize'] as int?,
    recordsTotalCount: json['recordsTotalCount'] as int?,
    records: (json['records'] as List?)
        ?.map((e) => LocationRequestDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PaginatedLocationRequestDTOListToJson(
        PaginatedLocationRequestDTOList instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'pagesTotalCount': instance.pagesTotalCount,
      'recordsTotalCount': instance.recordsTotalCount,
      'records': instance.records,
    };

PaginatedAnnouncementDTOList _$PaginatedAnnouncementDTOListFromJson(
    Map<String, dynamic> json) {
  return PaginatedAnnouncementDTOList(
    pagesTotalCount: json['pagesTotalCount'] as int?,
    pageNumber: json['pageNumber'] as int?,
    pageSize: json['pageSize'] as int?,
    recordsTotalCount: json['recordsTotalCount'] as int?,
    records: (json['records'] as List?)
        ?.map((e) => AnnouncementDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PaginatedAnnouncementDTOListToJson(
        PaginatedAnnouncementDTOList instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'pagesTotalCount': instance.pagesTotalCount,
      'recordsTotalCount': instance.recordsTotalCount,
      'records': instance.records,
    };
