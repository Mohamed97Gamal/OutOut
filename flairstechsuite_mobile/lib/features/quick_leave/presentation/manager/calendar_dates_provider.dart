import '../../../cycles/data/model/holiday/holiday_dto.dart';
import '../../../my_calendar/data/models/personal_leave_dto.dart';
import '../../../my_calendar/data/repository/mycalendar_repository_impl.dart';
import 'package:flutter/foundation.dart';

class CalendarDatesProvider with ChangeNotifier {
  List<DateTime> blackoutDates = <DateTime>[];
  List<DateTime> holidayDates = <DateTime>[];
  List<int> weekendDays = <int>[];
  void viewChanged(List<PersonalLeavesDTO>? personalLeavesResponse,
      List<HolidayDTO>? holidaysResponse, List<int>? weekendResponse) {
    final myCalendarDetails = MyCalendarRepositoryImpl(
        holidaysResponse: holidaysResponse,
        personalLeavesResponse: personalLeavesResponse,
        weekendResponse: weekendResponse);

    weekendDays = myCalendarDetails.addWeekends();
    holidayDates = myCalendarDetails.addHolidays();
    blackoutDates = myCalendarDetails.addPersonalLeavesForAllTime();
    notifyListeners();
  }
}
