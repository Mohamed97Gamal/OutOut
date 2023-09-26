import 'package:json_annotation/json_annotation.dart';

import '../../../../models/api/responses.dart';
import 'holiday/holiday_dto.dart';

part 'cycle_holiday_dto.g.dart';

@JsonSerializable()
class CycleHoliday {
  CycleHoliday({
    this.cycleId,
    this.holidays,
  });

  String? cycleId;
  List<HolidayDTO>? holidays;

  factory CycleHoliday.fromJson(Map<String, dynamic> json) =>
      _$CycleHolidayFromJson(json);

  Map<String, dynamic> toJson() => _$CycleHolidayToJson(this);
}

@JsonSerializable()
class CycleHolidayResponse extends BaseAPIResponse {
  final bool? result;

  const CycleHolidayResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory CycleHolidayResponse.fromJson(Map<String, dynamic> json) =>
      _$CycleHolidayResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CycleHolidayResponseToJson(this);
}
