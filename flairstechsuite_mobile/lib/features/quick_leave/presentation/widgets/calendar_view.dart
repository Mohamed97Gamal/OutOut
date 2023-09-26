import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../enums/quick_leaves.dart';
import '../../../../screens/common/fields/custom_date_range_form_field.dart';
import '../../../../widgets/quick_leave/date_picker/date_picker_manager.dart';
import '../../../../widgets/quick_leave/my_calendar_date_picker.dart';
import '../../../my_calendar/presentation/widgets/calendar_dates_types.dart';
import '../manager/balance_provider.dart';
import '../manager/calendar_dates_provider.dart';
import '../manager/quick_leave_provider.dart';

class CalendarView extends StatelessWidget {
  final TextEditingController? controller;

  const CalendarView({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final quickLeaveProvider = Provider.of<QuickLeaveProvider>(context);
    final calendarDatesProvider = Provider.of<CalendarDatesProvider>(context);
    final balanceProvider = Provider.of<BalanceProvider>(context);

    if (balanceProvider.isCalendarLoaded)
      return Column(
        children: [
          if (quickLeaveProvider.isShowSelectedDate)
            GestureDetector(
              onTap: () {
                Provider.of<QuickLeaveProvider>(context, listen: false).showCalendar();
              },
              child: CustomDateRangeFormField(
                name: "date",
                labelText: "",
                hintText: "Date",
                iconColor: Colors.black45,
                enabled: false,
                controller: controller,
                initialValue: DateTimeRange(start: now, end: now),
              ),
            )
          else
            Column(
              children: [
                MyCalendarDatePicker(
                        selectionMode: quickLeaveProvider.selectedQuickLeave == QuickLeave.HalfDayLeave ||
                                quickLeaveProvider.selectedQuickLeave == QuickLeave.EmergencyLeave
                            ? DateRangePickerSelectionMode.single
                            : DateRangePickerSelectionMode.range,
                        specialDates: calendarDatesProvider.holidayDates,
                        blackoutDates: calendarDatesProvider.blackoutDates,
                        weekendDays: calendarDatesProvider.weekendDays,
                        controller: quickLeaveProvider.datePickerController,
                        enablePastDates: quickLeaveProvider.selectedQuickLeave == QuickLeave.HalfDayLeave ? false : true,
                        view: DateRangePickerView.month,
                        minDate: Provider.of<BalanceProvider>(context, listen: false).employeeBalanceDTO!.cycle!.from!.toLocal(),
                        maxDate: quickLeaveProvider.selectedQuickLeave == QuickLeave.EmergencyLeave
                            ? DateTime.now()
                            : Provider.of<BalanceProvider>(context, listen: false).employeeBalanceDTO!.cycle!.to!.toLocal(),
                        selectableDayPredicate: (dateTime) {
                          for (var day in calendarDatesProvider.weekendDays) {
                            if ((dateTime.weekday) == day) {
                              return false;
                            }
                          }
                          for (var day in calendarDatesProvider.holidayDates) {
                            if (dateTime == day) {
                              return false;
                            }
                          }
                          return true;
                        },
                        onSelectionChanged: (args) {
                          quickLeaveProvider.onDateSelect(args.value);
                          controller!.text = quickLeaveProvider.textFieldTextValue;
                        },
                      ),
                const SizedBox(height: 16),
                const CalendarDateTypes()
              ],
            ),
        ],
      );
    else
      return Center(
        child: CircularProgressIndicator(),
      );
  }
}
