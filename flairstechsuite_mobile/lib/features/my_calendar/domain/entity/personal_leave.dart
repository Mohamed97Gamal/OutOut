import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PersonalLeavesEntity extends Equatable {
  final String? id;
  final String? name;
  final DateTime? from;
  final DateTime? to;
  PersonalLeavesEntity({
    required this.id,
    required this.name,
    required this.from,
    required this.to,
  });

  @override
  List<Object?> get props => [id, name, from, to];
}
