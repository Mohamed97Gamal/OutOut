import '../../../cycles/data/model/holiday/holiday_dto.dart';
import '../../data/models/personal_leave_dto.dart';
import 'package:flutter/cupertino.dart';

abstract class CalendarRepository {
  final List<PersonalLeavesDTO>? personalLeavesResponse;
  final List<HolidayDTO>? holidaysResponse;
  final List<int>? weekendResponse;
  CalendarRepository(
      {required this.holidaysResponse,
      required this.personalLeavesResponse,
      required this.weekendResponse});
  List<int> addWeekends();
  List<DateTime> addHolidays();
  List<DateTime> addPersonalLeavesForSingleMonth();
  List<DateTime> addPersonalLeavesForAllTime();
}
