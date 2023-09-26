import 'package:flairstechsuite_mobile/utils/date_utils.dart' as date_utils;
import 'package:flairstechsuite_mobile/utils/theme_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _kPickerSheetHeight = 216.0;

class DatePicker extends StatelessWidget {
  const DatePicker({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    required this.labelText,
    required this.selectedDate,
    required this.selectDate,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> selectDate;

  Future _selectDate(BuildContext context) async {
    if (isCupertinoTheme) {
      await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          final time = selectedDate;
          return _buildBottomPicker(
            CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: time,
              onDateTimeChanged: (newDateTime) {
                if (newDateTime != null && newDateTime != selectedDate) selectDate(newDateTime);
              },
            ),
          );
        },
      );
      return;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              date_utils.DateUtils.dateFormat.format(selectedDate),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBottomPicker(Widget picker) {
  return Container(
    height: _kPickerSheetHeight,
    padding: const EdgeInsets.only(top: 6.0),
    color: CupertinoColors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.black,
        fontSize: 22.0,
      ),
      child: GestureDetector(
        // Blocks taps from propagating to the modal sheet and popping.
        onTap: () {},
        child: SafeArea(
          top: false,
          child: picker,
        ),
      ),
    ),
  );
}
