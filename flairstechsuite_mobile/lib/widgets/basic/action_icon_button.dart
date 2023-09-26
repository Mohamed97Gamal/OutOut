import 'package:flairstechsuite_mobile/widgets/basic/adaptive_progress_indicator.dart';
import 'package:flutter/material.dart';

typedef StartFuture<T> = Future<T> Function();
typedef OnSuccess<T> = Widget Function(BuildContext context, AsyncSnapshot<T> snapshot);

class ActionIconButton<T> extends StatefulWidget {
  final IconData? iconData;
  final StartFuture<T>? startFuture;
  final String? tooltip;

  const ActionIconButton({this.iconData, this.startFuture, this.tooltip});

  @override
  _ActionIconButtonState createState() => _ActionIconButtonState<T>();
}

class _ActionIconButtonState<T> extends State<ActionIconButton<T>> {
  Future<T>? _future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return _buildIconButton();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return const Center(child: AdaptiveProgressIndicator());
          case ConnectionState.done:
            if (snapshot.data == null || snapshot.hasError) {
              return _buildIconButton();
            }
            return Icon(Icons.done);
          default:
            return Container();
        }
      },
    );
  }

  Widget _buildIconButton() {
    return IconButton(
      icon: Icon(widget.iconData),
      tooltip: widget.tooltip,
      onPressed: widget.startFuture == null
          ? null
          : () {
              setState(() {
                _future = widget.startFuture!();
              });
            },
    );
  }
}
