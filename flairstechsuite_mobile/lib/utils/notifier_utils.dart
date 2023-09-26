import 'package:flairstechsuite_mobile/utils/common.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flutter/material.dart';

Future showErrorDialog(
  BuildContext context,
  dynamic response, {
  VoidCallback? onPressed,
}) async {
  try {
    final message = response?.errorMessage as String?;
    final errors = (response?.errors as List<String>?) ?? [];
    if (message != null) {
      await showAdaptiveAlertDialog(
        context: context,
        onPressed: onPressed,
        title: Row(
          children: [
            Icon(Icons.error),
            const SizedBox(width: 8.0),
            Text("Error"),
          ],
        ),
        content: Text(
          message + (errors.isNotEmpty ? "\n" : "") + errors.join("\n"),
        ),
      );
    } else {
      await showAdaptiveAlertDialog(
        context: context,
        title: Row(
          children: [
            Icon(Icons.error),
            const SizedBox(width: 8.0),
            Text("Error"),
          ],
        ),
        content: Text("Something went wrong. Please try again."),
      );
    }
  } catch (ex) {
    printIfDebug(ex);
    await showAdaptiveAlertDialog(
      context: context,
      title: Row(
        children: [
          Icon(Icons.error),
          const SizedBox(width: 8.0),
          Text("Error"),
        ],
      ),
      content: Text("Something went wrong. Please try again."),
    );
  }
}
