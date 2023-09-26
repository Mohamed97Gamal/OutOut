import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResponsiveGridView extends StatelessWidget {
  final List<Widget>? children;
  final double? childAspectRatio;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final bool primary;

  final double columnsMultiplier;

  const ResponsiveGridView({
    this.children,
    this.columnsMultiplier = 1,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.childAspectRatio,
    this.primary = true,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        var columns = 4;
        var margins = 16.0;
        final width = MediaQuery.of(context).size.width;
        if (width > 840) {
          columns = 12;
          margins = 24;
        } else if (width > 600) {
          columns = 8;
          if (width > 720) {
            margins = 24;
          } else {
            margins = 16;
          }
        } else {
          columns = 4;
          margins = 16;
        }
        return GridView.count(
          primary: primary,
          crossAxisCount: (columns * columnsMultiplier / 2).floor(),
          mainAxisSpacing: margins,
          crossAxisSpacing: margins,
          shrinkWrap: shrinkWrap,
          physics: physics,
          padding: padding ?? EdgeInsets.all(margins),
          childAspectRatio: childAspectRatio!,
          children: children!,
        );
      },
    );
  }
}
