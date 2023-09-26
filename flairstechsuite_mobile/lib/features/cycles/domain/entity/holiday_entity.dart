import 'package:equatable/equatable.dart';

class HolidayEntity extends Equatable {
  final String? id;
  final String? name;
  final DateTime? from;
  final DateTime? to;
 const HolidayEntity({
    this.id,
    this.name,
    this.from,
    this.to,
  });

  @override
  List<Object?> get props => [id, name, from, to];
}
