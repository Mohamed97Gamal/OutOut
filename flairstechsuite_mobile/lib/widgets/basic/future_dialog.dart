import 'dart:async';

import 'package:flairstechsuite_mobile/utils/reponsive_utils.dart';
import 'package:flairstechsuite_mobile/views/splash_art.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_dialog.dart'as dia;
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flutter/material.dart';

typedef InitFuture<T> = Future<T?> Function();

Future<T?> showFutureProgressDialog<T>({
  required BuildContext context,
  required InitFuture<T> initFuture,
  bool nullable = false,
  String? message,
}) async {
  return dia.showAdaptiveDialog<T>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return ProgressDialogWidget(initFuture, nullable: nullable, message: message);
    },
  );
}

class ProgressDialogWidget extends StatelessWidget {
  final InitFuture initFuture;
  final bool? nullable;
  final String? message;

  const ProgressDialogWidget(
    this.initFuture, {
    this.nullable,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveAlertDialog(
      content: SizedBox(
        width: getResponsiveWidth(context, 600.0),
        child: ProgressDialogContent(
          initFuture,
          nullable: nullable,
          message: message,
        ),
      ),
      actions: const <AdaptiveAlertDialogAction>[],
    );
  }
}

class ProgressDialogContent extends StatelessWidget {
  final InitFuture initFuture;
  final bool? nullable;
  final String? message;

  const ProgressDialogContent(
    this.initFuture, {
    this.nullable,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
   return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.width * 0.5,
      child: CustomFutureBuilder(
        nullable: nullable!,
        initFuture: () async {
          final result = await initFuture();
          Future(() => Navigator.of(context, rootNavigator: true).pop(result));
          return result;
        },
        onLoading: (context) {
          return SplashArt(message: message);
        },
        onError: (context, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(Icons.error, size: 26),
                Spacer(),
                Text("Something went wrong. Please try again."),
                Spacer(),
                ElevatedButton(
                    child: Text("OK"),
                    onPressed: () async {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
        onSuccess: (context, snapshot) {
          return const SplashArt();
        },
      ),
    );
  }
}
