import 'package:flairstechsuite_mobile/app/constants.dart';
import 'package:flairstechsuite_mobile/features/quick_leave/presentation/manager/balance_provider.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../enums/quick_leaves.dart';
import '../../../../models/api/responses.dart';
import '../../../../repo/repository.dart';
import '../../../../utils/date_utils.dart' as date_utils;
import '../../../../utils/navigation.dart';
import '../../../../utils/notifier_utils.dart';
import '../../../../widgets/basic/adaptive_alert_dialog.dart';
import '../../../../widgets/basic/confirmation_dialog.dart';
import '../../../../widgets/basic/future_dialog.dart';
import '../../../../widgets/quick_leave/date_picker/date_picker_manager.dart';
import '../../domain/entity/quick_leave_entity.dart';

class QuickLeaveProvider with ChangeNotifier {
  QuickLeave selectedQuickLeave = QuickLeave.AnnualLeave;

  final halfDayTiming = [AppStrings.firstHalfOfDAY, AppStrings.secondHalfOfDAY];
  int _halfDayTimingValue = 0;
  String? _halfDayTimingStringValue = AppStrings.firstHalfOfDAY;

  final selectedDaysRefreshableKey = GlobalKey<RefreshableState>();

  bool isShowCalendar = false;
  bool isShowSelectedDate = false;
  bool isDateSelected = false;

  final datePickerController = DateRangePickerController();

  final now = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  String textFieldTextValue = "";
  final _dateFormat = date_utils.DateUtils.dateFormat;
  final _dateFormat2 = date_utils.DateUtils.dateUtcFormat;

  onQuickLeaveSelect(BuildContext context, {required QuickLeave value}) {
    selectedQuickLeave = value;

    datePickerController.selectedRange = null;
    datePickerController.selectedDate = null;

    startDate = now;
    endDate = now;

    isShowSelectedDate = false;
    isDateSelected = false;
    selectedDaysRefreshableKey.currentState!.refresh();
    Provider.of<BalanceProvider>(context, listen: false).setBalances(value);
    notifyListeners();
  }

  onDateSelect(dynamic selectedDate) {
    if (selectedQuickLeave == QuickLeave.HalfDayLeave ||
        selectedQuickLeave == QuickLeave.EmergencyLeave) {
      _onDateSelectionHalfDay(selectedDate);
    } else {
      _onDateRangeSelection(selectedDate);
    }
    _showSelectedDate();
    isDateSelected = true;
    selectedDaysRefreshableKey.currentState!.refresh();
    notifyListeners();
  }

  _onDateSelectionHalfDay(DateTime? selectedDate) {
    if (selectedDate != null) {
      startDate = selectedDate;
      endDate = selectedDate.add(Duration(days: 1));
      datePickerController.selectedDate = startDate;
      textFieldTextValue = _setTextFieldTextValue(startDate, startDate);
      isDateSelected = true;
    }
  }

  _onDateRangeSelection(PickerDateRange? selectedDate) {
    if (selectedDate != null &&
        selectedDate.endDate != null &&
        selectedDate.startDate != null) {
      startDate = selectedDate.startDate!;
      endDate = selectedDate.endDate!.add(Duration(days: 1));

      textFieldTextValue =
          _setTextFieldTextValue(startDate, selectedDate.endDate!);
      isDateSelected = true;
    }
  }

  void showCalendar() {
    isShowSelectedDate = false;
    notifyListeners();
  }

  bool _showSelectedDate() {
    if ((selectedQuickLeave == QuickLeave.HalfDayLeave &&
            datePickerController.selectedDate != null) ||
        (selectedQuickLeave == QuickLeave.EmergencyLeave &&
            datePickerController.selectedDate != null) ||
        (!isShowCalendar &&
            datePickerController.selectedRange != null &&
            datePickerController.selectedRange!.startDate != null &&
            datePickerController.selectedRange!.endDate != null))
      return isShowSelectedDate = true;
    else
      return isShowSelectedDate = false;
  }

  checkSelectedDate(BuildContext context) async {
    if (isDateSelected != true) {
      await showConfirmationDialog(
          context: context,
          actionText: "Date Field is Required.",
          icon: FontAwesomeIcons.download,
          showFalseAction: false,
          showTitle: false,
          title: "",
          trueTitle: "OK");
      return;
    }
  }

