import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class DrawerItem extends Equatable {
  final String? imageIconPath;
  final String? activeImageIconPath;
  final String? title;
  final Widget? trailing;
  final bool secondary;

  const DrawerItem._({
    this.activeImageIconPath,
    this.imageIconPath,
    this.secondary = false,
    this.title,
    this.trailing,
  }) : assert(secondary != null);
}

class ActionDrawerItem extends DrawerItem {
  final Function action;

  const ActionDrawerItem({
    String? imageIconPath,
    String? title,
    bool secondary = false,
    String? activeImageIconPath,
    required this.action,
    Widget? trailing,
  }) : super._(
          imageIconPath: imageIconPath,
          title: title,
          activeImageIconPath: activeImageIconPath,
          secondary: secondary,
          trailing: trailing,
        );

  @override
  List<Object?> get props => [imageIconPath, title, secondary, activeImageIconPath];
}

class RouteDrawerItem extends DrawerItem {
  final String route;

  const RouteDrawerItem({
    String? imageIconPath,
    String? activeImageIconPath,
    String? title,
    required this.route,
    bool secondary = false,
    Widget? trailing,
  })  : assert(route != null),
        super._(
          imageIconPath: imageIconPath,
          title: title,
          activeImageIconPath: activeImageIconPath,
          secondary: secondary,
          trailing: trailing,
        );

  @override
  List<Object?> get props => [imageIconPath, title, secondary, activeImageIconPath, route];
}

class ExpansionDrawerItem extends DrawerItem {
  final List<DrawerItem> children;

  const ExpansionDrawerItem({
    String? imageIconPath,
    String? title,
    required this.children,
  })  : assert(children != null),
        super._(
          imageIconPath: imageIconPath,
          title: title,
          secondary: false,
        );

  @override
  List<Object?> get props => [imageIconPath, title, secondary, activeImageIconPath, children];
}
