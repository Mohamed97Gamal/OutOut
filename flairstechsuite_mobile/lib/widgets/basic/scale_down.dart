import 'package:flutter/widgets.dart';

class ScaleDown extends StatelessWidget {
  final Widget? child;
  final AlignmentGeometry alignment;

  const ScaleDown({
    this.child,
    this.alignment = Alignment.center,
  }) : assert(alignment != null);

  @override
  Widget build(BuildContext context) {
    return FittedBox(child: child, fit: BoxFit.scaleDown, alignment: alignment);
  }
}
