import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/memory/providers/bottom_navigation_bar_provider.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class LoadingNotificationBadge extends StatelessWidget {
  const LoadingNotificationBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var activeColor = Theme.of(context).primaryColor;

    return Consumer<BottomNavigationBarProvider>(
        builder: (context, value, child) {
      return b.Badge(
        badgeStyle: b.BadgeStyle(
          borderRadius: BorderRadius.circular(8),
          badgeColor: activeColor,
        ),
        // toAnimate: false,
        showBadge: value.notificationCount != 0,
        badgeContent: Text(value.notificationCount.toString(),
            style: TextStyle(
              color: Colors.white,
            )),
        child: UniversalImage(IconAssets.notification),
      );
    });
  }
}
