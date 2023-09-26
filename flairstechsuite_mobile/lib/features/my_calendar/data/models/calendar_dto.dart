import 'package:json_annotation/json_annotation.dart';

import '../../../../models/api/responses.dart';
import '../../../cycles/data/model/holiday/holiday_dto.dart';
import '../../domain/entity/calendar_entity.dart';
import 'personal_leave_dto.dart';

part 'calendar_dto.g.dart';

@JsonSerializable()
class CalendarDto extends CalendarEntity {
  const CalendarDto({
    final List<int>? weekendDays,
    final List<HolidayDTO>? holidays,
    final List<PersonalLeavesDTO>? leaveRequests,
  }) : super(
          weekendDays: weekendDays,
          holidays: holidays,
          leaveRequests: leaveRequests,
        );

  factory CalendarDto.fromJson(Map<String, dynamic> json) =>
      _$CalendarDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarDtoToJson(this);
}

@JsonSerializable()
class CalendarDtoResponse extends BaseAPIResponse {
  final CalendarDto? result;

  const CalendarDtoResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory CalendarDtoResponse.fromJson(Map<String, dynamic> json) =>
      _$CalendarDtoResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CalendarDtoResponseToJson(this);
}
