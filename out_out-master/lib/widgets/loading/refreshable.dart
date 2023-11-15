import 'package:flutter/material.dart';
import 'package:out_out/widgets/loading/future_builder.dart';

class Refreshable extends StatelessWidget {
  final RefreshNotifier refreshNotifier;
  final Widget child;

  Refreshable({
    required this.refreshNotifier,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: refreshNotifier,
      builder: (context, value, __) {
        return Container(
          key: Key(value.toString()),
          child: child,
        );
      },
    );
  }
}

class MultipleRefreshable extends StatelessWidget {
  final List<RefreshNotifier> refreshNotifiers;
  final Widget child;

  MultipleRefreshable({
    required this.refreshNotifiers,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (refreshNotifiers.length == 1) {
      return ValueListenableBuilder(
        valueListenable: refreshNotifiers[0],
        builder: (context1, value1, _1) {
          return Container(
            key: Key(value1.toString()),
            child: child,
          );
        },
      );
    }
    if (refreshNotifiers.length == 2) {
      return ValueListenableBuilder(
        valueListenable: refreshNotifiers[0],
        builder: (context1, value1, _1) {
          return ValueListenableBuilder(
            valueListenable: refreshNotifiers[1],
            builder: (context2, value2, _2) {
              return Container(
                key: Key(value1.toString() + value2.toString()),
                child: child,
              );
            },
          );
        },
      );
    }
    if (refreshNotifiers.length == 3) {
      return ValueListenableBuilder(
        valueListenable: refreshNotifiers[0],
        builder: (context1, value1, _1) {
          return ValueListenableBuilder(
            valueListenable: refreshNotifiers[1],
            builder: (context2, value2, _2) {
              return ValueListenableBuilder(
                valueListenable: refreshNotifiers[2],
                builder: (context3, value3, _3) {
                  return Container(
                    key: Key(value1.toString() + value2.toString() + value3.toString()),
                    child: child,
                  );
                },
              );
            },
          );
        },
      );
    }
    if (refreshNotifiers.length == 4) {
      return ValueListenableBuilder(
        valueListenable: refreshNotifiers[0],
        builder: (context1, value1, _1) {
          return ValueListenableBuilder(
            valueListenable: refreshNotifiers[1],
            builder: (context2, value2, _2) {
              return ValueListenableBuilder(
                valueListenable: refreshNotifiers[2],
                builder: (context3, value3, _3) {
                  return ValueListenableBuilder(
                    valueListenable: refreshNotifiers[3],
                    builder: (context4, value4, _4) {
                      return Container(
                        key: Key(value1.toString() + value2.toString() + value3.toString() + value4.toString()),
                        child: child,
                      );
                    },
                  );
                },
              );
            },
          );
        },
      );
    }
    return child;
  }
}
