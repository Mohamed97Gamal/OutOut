import 'package:flutter/material.dart';
import 'package:out_out/data/memory/providers/bottom_navigation_bar_provider.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:provider/provider.dart';

Future<bool> showAdaptiveConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
}) async {
  return await showAdaptiveAlertDialog<bool?>(
        showCloseButton: false,
        context: context,
        icon: Container(),
        title: title,
        content: content,
        actions: <AdaptiveAlertDialogAction>[
          AdaptiveAlertDialogAction(
            title: "Yes",
            onPressed: () async {
              BottomNavigationBarProvider.instance.selectedIndexesHistory
                  .add(1);
              await Navigator.of(context).maybePop(true);
            },
            isPrimary: true,
          ),
          AdaptiveAlertDialogAction(
            title: "No",
            onPressed: () async {
              await Navigator.of(context).maybePop(false);
            },
          ),
        ],
      ) ??
      false;
}
