// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_out_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInOutDTO _$CheckInOutDTOFromJson(Map<String, dynamic> json) {
  return CheckInOutDTO(
    id: json['id'] as String,
    longitude: (json['longitude'] as num)?.toDouble(),
    latitude: (json['latitude'] as num)?.toDouble(),
    checkType: json['checkType'] as int,
    employeeId: json['employeeId'] as String,
    creationDate: json['creationDate'] == null
        ? null
        : DateTime.parse(json['creationDate'] as String),
    modificationDate: json['modificationDate'] == null
        ? null
        : DateTime.parse(json['modificationDate'] as String),
    placeType: json['placeType'] as int,
    placeId: json['placeId'] as String,
    placeName: json['placeName'] as String,
    isAutomatic: json['isAutomatic'] as bool?,
    isForgotten: json['isForgotten'] as bool?,
  );
}

Map<String, dynamic> _$CheckInOutDTOToJson(CheckInOutDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'checkType': instance.checkType,
      'employeeId': instance.employeeId,
      'creationDate': instance.creationDate?.toIso8601String(),
      'modificationDate': instance.modificationDate?.toIso8601String(),
      'placeType': instance.placeType,
      'placeId': instance.placeId,
      'placeName': instance.placeName,
      'isAutomatic': instance.isAutomatic,
      'isForgotten': instance.isForgotten,
    };

CheckInOutDTOResponse _$CheckInOutDTOResponseFromJson(
    Map<String, dynamic> json) {
  return CheckInOutDTOResponse(
    status: json['status'] as bool,
    result: json['result'] == null
        ? null
        : CheckInOutDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CheckInOutDTOResponseToJson(
        CheckInOutDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

CheckInOutHistoryDTO _$CheckInOutHistoryDTOFromJson(Map<String, dynamic> json) {
  return CheckInOutHistoryDTO(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    startShiftDate: json['startShiftDate'] == null
        ? null
        : DateTime.parse(json['startShiftDate'] as String),
    endShiftDate: json['endShiftDate'] == null
        ? null
        : DateTime.parse(json['endShiftDate'] as String),
    requiredMinutes: json['requiredMinutes'] as int,
    totalWorkingMinutes: json['totalWorkingMinutes'] as int,
    missingMinutes: json['missingMinutes'] as int,
    checkInOutDurations: (json['checkInOutDurations'] as List?)
        ?.map((e) => CheckInOutDurationDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CheckInOutHistoryDTOToJson(
        CheckInOutHistoryDTO instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'requiredMinutes': instance.requiredMinutes,
      'totalWorkingMinutes': instance.totalWorkingMinutes,
      'missingMinutes': instance.missingMinutes,
      'checkInOutDurations': instance.checkInOutDurations,
      'startShiftDate': instance.startShiftDate?.toIso8601String(),
      'endShiftDate': instance.endShiftDate?.toIso8601String(),
    };

CheckInOutHistoryDTOResponse _$CheckInOutHistoryDTOResponseFromJson(
    Map<String, dynamic> json) {
  return CheckInOutHistoryDTOResponse(
    status: json['status'] as bool?,
    result: (json['result'] as List?)
        ?.map((e) =>  CheckInOutHistoryDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CheckInOutHistoryDTOResponseToJson(
        CheckInOutHistoryDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

CheckInOutDurationDTO _$CheckInOutDurationDTOFromJson(
    Map<String, dynamic> json) {
  return CheckInOutDurationDTO(
    from: json['from'] == null ? null : DateTime.parse(json['from'] as String),
    to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
    notCalculatedMinutes: json['notCalculatedMinutes'] as int,
    calculatedMinutes: json['calculatedMinutes'] as int,
    checkInDTO: json['checkInDTO'] == null
        ? null
        : CheckInOutDTO.fromJson(json['checkInDTO'] as Map<String, dynamic>),
    checkOutDTO: json['checkOutDTO'] == null
        ? null
        : CheckInOutDTO.fromJson(json['checkOutDTO'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CheckInOutDurationDTOToJson(
        CheckInOutDurationDTO instance) =>
    <String, dynamic>{
      'from': instance.from?.toIso8601String(),
      'to': instance.to?.toIso8601String(),
      'notCalculatedMinutes': instance.notCalculatedMinutes,
      'calculatedMinutes': instance.calculatedMinutes,
      'checkInDTO': instance.checkInDTO,
      'checkOutDTO': instance.checkOutDTO,
    };
