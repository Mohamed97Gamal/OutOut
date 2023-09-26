import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flutter/cupertino.dart';

mixin BaseRepository {
  Future<void> getResponse(BuildContext context, refresh,
      {required Future request,
      required String content,
      bool popScreen = false}) async {
    final response = await request;
    if (response?.status ?? false) {
      await showAdaptiveAlertDialog(
        context: context,
        content: Text(
          content,
        ),
      );
      if (popScreen) Navigator.of(context).pop(true);
      refresh();
    } else {
      await showErrorDialog(context, response);
    }
  }
}
