import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:out_out/data/models/enums/day_of_week.dart';
import 'package:out_out/data/view_models/time_span.dart';

extension DayOfWeekListUtils on List<DayOfWeek> {
  List<List<int>> _groupConsecutiveDays() {
    List<List<int>> result = new List<List<int>>.empty(growable: true);
    List<int> queue = List<int>.empty(growable: true);
    var list = this.map((d) => d.value).toList();
    list.sort();

    for (var item in list) {
      if (queue.length == 0) {
        queue.add(item);
      } else {
        if ((item - 1) == queue[queue.length - 1]) {
          queue.add(item);
        } else if (item != DayOfWeek.sunday.value) {
          result.add(queue);
          queue = [item];
        }
      }

      if (item == list.last) result.add(queue);

      //Handle Sunday
      if (item == DayOfWeek.sunday.value) {
        //Check if Saturday exists, if exists then do not put sunday before Monday.
        var findSaturday =
            result.where((r) => r.contains(DayOfWeek.saturday.value));
        if (findSaturday.isEmpty) {
          var findMonday =
              result.where((r) => r.contains(DayOfWeek.monday.value));
          if (findMonday.isNotEmpty) {
            findMonday.first.insert(0, item);
          }
        }
      }
    }
    return result;
  }

  String explain() {
    if (this.length == 7) {
      return "All Days";
    }

    if (this.length == 1) {
      return this.first.name;
    }

    final values = _groupConsecutiveDays().reversed;
    if (values.length <= 2) {
      final firstGroup = values.first;
      final lastGroup = values.last;

      if (values.length == 1) {
        return "${DayOfWeek.fromJson(firstGroup.first).name} to ${DayOfWeek.fromJson(lastGroup.last).name}";
      }

      final canBeMerged = lastGroup.first == (firstGroup.last + 1) % 7;
      if (canBeMerged)
        return "${DayOfWeek.fromJson(firstGroup.first).name} to ${DayOfWeek.fromJson(lastGroup.last).name}";
    }

    List<DayOfWeek> ordered = [...this];
    ordered.sort((d1, d2) => d1.value.compareTo(d2.value));
    String days = ordered.map((day) => day.name).join(", ");
    days = days.replaceRange(
        days.lastIndexOf(","), days.lastIndexOf(",") + 1, " &");
    return days;
  }
}

extension DateOnlyCompare on DateTime {
  bool isAfterWithinMinutes(DateTime other) {
    var diff = this.difference(other);
    return diff.inMinutes > 0;
  }

  bool isRemainingHoursMoreThan(int hours) {
    var now = DateTime.now();
    return this.difference(now).inHours > hours;
  }

  bool isToday() {
    var now = DateTime.now();
    return this.year == now.year &&
        this.month == now.month &&
        this.day == now.day;
  }

  bool isTodayWithMinutes() {
    var now = DateTime.now();
    return this.isBefore(now);
  }

  bool isTomorrow() {
    var tomorrow = DateTime.now().add(Duration(days: 1));
    return this.year == tomorrow.year &&
        this.month == tomorrow.month &&
        this.day == tomorrow.day;
  }

  bool isFuture() {
    var now = DateTime.now();
    return isAfterWithinMinutes(now);
  }

  bool isPastTime() {
    var nowTimeOfDay = TimeOfDay.now();
    var nowValue = (nowTimeOfDay.hour * 60) + nowTimeOfDay.minute;
    var thisTimeOfDay = TimeOfDay.fromDateTime(this);
    var thisValue = (thisTimeOfDay.hour * 60) + thisTimeOfDay.minute;
    return thisValue < nowValue;
  }
}

extension DayOfWeekExtension on DateTime {
  int get dayOfWeek => weekday % 7;
}

DateTime fromDateAndTime(DateTime date, DateTime time) {
  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}

DateTime fromDateAndTimeSpan(DateTime date, TimeSpan time) {
  final hours = time.hours;
  final minutes = time.minutes;
  return DateTime(
    date.year,
    date.month,
    date.day,
    hours,
    minutes,
  );
}

final DateFormat BookingDateFormat = DateFormat(
    "${DateFormat.WEEKDAY} ${DateFormat.DAY} ${DateFormat.ABBR_MONTH}");
final DateFormat BookingTimeFormat = DateFormat.jm();
final DateFormat EventDateFormat = DateFormat(
    "${DateFormat.DAY} ${DateFormat.ABBR_MONTH} ${DateFormat.WEEKDAY}");
final DateFormat EventTimeFormat = DateFormat.jm();
final DateFormat EventDetailsDateFormat = DateFormat(
    "${DateFormat.WEEKDAY}, ${DateFormat.DAY} ${DateFormat.ABBR_MONTH}, ${DateFormat.YEAR}");
final DateFormat EventDetailsTimeFormat = DateFormat.jm();
