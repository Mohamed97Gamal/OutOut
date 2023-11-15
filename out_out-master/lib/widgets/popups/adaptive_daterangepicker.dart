import 'package:flutter/material.dart';

Future<DateTimeRange?> showAdaptiveDateRangePicker({
  required BuildContext context,
  required DateTimeRange initialDateRange,
  required DateTime firstDate,
  required DateTime lastDate,
}) async {
  return await showDateRangePicker(
    context: context,
    initialDateRange: initialDateRange,
    firstDate: firstDate,
    lastDate: lastDate,
  );
}
