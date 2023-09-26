import 'package:equatable/equatable.dart';
import '../../data/model/holiday/holiday_dto.dart';

class CycleEntity extends Equatable {
  final String? id;
  final String? name;
  final DateTime? from;
  final DateTime? to;
  final bool? isCurrent;
  final int? country;
  final List<HolidayDTO>? holidays;
  const CycleEntity({
    this.id,
    this.name,
    this.holidays,
    this.from,
    this.to,
    this.isCurrent,
    this.country,
  });

  @override
  List<Object?> get props => [id, name, from, to, isCurrent, country, holidays];
}
