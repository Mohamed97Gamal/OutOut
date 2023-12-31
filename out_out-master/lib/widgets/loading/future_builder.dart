import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:out_out/utils/common.dart';
import 'package:out_out/widgets/loading/splash_art.dart';

class RefreshNotifier extends ValueNotifier<DateTime> {
  RefreshNotifier() : super(DateTime.now());

  void refresh() => value = DateTime.now();
}

typedef InitFuture<T> = Future<T> Function();

typedef OnSuccess<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot);
typedef OnError<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot);

class CustomFutureBuilder<T> extends StatefulWidget {
  final OnSuccess<T> onSuccess;
  final InitFuture<T> initFuture;
  final WidgetBuilder? onLoading;
  final OnError<T>? onError;
  final Widget? buildWidget;

  const CustomFutureBuilder({
    required this.initFuture,
    required this.onSuccess,
    this.onLoading,
    this.onError,
    this.buildWidget
  });

  @override
  _CustomFutureBuilderState<T> createState() => _CustomFutureBuilderState<T>();
}

class _CustomFutureBuilderState<T> extends State<CustomFutureBuilder<T>> {
  Future<T>? future;

  @override
  void initState() {
    super.initState();
    future = widget.initFuture();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Container();
          case ConnectionState.active:
          case ConnectionState.waiting:
            if (widget.onLoading != null) {
              return widget.onLoading!(context);
            }
            return _buildOnLoading(context);

          case ConnectionState.done:
            if (snapshot.hasError) {
              if (snapshot.error is DioError) {
                return _buildNetworkError(context, snapshot,
                    buildWidget: widget.buildWidget);
              }
              return _buildOnError(context, snapshot);
            }
            final response = snapshot.data as dynamic;
            try {
              if (!response.status) {
                if (response.errorCode == 0) {
                  return _buildNetworkError(context, snapshot,
                      buildWidget: widget.buildWidget);
                }
                return _buildOnError(context, snapshot,
                    response?.errorMessage ?? "Unknown error");
              }
            } on NoSuchMethodError {}
            return widget.onSuccess(context, snapshot);
        }
      },
    );
  }

  Widget _buildOnLoading(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.hasBoundedHeight &&
            constraints.heightConstraints().maxHeight < 70.0) {
          return FittedBox(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const SplashArt(),
            ),
          );
        }
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: const SplashArt(),
        );
      },
    );
  }

  Widget _buildOnError(BuildContext context, AsyncSnapshot<T> snapshot,
      [String? errorMessage]) {
    if (snapshot.error != null) {
      FirebaseCrashlytics.instance
          .recordFlutterError(FlutterErrorDetails(exception: snapshot.error!));
      printIfDebug(
          "snapshot error : ${snapshot.error?.toString() ?? "Unknown"}");
    }
    if (widget.onError != null) {
      return widget.onError!(context, snapshot);
    }

    final material = Material.of(context);
    return Material(
      color: material == null ? null : Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.hasBoundedHeight &&
              constraints.heightConstraints().maxHeight < 70.0) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    future = widget.initFuture();
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(width: 16.0),
                    Icon(Icons.error),
                    const SizedBox(width: 8.0),
                    FittedBox(
                      child: Column(
                        children: [
                          Text(errorMessage ?? "Something went wrong",
                              textAlign: TextAlign.center),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.refresh,
                                  color: Theme.of(context).primaryColor),
                              Text("Retry",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                  ],
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  future = widget.initFuture();
                });
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.error),
                    const SizedBox(height: 4.0),
                    Text(errorMessage ?? "Something went wrong",
                        textAlign: TextAlign.center),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.refresh,
                            color: Theme.of(context).primaryColor),
                        Text("Retry",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNetworkError(BuildContext context, AsyncSnapshot<T> snapshot,
      {Widget? buildWidget}) {
    final material = Material.of(context);
    if (buildWidget != null) return buildWidget;
    return Material(
      color: material == null ? null : Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.hasBoundedHeight &&
              constraints.heightConstraints().maxHeight < 70.0) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    future = widget.initFuture();
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(width: 8.0),
                    FittedBox(
                      child: Column(
                        children: [
                          Text("Network error."),
                          Row(
                            children: [
                              Icon(Icons.refresh,
                                  color: Theme.of(context).primaryColor),
                              Text("Retry",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                  ],
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  future = widget.initFuture();
                });
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 4.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Network error."),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.refresh,
                                color: Theme.of(context).primaryColor),
                            Text("Retry",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
