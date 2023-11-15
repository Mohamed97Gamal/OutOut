import 'package:flutter/material.dart';

Future<TimeOfDay?> showAdaptiveTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) async {
  return await showTimePicker(
    context: context,
    initialTime: initialTime,
  );
}
