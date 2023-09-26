import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_dialog.dart' as dia;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<bool> showConfirmationDialog({
  required BuildContext context,
  required String actionText,
  required IconData icon,
  String? title,
  bool barrierDismissible = true,
  bool showFalseAction=true,
  bool showTitle=true,
  String trueTitle = "Yes",
    String falseTitle = "No"
}) async {
  final result = await dia.showAdaptiveDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return AdaptiveAlertDialog(
        title: showTitle?Row(
          children: <Widget>[
            FaIcon(icon),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title?.toString() ?? actionText,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ):Container(),
        content: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: ListBody(
            children: <Widget>[
              Text(actionText),
            ],
          ),
        ),
        actions: <AdaptiveAlertDialogAction>[
          if(showFalseAction==true)
          AdaptiveAlertDialogAction(
            title: falseTitle,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          AdaptiveAlertDialogAction(
            title: trueTitle,
            isPrimary: true,
            onPressed: () => Navigator.of(context).pop(true),
          )
        ],
      );
    },
  );
  return result ?? false;
}
