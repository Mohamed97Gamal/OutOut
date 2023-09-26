import 'package:flutter/material.dart';

const double pi = 3.1415926535897932;

class FabAction {
  String text;
  IconData icon;
  Function onPressed;

  FabAction(this.text, this.icon, this.onPressed);
}

class MultiFabButton extends StatefulWidget {
  final List<FabAction> fabActions;

  const MultiFabButton(this.fabActions);

  @override
  _MultiFabButtonState createState() => _MultiFabButtonState();
}

class _MultiFabButtonState extends State<MultiFabButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).cardColor;
    final foregroundColor = Theme.of(context).hintColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.fabActions.length, (index) {
        final Widget child = Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Interval(0.0, 1.0 - index / widget.fabActions.length / 2.0, curve: Curves.easeOut),
            ),
            child: FloatingActionButton(
              tooltip: widget.fabActions[index].text,
              heroTag: null,
              backgroundColor: backgroundColor,
              mini: true,
              onPressed: () {
                widget.fabActions[index].onPressed();
              },
              child: Icon(widget.fabActions[index].icon, color: foregroundColor),
            ),
          ),
        );
        return child;
      }).toList()
        ..add(
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.rotationZ(_controller.value * 0.5 * pi),
                  alignment: FractionalOffset.center,
                  child: Icon(_controller.isDismissed ? Icons.more_vert : Icons.close),
                );
              },
            ),
          ),
        ),
    );
  }
}
