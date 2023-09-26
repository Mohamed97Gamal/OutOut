import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flairstechsuite_mobile/widgets/quick_leave/date_picker/date_picker.dart';
import 'package:flairstechsuite_mobile/widgets/quick_leave/date_picker/date_picker_manager.dart';
import 'package:flutter/material.dart';

class MyCalendarDatePicker extends StatelessWidget {
  final bool Function(DateTime)? selectableDayPredicate;
  final DateRangePickerController? controller;
  final bool? enablePastDates;
  final DateTime? minDate;
  final DateTime? maxDate;
  final List<DateTime>? specialDates;
  final List<DateTime>? blackoutDates;
  final List<int>? weekendDays;
  final List<DateTime>? specialDates2;
  final void Function(DateRangePickerViewChangedArgs)? onViewChanged;
  final void Function(DateRangePickerSelectionChangedArgs)? onSelectionChanged;
  final bool showTodayButton;
  final DateRangePickerSelectionMode selectionMode;
  final bool toggleDaySelection;
  final DateRangePickerView view;
  const MyCalendarDatePicker(
      {Key? key,
      this.selectableDayPredicate,
      this.controller,
      this.enablePastDates,
      this.minDate,
      this.specialDates,
      this.blackoutDates,
      this.weekendDays,
      this.onViewChanged,
      this.onSelectionChanged,
      this.showTodayButton = false,
      this.selectionMode = DateRangePickerSelectionMode.range,
      this.toggleDaySelection = true,
      this.specialDates2,
      this.view = DateRangePickerView.year, this.maxDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfDateRangePicker(
            showTodayButton: showTodayButton,
            showNavigationArrow: true,
            onSelectionChanged: onSelectionChanged,
            controller: controller,
            view: view,
            toggleDaySelection: toggleDaySelection,
            onViewChanged: onViewChanged,
            selectableDayPredicate: selectableDayPredicate,
            extendableRangeSelectionDirection:
                ExtendableRangeSelectionDirection.forward,
            // viewSpacing: 50,
            selectionTextStyle: const TextStyle(fontSize: 18),
            selectionRadius: 40,
            enablePastDates: enablePastDates,
            minDate: minDate,
            maxDate: maxDate,
            selectionShape: DateRangePickerSelectionShape.circle,
            monthCellStyle: DateRangePickerMonthCellStyle(
              weekendTextStyle: const TextStyle(
                color: MyColors.grayColor,
              ),
           
              disabledDatesTextStyle: const TextStyle(
                color: MyColors.grayColor,
              ),
              textStyle: const TextStyle(fontSize: 15, color: Colors.black),
              weekendDatesDecoration: BoxDecoration(
                color: MyColors.lightRedColor.withAlpha(100),
                borderRadius: const BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              specialDatesDecoration: const BoxDecoration(
                color: MyColors.yellow,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              specialDatesTextStyle: const TextStyle(color: MyColors.grayColor),
              todayCellDecoration: const BoxDecoration(
                color: MyColors.lightGrey,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              blackoutDatesDecoration: const BoxDecoration(
                color: MyColors.lightGreen,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              specialDates2Decoration: const BoxDecoration(
                color: MyColors.lightGreen,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
            ),
            monthViewSettings: DateRangePickerMonthViewSettings(
              specialDates: specialDates,
              blackoutDates: blackoutDates,
              weekendDays: weekendDays,
              specialDates2: specialDates2,
              enableSwipeSelection: false,
            ),
            selectionMode: selectionMode,
          ),
        ));
  }
}
