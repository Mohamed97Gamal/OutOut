import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class QuickLeaveEntity extends Equatable {
  final List<String?>? imagePaths;
  final String? reason;
  final DateTime? from;
  final DateTime? to;
  final int? halfDayType;
  const QuickLeaveEntity( 
      {required this.reason,
      this.imagePaths,
      this.halfDayType,
      required this.from,
      required this.to});
  @override
  List<Object?> get props => [imagePaths, reason, from, to, halfDayType];
}
