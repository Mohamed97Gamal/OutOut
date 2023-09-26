import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveAlertDialogAction {
  final String title;
  final void Function() onPressed;
  final bool isPrimary;

  const AdaptiveAlertDialogAction({
    required this.title,
    required this.onPressed,
    this.isPrimary = false,
  });
}

class AdaptiveAlertDialog extends StatelessWidget {
  final Widget? title;
  final Widget content;
  final List<AdaptiveAlertDialogAction>? actions;

  const AdaptiveAlertDialog({
    required this.content,
    this.actions,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        buttonBarTheme:
            Theme.of(context).buttonBarTheme.copyWith(buttonHeight: 40.0),
      ),
      child: AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 0.0),
        title: title != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, top: 16.0, bottom: 8.0),
                    child: title,
                  ),
                  Divider(),
                ],
              )
            : null,
        content: SingleChildScrollView(
          child: content,
        ),
        actions: <Widget>[
          if (actions != null)
            for (final action in actions!.where((a) => !a.isPrimary))
              ElevatedButton(
                onPressed: action.onPressed,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: Text(action.title.toUpperCase(),style: TextStyle(color: Theme.of(context).primaryColor),),
              ),
          if (actions != null)
            for (final action in actions!.where((a) => a.isPrimary))
              ElevatedButton(
                onPressed: action.onPressed,
                child: Text(
                  action.title.toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
        ],
      ),
    );
  }
}

Future<T?> showAdaptiveAlertDialog<T>({
  required BuildContext context,
  Widget? title,
  required Widget content,
  VoidCallback? onPressed
}) async {
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          const SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: onPressed ?? () => Navigator.of(context).pop(),
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 8.0),
        ],
      );
    },
  );
}

Future<T?> showAdaptiveAlertDialogDissmisable<T>({
  required BuildContext context,
  Widget? title,
  Widget? storeButton,
  required Widget content,
}) async {
  return showDialog<T>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          const SizedBox(width: 8.0),
          storeButton ?? Container(),
          const SizedBox(width: 8.0),
        ],
      );
    },
  );
}
