import 'package:out_out/data/models/enums/day_of_week.dart';
import 'package:out_out/utils/date_utils.dart';
import 'package:test/test.dart';

void main() {
  group("Date Utils Tests", () {
    test('List<DayOfWeek>.explains() when all days exists should return "All Days"', () {
      _testListOfDayOfWeekExplain(DayOfWeek.availableOptions, "All Days");
    });

    test('List<DayOfWeek>.explains() when all days connected should return "first to last"', () {
      _testListOfDayOfWeekExplain(
        [
          DayOfWeek.sunday,
          DayOfWeek.monday,
          DayOfWeek.tuesday,
          DayOfWeek.wednesday,
        ],
        "Sunday to Wednesday",
      );

      _testListOfDayOfWeekExplain(
        [
          DayOfWeek.wednesday,
          DayOfWeek.thursday,
          DayOfWeek.friday,
        ],
        "Wednesday to Friday",
      );

      _testListOfDayOfWeekExplain(
        [
          DayOfWeek.saturday,
          DayOfWeek.sunday,
        ],
        "Saturday to Sunday",
      );

      _testListOfDayOfWeekExplain(
        [
          DayOfWeek.friday,
          DayOfWeek.saturday,
          DayOfWeek.sunday,
        ],
        "Friday to Sunday",
      );
    });
  });
}

_testListOfDayOfWeekExplain(List<DayOfWeek> days, String expected) {
  final actual = days.explain();
  expect(actual, expected);
}
