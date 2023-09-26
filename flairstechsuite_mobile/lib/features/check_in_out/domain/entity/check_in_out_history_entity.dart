import 'package:equatable/equatable.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/data/model/check_in_out_dto.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/domain/entity/check_in_out_duration_entity.dart';

class CheckInOutHistoryEntity extends Equatable {
  final DateTime? date;
  final int? requiredMinutes;
  final int? totalWorkingMinutes;
  final int? missingMinutes;
  final List<CheckInOutDurationDTO>? checkInOutDurations;
    final DateTime? startShiftDate;
  final DateTime? endShiftDate;
  const CheckInOutHistoryEntity({
    this.startShiftDate,
    this.endShiftDate,
    this.date,
    this.requiredMinutes,
    this.totalWorkingMinutes,
    this.missingMinutes,
    this.checkInOutDurations,
  });

  @override
  List<Object?> get props => [
        date,
        requiredMinutes,
        totalWorkingMinutes,
        missingMinutes,
        checkInOutDurations,
      ];
}
