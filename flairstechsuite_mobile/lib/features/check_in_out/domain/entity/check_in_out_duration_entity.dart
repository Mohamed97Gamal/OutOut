import 'package:equatable/equatable.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/data/model/check_in_out_dto.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/domain/entity/check_in_out_entity.dart';

class CheckInOutDurationEntity extends Equatable {
  final DateTime? from;
  final DateTime? to;
  final int? notCalculatedMinutes;
  final int? calculatedMinutes;
  final CheckInOutDTO? checkInDTO;
  final CheckInOutDTO? checkOutDTO;
  const CheckInOutDurationEntity({
    this.from,
    this.to,
    this.notCalculatedMinutes,
    this.calculatedMinutes,
    this.checkInDTO,
    this.checkOutDTO,
  });

  @override
  List<Object?> get props => [
        from,
        to,
        notCalculatedMinutes,
        calculatedMinutes,
        checkInDTO,
        checkOutDTO,
      ];
}
