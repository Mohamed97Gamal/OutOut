import 'package:flairstechsuite_mobile/features/my_calendar/domain/entity/personal_leave.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'personal_leave_dto.g.dart';

@JsonSerializable()
class PersonalLeavesDTO extends PersonalLeavesEntity {

  PersonalLeavesDTO({
    final String? id,
    final String? name,
    final DateTime? from,
    final DateTime? to,
  }) : super(id: id, name: name, from: from, to: to);

  factory PersonalLeavesDTO.fromJson(Map<String, dynamic> json) =>
      _$PersonalLeavesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalLeavesDTOToJson(this);
}

@JsonSerializable()
class PersonalLeavesDTOResponse extends BaseAPIResponse {
  final PersonalLeavesDTO? result;

  const PersonalLeavesDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory PersonalLeavesDTOResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonalLeavesDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PersonalLeavesDTOResponseToJson(this);
}
