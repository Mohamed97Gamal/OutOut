import 'package:flairstechsuite_mobile/enums/day_of_week.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/confirmation_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CreateShiftScreen extends StatefulWidget {
  @override
  _CreateShiftScreenState createState() => _CreateShiftScreenState();
}

class _CreateShiftScreenState extends State<CreateShiftScreen> {
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _shiftNameController = TextEditingController();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _workingHoursController = TextEditingController();

  TimeOfDay _selectedFromTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _selectedToTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _selectedWorkingHours = TimeOfDay(hour: 0, minute: 0);

  bool? _setAsDefaultValue = false;
  bool _didPressSave = false;
  final workingHoursError =
      "Working Hours should be less than or equal to total shift time";
  final _weekDays = {
    DayOfWeek.sunday,
    DayOfWeek.monday,
    DayOfWeek.tuesday,
    DayOfWeek.wednesday,
    DayOfWeek.thursday
  };

  @override
  Widget build(BuildContext context) {
    return NotificationScaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Shift".toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: formKey,
            autovalidateMode: _didPressSave
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _shiftNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Shift Name",labelStyle: TextStyle(
                    color: Colors.grey,
                  ),hintStyle: TextStyle(color: Colors.grey)),
                  validator: (shiftName) {
                    if ((shiftName ?? "").trim().isEmpty)
                      return "Shift Name is required";
                    if ((shiftName ?? "").trim().length > 50)
                      return "Maximum length is 50 characters";
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _fromController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "From",
                          labelStyle: TextStyle(
                              color: Colors.grey
                          ),
                          suffixIcon: Icon(
                            Icons.watch_later,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onTap: () async => _selectedFromTime =
                            await _pickTime(_fromController, _selectedFromTime),
                        validator: (fromTime) {
                          if ((fromTime ?? "").trim().isEmpty)
                            return "\"From\" time is required";
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 28),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _toController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "To",
                          labelStyle: TextStyle(
                              color: Colors.grey
                          ),
                          suffixIcon: Icon(
                            Icons.watch_later,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onTap: () async => _selectedToTime =
                            await _pickTime(_toController, _selectedToTime),
                        validator: (toTime) {
                          if ((toTime ?? "").trim().isEmpty)
                            return "\"To\" time is required";

                          // if (_toDouble(_selectedToTime) <=
                          //     _toDouble(_selectedFromTime))
                          //   return "\"To\" time should be greater than \"From\" time";
                          // if (_toDouble(_selectedToTime) -
                          //         _toDouble(_selectedFromTime) <
                          //     1)
                          //   return "Shift duration should be at least 1 hour";
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _workingHoursController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Working Hours",
                    labelStyle: TextStyle(
                        color: Colors.grey
                    ),
                    suffixIcon: Icon(
                      Icons.watch_later,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onTap: () async => _selectedWorkingHours = await _pickPeriod(
                      _workingHoursController, _selectedWorkingHours),
                  validator: (workingHours) {
                    if ((workingHours ?? "").isEmpty)
                      return "Working Hours is required";
                    final duration = _selectedWorkingHours.hour * 60 +
                        _selectedWorkingHours.minute;
                    if (duration < 60 || duration > 1440)
                      return "Working Hours should be more than or equal 60 minutes and less than or equal 24 hours";
                   
                    if (_toDouble(_selectedWorkingHours) >
                        calculateShiftHours()) {
                      return workingHoursError;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.all(0),
                  title: Text("Make Default"),
                  value: _setAsDefaultValue,
                  onChanged: (value) async {
                    if (!_setAsDefaultValue!) {
                      final accepted = await showConfirmationDialog(
                        context: context,
                        actionText:
                            "You already have a default shift, Do you want to replace it with this shift for new employees?",
                        icon: FontAwesomeIcons.businessTime,
                        title: "Default Shift",
                      );
                      if (accepted != true) return;
                    }
                    setState(() => _setAsDefaultValue = value);
                  },
                ),
                const SizedBox(height: 16),
                Wrap(
                  children: [
                    Text("Valid shift days:",
                        style: Theme.of(context).textTheme.subtitle1),
                    _weekDays.isEmpty
                        ? Text(
                            "You need to select at least one day to create new shift",
                            style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors
                                    .red[700]), // TextStyle(color: Colors.red),
                          )
                        : Container(),
                  ],
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    _dayTile(DayOfWeek.sunday),
                    _dayTile(DayOfWeek.monday),
                    _dayTile(DayOfWeek.tuesday),
                    _dayTile(DayOfWeek.wednesday),
                    _dayTile(DayOfWeek.thursday),
                    _dayTile(DayOfWeek.friday),
                    _dayTile(DayOfWeek.saturday),
                  ],
                ),
                const SizedBox(height: 28),
                Container(
                  child: ElevatedButton(
                    child: Text("Save Shift".toUpperCase()),
                    onPressed: _createShift,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dayTile(DayOfWeek day) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
            value: _weekDays.contains(day),
            onChanged: (value) {
              if (value! && !_weekDays.contains(day))
                _weekDays.add(day);
              else if (!value) _weekDays.remove(day);
              setState(() {});
            }),
         SizedBox(width: 36, child: Text(day.name!)),
      ],
    );
  }

  void _createShift() async {
    setState(() => _didPressSave = true);
    if (!formKey.currentState!.validate()) {
      // ignore: deprecated_member_use
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fix the errors in red before submitting.")),
      );
      return;
    }
    if (_weekDays.isEmpty) return;

    final newShift = ShiftDTO(
      name: _shiftNameController.text.trim(),
      fromHour: _selectedFromTime.hour,
      fromMinutes: _selectedFromTime.minute,
      toHour: _selectedToTime.hour,
      toMinutes: _selectedToTime.minute,
      workingHoursInMinutes:
          (_selectedWorkingHours.hour * 60 + _selectedWorkingHours.minute),
      isDefault: _setAsDefaultValue,
      weekDays: _weekDays.toList(),
    );
    final response = await showFutureProgressDialog<ShiftDTOResponse>(
      context: context,
      initFuture: () => Repository().createShift(newShift),
    );

    if (response?.status ?? false) {
      await showAdaptiveAlertDialog(
          context: context,
          content: Text("(${newShift.name}) added successfully"));
      Navigator.of(context).pop(true);
    } else {
      await showErrorDialog(context, response);
    }
  }

  Future<TimeOfDay> _pickTime(
      TextEditingController controller, TimeOfDay selectedTime) async {
    final t = await showTimePicker(context: context, initialTime: selectedTime);
    if (t != null) {
      setState(() => controller.text = t.format(context));
      return t;
    }
    return selectedTime;
  }

  TimeOfDay _workingHoursInTwoDays({required bool isFromBigger}) {
    return TimeOfDay(
        hour: isFromBigger
            ? (_selectedFromTime.hour - 12) + _selectedToTime.hour
            : _selectedFromTime.hour - _selectedToTime.hour,
        minute: isFromBigger
            ? _selectedFromTime.minute + _selectedToTime.minute
            : _selectedFromTime.minute - _selectedToTime.minute);
  }

  Future<TimeOfDay> _pickPeriod(
      TextEditingController controller, TimeOfDay selectedTime) async {
    final t = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!);
      },
    );

    if (t != null) {
      setState(() {
        controller.text = MaterialLocalizations.of(context)
            .formatTimeOfDay(t, alwaysUse24HourFormat: true);
      });
      return t;
    }
    return selectedTime;
  }

  double _toDouble(TimeOfDay timeOfDay) {
    return (timeOfDay.hour + (timeOfDay.minute / 60));
  }

  double calculateShiftHours() {
    DateTime from, to;
    final now = DateTime.now();
    if ((_selectedFromTime.period == DayPeriod.pm &&
            _selectedToTime.period == DayPeriod.pm) ||
        (_selectedFromTime.period == DayPeriod.am &&
            _selectedToTime.period == DayPeriod.am)) {
      if (_selectedToTime.hour > _selectedFromTime.hour) {
        from = DateTime(now.year, now.month, now.day, _selectedFromTime.hour,
            _selectedFromTime.minute);
        to = DateTime(now.year, now.month, now.day, _selectedToTime.hour,
            _selectedToTime.minute);
      } else {
        from = DateTime(now.year, now.month, now.day, _selectedFromTime.hour,
            _selectedFromTime.minute);
        to = DateTime(now.year, now.month, now.day + 1, _selectedToTime.hour,
            _selectedToTime.minute);
      }
    } else if (_selectedFromTime.period == DayPeriod.pm &&
        _selectedToTime.period == DayPeriod.am) {
      from = DateTime(now.year, now.month, now.day, _selectedFromTime.hour,
          _selectedFromTime.minute);
      to = DateTime(now.year, now.month, now.day + 1, _selectedToTime.hour,
          _selectedToTime.minute);
    } else {
      from = DateTime(now.year, now.month, now.day, _selectedFromTime.hour,
          _selectedFromTime.minute);
      to = DateTime(now.year, now.month, now.day, _selectedToTime.hour,
          _selectedToTime.minute);
    }
    final mins = ((from.minute - to.minute) / 60).abs();
    return ((to.difference(from).inHours).toDouble() + mins);
  }
}
