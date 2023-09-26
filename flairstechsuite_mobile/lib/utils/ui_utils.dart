import 'package:flutter/material.dart';

class UIUtils {
  UIUtils._();

  static List<Widget?> separate({
    required Iterable<Widget> widgets,
    required Widget separator,
  }) {
    assert(separator != null);
    assert(widgets != null);
    final result = <Widget?>[];
    Widget? _separator;
    widgets.forEach((element) {
      result.add(_separator);
      result.add(element);
      _separator = separator;
    });
    if (result.isNotEmpty) result.removeAt(0);
    return result;
  }
}

class HiddenFABLocation extends StandardFabLocation {
  const HiddenFABLocation();

  @override
  double getOffsetY(ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) => -999;

  @override
  double getOffsetX(ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) => -999;
}
