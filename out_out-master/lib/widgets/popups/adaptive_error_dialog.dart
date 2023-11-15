import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/universal_image.dart';

Future<T?> showAdaptiveErrorDialog<T>({
  required BuildContext context,
  required String title,
  String? content,
  String? dismissText,
  bool barrierDismissible = true,
}) async {
  return showDialog<T>(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) {
      return AdaptiveAlertDialog(
        icon: UniversalImage(IconAssets.failed),
        title: title,
        content: content,
        actions: [
          if (dismissText != null)
            AdaptiveAlertDialogAction(
              isPrimary: true,
              title: dismissText,
              onPressed: () => Navigator.of(context).maybePop(),
            ),
        ],
      );
    },
  );
}
