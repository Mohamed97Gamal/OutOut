import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/splash_art.dart';
import 'package:out_out/widgets/popups/adaptive_dialog.dart'as di;

Future<T?> showFutureProgressDialog<T>({
  required BuildContext context,
  required InitFuture<T> initFuture,
  String? message,
}) async {
  return di.showAdaptiveDialog<T>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AdaptiveProgressDialog<T>(
        initFuture: initFuture,
        message: message,
      );
    },
  );
}

class AdaptiveProgressDialog<T> extends StatelessWidget {
  final InitFuture<T> initFuture;
  final String? message;

  const AdaptiveProgressDialog({
    required this.initFuture,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(40.0),
        ),
      ),
      content: SizedBox(
        height: 125.0,
        child: AdaptiveProgressDialogContent<T>(
          initFuture: initFuture,
        ),
      ),
    );
  }
}

class AdaptiveProgressDialogContent<T> extends StatelessWidget {
  final InitFuture<T> initFuture;

  const AdaptiveProgressDialogContent({
    required this.initFuture,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CustomFutureBuilder<T>(
        initFuture: () async {
          try {
            var result = await initFuture();
            Navigator.of(context, rootNavigator: true).pop(result);
            return result;
          } catch (ex) {
            if (ex is DioError) Navigator.of(context, rootNavigator: true).pop(ex.response?.data as T?);
            rethrow;
          }
        },
        onLoading: (context) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: const SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: SplashArt(),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Loading...",
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
        onError: (context, _) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: const SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: SplashArt(),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Loading...",
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
        onSuccess: (context, snapshot) {
          return const SplashArt();
        },
      ),
    );
  }
}
