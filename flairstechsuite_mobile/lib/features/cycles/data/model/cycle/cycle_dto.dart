import 'package:flairstechsuite_mobile/features/cycles/domain/entity/cycle_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../models/api/responses.dart';
import '../holiday/holiday_dto.dart';

part 'cycle_dto.g.dart';

@JsonSerializable()
class CycleDTO extends CycleEntity {
  
 const CycleDTO({
    final String? id,
    final String? name,
    final DateTime? from,
    final DateTime? to,
    final bool? isCurrent,
    final int? country,
    final List<HolidayDTO>? holidays,
  }) : super(
          id: id,
          name: name,
          from: from,
          to: to,
          isCurrent: isCurrent,
          country: country,
          holidays: holidays,
        );

  factory CycleDTO.fromJson(Map<String, dynamic> json) =>
      _$CycleDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CycleDTOToJson(this);
}

@JsonSerializable()
class CycleDTOResponse extends BaseAPIResponse {
  final CycleDTO? result;

  const CycleDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory CycleDTOResponse.fromJson(Map<String, dynamic> json) =>
      _$CycleDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CycleDTOResponseToJson(this);
}

@JsonSerializable()
class CycleDTOListResponse extends BaseAPIResponse {
  final List<CycleDTO>? result;

  const CycleDTOListResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory CycleDTOListResponse.fromJson(Map<String, dynamic> json) =>
      _$CycleDTOListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CycleDTOListResponseToJson(this);
}

@JsonSerializable()
class CycleCountryDTO {
  final String? name;
  final int? value;

  CycleCountryDTO({
    this.name,
    this.value,
  });

  factory CycleCountryDTO.fromJson(Map<String, dynamic> json) =>
      _$CycleCountryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CycleCountryDTOToJson(this);
}

@JsonSerializable()
class CycleCountryDTOResponse extends BaseAPIResponse {
  final CycleCountryDTO? result;

  const CycleCountryDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory CycleCountryDTOResponse.fromJson(Map<String, dynamic> json) =>
      _$CycleCountryDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CycleCountryDTOResponseToJson(this);
}

@JsonSerializable()
class CycleCountryDTOListResponse extends BaseAPIResponse {
  final List<CycleCountryDTO>? result;

  const CycleCountryDTOListResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory CycleCountryDTOListResponse.fromJson(Map<String, dynamic> json) =>
      _$CycleCountryDTOListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CycleCountryDTOListResponseToJson(this);
}
