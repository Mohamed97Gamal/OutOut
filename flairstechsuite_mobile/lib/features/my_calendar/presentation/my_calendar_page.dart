import 'package:flairstechsuite_mobile/features/my_calendar/data/models/calendar_dto.dart';
import 'package:flairstechsuite_mobile/features/my_calendar/data/models/personal_leave_dto.dart';
import 'package:flairstechsuite_mobile/features/my_calendar/data/repository/mycalendar_repository_impl.dart';
import 'package:flairstechsuite_mobile/features/my_calendar/presentation/widgets/calendar_dates_types.dart';
import 'package:flairstechsuite_mobile/features/my_calendar/presentation/widgets/tooltip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../../../repo/repository.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/date_utils.dart' as date_utils;
import '../../../../utils/resources_utils.dart';
import '../../../../widgets/basic/bottom_bar.dart';
import '../../../../widgets/basic/drawer_scaffold.dart'as menu;
import '../../../../widgets/basic/refreshable.dart';
import '../../../../widgets/notification_scaffold.dart';
import '../../../../widgets/quick_leave/date_picker/date_picker_manager.dart';
import '../../../../widgets/quick_leave/my_calendar_date_picker.dart';


class MyCalendarPage extends StatefulWidget {
  const MyCalendarPage({Key? key}) : super(key: key);

  @override
  State<MyCalendarPage> createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  final _datePickerController = DateRangePickerController();

  List<DateTime> _blackoutDates = <DateTime>[];
  List<int> weekendDays = <int>[];
  List<DateTime> _holidayDates = <DateTime>[];
  final _refreshableKey = GlobalKey<RefreshableState>();
  bool _isLoading = true;
  bool firstTimeCalendarRendered = true;
  String? toolTipText = "";
  Color? toolTipColor;
  String tooltipStartDate = "";
  String tooltipEndDate = "";
  late CalendarDtoResponse request;
  @override
  Widget build(BuildContext context) {
    return menu.DrawerScaffold(
      builder: (context) {
        return NotificationScaffold(
          bottomNavigationBar: const MyBottomNavigationBar(),
          appBar: AppBar(
            centerTitle: true,
            title: Text("My Calendar".toUpperCase()),
            leading: IconButton(
              icon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(ResourcesUtils.menu),
              ),
              onPressed: () =>
                  Provider.of<menu.MenuController>(context, listen: false).toggle(),
            ),
          ),
          // padding: const EdgeInsets.all(32.0),
          body: Refreshable(
              key: _refreshableKey,
              child: RefreshIndicator(
                onRefresh: () async => _refreshableKey.currentState!.refresh(),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                             SizedBox(
                                height: 400,
                                child: MyCalendarDatePicker(
                                  controller: _datePickerController,
                                  showTodayButton: true,
                                  enablePastDates: true,
                                  specialDates: _holidayDates,
                                  weekendDays: weekendDays,
                                  specialDates2: _blackoutDates,
                                  view: DateRangePickerView.month,
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                  onSelectionChanged: (p0) async {
                                    setState(() {
                                      toolTipText = "";
                                    });
                                    final selectionValue = DateTime.tryParse(
                                            date_utils.DateUtils.dateUtcFormat
                                                .format(p0.value))!
                                        .subtract(Duration(days: 1));

                                    final response = await request.result!;
                                    showToolTip(
                                        response.leaveRequests!, selectionValue,
                                        toolTipColor: MyColors.lightGreen);
                                    showToolTip(
                                        response.holidays!, selectionValue,
                                        toolTipColor: MyColors.yellow);
                                  },
                                  onViewChanged: viewChanged,
                                )),
                            if (_isLoading)
                              Container(
                                  color: Colors.white,
                                  width: double.infinity,
                                  height: 400,
                                  child: const Center(
                                      child: CircularProgressIndicator())),
                          ],
                        ),
                        if (toolTipText!.isNotEmpty)
                        TooltipWidget(
                            toolTipColor: toolTipColor,
                            toolTipText: toolTipText,
                            tooltipStartDate: tooltipStartDate,
                            tooltipEndDate: tooltipEndDate,
                          ),
                        const SizedBox(height: 16),
                        const CalendarDateTypes()
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }


  viewChanged(DateRangePickerViewChangedArgs args) async {
    if (args.view == DateRangePickerView.month) {
      final date = args.visibleDateRange!.startDate!;
      if (!firstTimeCalendarRendered) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _isLoading = true;
          });
        });
      }
      request = await Repository().getMyCalendar(date.month, date.year);
      final response = await request.result!;

      final leaveRequestsResponse = response.leaveRequests;
      final holidaysResponse = response.holidays;
      final weekendResponse = response.weekendDays;
      final myCalendarDetails = MyCalendarRepositoryImpl(
        holidaysResponse: holidaysResponse,
        personalLeavesResponse: leaveRequestsResponse,
        weekendResponse: weekendResponse,
      );

      setState(() {
        toolTipText = "";
        weekendDays = myCalendarDetails.addWeekends();
        _holidayDates = myCalendarDetails.addHolidays();
        _blackoutDates = myCalendarDetails.addPersonalLeavesForSingleMonth();
        _isLoading = false;
      });
      firstTimeCalendarRendered = false;
    }
  }

  void showToolTip(List responseList, DateTime selectionDate, {toolTipColor}) {
    for (var responseItem in responseList) {
      final from = responseItem.from;
      final to = responseItem.to;
      if ((selectionDate.isAfter(from) || selectionDate == from) &&
          (selectionDate.isBefore(to) || selectionDate == to)) {
        if (!weekendDays.contains(selectionDate.add(Duration(hours: 2)).weekday)) {
          setState(() {
            tooltipStartDate =
                date_utils.DateUtils.dateFormatDayMonth.format(from.add(Duration(hours: 2)));
            tooltipEndDate = date_utils.DateUtils.dateFormatDayMonth.format(to.add(Duration(hours: 2)));
            toolTipText = responseItem.name;
            this.toolTipColor = toolTipColor;
          });
        }
      }
    }
  }
}
