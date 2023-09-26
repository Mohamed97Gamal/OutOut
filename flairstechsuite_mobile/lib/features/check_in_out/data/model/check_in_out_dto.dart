import 'package:flairstechsuite_mobile/features/check_in_out/domain/entity/check_in_out_duration_entity.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/domain/entity/check_in_out_entity.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/domain/entity/check_in_out_history_entity.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:json_annotation/json_annotation.dart';
part 'check_in_out_dto.g.dart';

@JsonSerializable()
class CheckInOutDTO extends CheckInOutEntity {
  const CheckInOutDTO({
    final String? id,
    final double? longitude,
    final double? latitude,
    final int? checkType,
    final String? employeeId,
    final DateTime? creationDate,
    final DateTime? modificationDate,
    final int? placeType,
    final String? placeId,
    final String? placeName,
    final bool? isAutomatic,
    final bool? isForgotten,
  }) : super(
          id: id,
          longitude: longitude,
          latitude: latitude,
          checkType: checkType,
          employeeId: employeeId,
          creationDate: creationDate,
          modificationDate: modificationDate,
          placeType: placeType,
          placeId: placeId,
          placeName: placeName,
          isAutomatic: isAutomatic,
          isForgotten: isForgotten,
        );

  factory CheckInOutDTO.fromJson(Map<String, dynamic> json) =>
      _$CheckInOutDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInOutDTOToJson(this);
}

@JsonSerializable()
class CheckInOutDTOResponse extends BaseAPIResponse {
  final CheckInOutDTO? result;

  const CheckInOutDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory CheckInOutDTOResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckInOutDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CheckInOutDTOResponseToJson(this);
}

@JsonSerializable()
class CheckInOutHistoryDTO extends CheckInOutHistoryEntity {
  const CheckInOutHistoryDTO({
    final DateTime? date,
    final DateTime? startShiftDate,
    final DateTime? endShiftDate,
    final int? requiredMinutes,
    final int? totalWorkingMinutes,
    final int? missingMinutes,
    final List<CheckInOutDurationDTO>? checkInOutDurations,
  }) : super(
          date: date,
          endShiftDate: endShiftDate,
          startShiftDate: startShiftDate,
          requiredMinutes: requiredMinutes,
          totalWorkingMinutes: totalWorkingMinutes,
          missingMinutes: missingMinutes,
          checkInOutDurations: checkInOutDurations,
        );

  factory CheckInOutHistoryDTO.fromJson(Map<String, dynamic> json) =>
      _$CheckInOutHistoryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInOutHistoryDTOToJson(this);
}

@JsonSerializable()
class CheckInOutHistoryDTOResponse extends BaseAPIResponse {
  final List<CheckInOutHistoryDTO>? result;

  const CheckInOutHistoryDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory CheckInOutHistoryDTOResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckInOutHistoryDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CheckInOutHistoryDTOResponseToJson(this);
}

@JsonSerializable()
class CheckInOutDurationDTO extends CheckInOutDurationEntity {
  const CheckInOutDurationDTO({
    final DateTime? from,
    final DateTime? to,
    final int? notCalculatedMinutes,
    final int? calculatedMinutes,
    final CheckInOutDTO? checkInDTO,
    final CheckInOutDTO? checkOutDTO,
  }) : super(
          from: from,
          to: to,
          notCalculatedMinutes: notCalculatedMinutes,
          calculatedMinutes: calculatedMinutes,
          checkInDTO: checkInDTO,
          checkOutDTO: checkOutDTO,
        );

  factory CheckInOutDurationDTO.fromJson(Map<String, dynamic> json) =>
      _$CheckInOutDurationDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInOutDurationDTOToJson(this);
}