  createQuickLeaveRequest(BuildContext context, String? reason,
      bool? isNavFromDrawer, totalSize, List uploadedFiles) async {
    var response;

    if (isDateSelected == true) {
      if (selectedQuickLeave == QuickLeave.SickLeave) {
        if (totalSize >= 3) {
          showAdaptiveAlertDialog(
              context: context, content: Text("Maximum Files size is 3 MB"));
          return;
        }
        if (uploadedFiles.isEmpty) {
          showAdaptiveAlertDialog(
              context: context, content: Text("Uploaded Files is Required"));
          return;
        }
        response = await showFutureProgressDialog<BoolResponse>(
          context: context,
          initFuture: () => Repository().createNewSickLeaveRequest(
            QuickLeaveEntity(
                from: DateTime.parse(
                    "${DateFormat('yyyy-MM-dd').format(startDate.subtract(Duration(days: 1)))}T22:00:00.000Z"),
                to: DateTime.parse(
                    "${DateFormat('yyyy-MM-dd').format(endDate.subtract(Duration(days: 1)))}T22:00:00.000Z"),
                imagePaths: uploadedFiles as List<String?>?,
                reason: reason),
          ),
        );
      } else {
        response = await showFutureProgressDialog<BoolResponse>(
          context: context,
          initFuture: () => selectedQuickLeave == QuickLeave.AnnualLeave
              ? Repository().createAnnualLeaveRequest(
                  QuickLeaveEntity(
                      from: DateTime.parse(
                          "${DateFormat('yyyy-MM-dd').format(startDate.subtract(Duration(days: 1)))}T22:00:00.000Z"),
                      to: DateTime.parse(
                          "${DateFormat('yyyy-MM-dd').format(endDate.subtract(Duration(days: 1)))}T22:00:00.000Z"),
                      reason: reason),
                )
              : selectedQuickLeave == QuickLeave.HalfDayLeave
                  ? Repository().createHalfDayLeaveRequest(
                      QuickLeaveEntity(
                          from: DateTime.parse(
                              "${DateFormat('yyyy-MM-dd').format(startDate.subtract(Duration(days: 1)))}T22:00:00.000Z"),
                          to: DateTime.parse(
                              "${DateFormat('yyyy-MM-dd').format(endDate.subtract(Duration(days: 1)))}T22:00:00.000Z"),
                          reason: reason,
                          halfDayType: _halfDayTimingValue),
                    )
                  : Repository().createNewEmergencyLeaveRequest(
                      QuickLeaveEntity(
                          from: DateTime.parse(
                              "${DateFormat('yyyy-MM-dd').format(startDate.subtract(Duration(days: 1)))}T22:00:00.000Z"),
                          to: DateTime.parse(
                              "${DateFormat('yyyy-MM-dd').format(endDate.subtract(Duration(days: 1)))}T22:00:00.000Z"),
                          reason: reason),
                    ),
        );
      }
      if (response?.status ?? false) {
        await showAdaptiveAlertDialog(
            context: context,
            content: Text(
                "${selectedQuickLeave.name} Request created successfully"));
        if (isNavFromDrawer ?? true)
          Navigation.navToHome(context);
        else
          Navigator.of(context).pop(true);
      } else {
        await showErrorDialog(context, response);
      }
    }
  }

  setHalfTime(int intValue, String? stringValue) {
    _halfDayTimingStringValue = stringValue;

    _halfDayTimingValue = intValue;
    isDateSelected = true;
    notifyListeners();
  }

  get halfDayTimingValue => _halfDayTimingValue;

  get halfDayTimingStringValue => _halfDayTimingStringValue;

  String _setTextFieldTextValue(DateTime from, DateTime to) {
    if (selectedQuickLeave == QuickLeave.EmergencyLeave ||
        selectedQuickLeave == QuickLeave.HalfDayLeave) {
      to.subtract(Duration(days: 1));
    }
    
    isDateSelected = true;
    return "${_dateFormat.format(DateTime.parse(_dateFormat2.format(from)))} - ${_dateFormat.format(DateTime.parse(_dateFormat2.format(to)))}";
  }
}
