import 'package:flutter/material.dart';

class AdaptiveBottomSheetAction {
  final String title;
  final void Function() onPressed;
  final bool isPrimary;
  final bool showCloseButton;

  const AdaptiveBottomSheetAction({
    required this.title,
    required this.onPressed,
    this.isPrimary = false,
    this.showCloseButton = true,
  });
}

Future<T?> showAdaptiveBottomSheet<T>({
  required BuildContext context,
  required Widget content,
  Color? backgroundColor,
  bool showCloseButton = false,
  List<AdaptiveBottomSheetAction>? actions,
}) async {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return BottomSheet(
        backgroundColor: backgroundColor,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        onClosing: () {},
        builder: (context) {
          return ListView(
            shrinkWrap: true,
            children: [
              showCloseButton
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                        child: IconButton(
                          icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
                          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                          onPressed: () => Navigator.maybePop(context),
                        ),
                      ),
                    )
                  : const SizedBox(height: 40.0),
              content,
              if (actions != null && actions.isNotEmpty)
                const SizedBox(height: 8.0),
              if (actions != null && actions.isNotEmpty)
                for (final action in actions.where((a) => a.isPrimary))
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: action.onPressed,
                      child: Text(
                        action.title.toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              if (actions != null && actions.isNotEmpty)
                for (final action in actions.where((a) => !a.isPrimary))
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: OutlinedButton(
                      onPressed: action.onPressed,
                      child: Text(action.title.toUpperCase()),
                    ),
                  ),
              if (actions != null && actions.isNotEmpty)
                const SizedBox(height: 16.0),
            ],
          );
        },
      );
    },
  );
}
