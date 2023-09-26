import 'package:equatable/equatable.dart';
import 'package:flairstechsuite_mobile/features/cycles/data/model/holiday/holiday_dto.dart';
import 'package:flairstechsuite_mobile/features/my_calendar/data/models/personal_leave_dto.dart';
import 'package:flutter/cupertino.dart';

class CalendarEntity extends Equatable {
  final List<int>? weekendDays;
  final List<HolidayDTO>? holidays;
  final List<PersonalLeavesDTO>? leaveRequests;
  const CalendarEntity({
    required this.weekendDays,
    required this.holidays,
    required this.leaveRequests,
  });

  @override
  List<Object?> get props => [weekendDays, holidays, leaveRequests];
}
