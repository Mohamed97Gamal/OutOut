import 'dart:async';

import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/utils/common.dart';
import 'package:flairstechsuite_mobile/views/splash_art.dart';
import 'package:flutter/material.dart';

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
  final bool nullable;
  final OnError<T>? onError;

  const CustomFutureBuilder({
    required this.initFuture,
    required this.onSuccess,
    this.onLoading,
    this.nullable = false,
    this.onError,
  }) : assert(nullable != null);

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
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: const SplashArt(),
            );

          case ConnectionState.done:
            if (snapshot.data == null && !widget.nullable) {
              return _buildOnError(context, snapshot);
            }
            if (snapshot.hasError) {
              return _buildOnError(context, snapshot);
            }
            if (tryCast<BaseAPIResponse>(snapshot.data)?.status == false) {
              return _buildOnError(context, snapshot);
            }
            return widget.onSuccess(context, snapshot);

          default:
            return Container();
        }
      },
    );
  }

  Widget _buildOnError(BuildContext context, AsyncSnapshot<T> snapshot) {
    printIfDebug("snapshot error : ${snapshot.error.toString()}");

    if (widget.onError != null) {
      return widget.onError!(context, snapshot);
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
            children: const <Widget>[
              Icon(Icons.error),
              SizedBox(height: 4.0),
              Text("Something went wrong", textAlign: TextAlign.center),
              Text("Tap to try again"),
            ],
          ),
        ),
      ),
    );
  }
}
