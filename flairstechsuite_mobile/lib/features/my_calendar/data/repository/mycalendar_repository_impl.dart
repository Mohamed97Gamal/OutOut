import '../../../cycles/data/model/holiday/holiday_dto.dart';
import '../../domain/repository/mycalendar_repository.dart';
import '../models/personal_leave_dto.dart';

class MyCalendarRepositoryImpl extends CalendarRepository {

  bool isLoading = true;
  MyCalendarRepositoryImpl({
   final List<PersonalLeavesDTO>? personalLeavesResponse,
    final List<HolidayDTO>? holidaysResponse,
    final List<int>? weekendResponse,
  }) : super(
            holidaysResponse: holidaysResponse,
            personalLeavesResponse: personalLeavesResponse,
            weekendResponse: weekendResponse);

  final holidaysDateCollection = <DateTime>[];
  final weekendCollection = <int>[];
  final blackoutDateCollection = <DateTime>[];

  @override
  List<int> addWeekends() {
    if (weekendResponse!.isNotEmpty)
      for (var day in weekendResponse!) {
        // saturday replace 0 with 7
        if (day == 0) day = 7;
        weekendCollection.add(day);
      }
    return weekendCollection;
  }

  @override
  List<DateTime> addHolidays() {
    if (holidaysResponse!.isNotEmpty)
      for (var day in holidaysResponse!) {
        final from = day.from!.add(Duration(hours: 2));
        final to = day.to!.add(Duration(hours: 2));
        final daysDiff = to.difference(from).inDays;
        if (daysDiff == 0) {
          holidaysDateCollection.add(from);
        } else if (daysDiff == 1) {
          holidaysDateCollection.add(from);
          holidaysDateCollection.add(to);
        } else {
          for (var i = 0; i < daysDiff; i++) {
            final nextDay = from.add(Duration(days: i));
            holidaysDateCollection.add(nextDay);
          }
          holidaysDateCollection.add(to);
        }
      }
    return holidaysDateCollection;
  }

  @override
  List<DateTime> addPersonalLeavesForAllTime() {
    if (personalLeavesResponse!.isNotEmpty)
      for (var day in personalLeavesResponse!) {
        final from = day.from!.add(Duration(hours: 2));
        final to = day.to!;
        final daysDiff = to.difference(day.from!).inDays;
        if (daysDiff == 1) {
          blackoutDateCollection.add(from);
        } else {
          for (var i = 0; i < daysDiff; i++) {
            final nextDay = from.add(Duration(days: i));
            blackoutDateCollection.add(nextDay);
          }
          blackoutDateCollection.add(to);
        }
      }
    return blackoutDateCollection;
  }

  @override
  List<DateTime> addPersonalLeavesForSingleMonth() {
    if (personalLeavesResponse!.isNotEmpty)
      for (var day in personalLeavesResponse!) {
        final from = day.from!.add(Duration(hours: 2));
        final to = day.to!.add(Duration(hours: 2));
        final daysDiff = to.difference(from).inDays;
        if (daysDiff == 1) {
          blackoutDateCollection.add(from);
          blackoutDateCollection.add(to);
        } else {
          for (var i = 0; i < daysDiff; i++) {
            final nextDay = from.add(Duration(days: i));
            blackoutDateCollection.add(nextDay);
          }
          blackoutDateCollection.add(to);
        }
      }
    return blackoutDateCollection;
  }

}
