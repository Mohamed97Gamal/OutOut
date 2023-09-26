import 'dart:typed_data';

import 'package:flairstechsuite_mobile/features/quick_leave/domain/entity/quick_leave_entity.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quick_leave_dto.g.dart';

@JsonSerializable()
class QuickLeaveDTO extends QuickLeaveEntity {
  QuickLeaveDTO({
    final List<String>? imagePaths,
    final String? reason,
    final DateTime? from,
    final DateTime? to,
    final int? halfDayType,
  }) : super(
          imagePaths: imagePaths,
          reason: reason,
          from: from,
          to: to,
          halfDayType: halfDayType,
        );

  factory QuickLeaveDTO.fromJson(Map<String, dynamic> json) =>
      _$QuickLeaveDTOFromJson(json);

  Map<String, dynamic> toJson() => _$QuickLeaveDTOToJson(this);
}

@JsonSerializable()
class QuickLeaveDTOResponse extends BaseAPIResponse {
  final QuickLeaveDTO? result;

  const QuickLeaveDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory QuickLeaveDTOResponse.fromJson(Map<String, dynamic> json) =>
      _$QuickLeaveDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuickLeaveDTOResponseToJson(this);
}
