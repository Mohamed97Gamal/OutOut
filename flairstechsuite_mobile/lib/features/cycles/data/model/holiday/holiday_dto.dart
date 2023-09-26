import 'package:flairstechsuite_mobile/features/cycles/domain/entity/holiday_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../models/api/responses.dart';

part 'holiday_dto.g.dart';

@JsonSerializable()
class HolidayDTO extends HolidayEntity {
 const HolidayDTO({
    String? id,
    String? name,
    DateTime? from,
    DateTime? to,
  }) : super(from: from, to: to, id: id, name: name);

  factory HolidayDTO.fromJson(Map<String, dynamic> json) =>
      _$HolidayDTOFromJson(json);

  Map<String, dynamic> toJson() => _$HolidayDTOToJson(this);
}

@JsonSerializable()
class HolidayDTOResponse extends BaseAPIResponse {
  final HolidayDTO? result;

  const HolidayDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory HolidayDTOResponse.fromJson(Map<String, dynamic> json) =>
      _$HolidayDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HolidayDTOResponseToJson(this);
}

@JsonSerializable()
class HolidayDTOListResponse extends BaseAPIResponse {
  final List<HolidayDTO>? result;

  const HolidayDTOListResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory HolidayDTOListResponse.fromJson(Map<String, dynamic> json) =>
      _$HolidayDTOListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HolidayDTOListResponseToJson(this);
}
