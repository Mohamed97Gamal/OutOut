import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/bottom_navigation_bar_provider.dart';
import 'package:out_out/data/view_models/notification/notification_response_page_operation_result.dart';
import 'package:out_out/widgets/home/loading_notification_badge.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class NotificationBadgeIcon extends StatelessWidget {
  final Color activeColor;
  NotificationBadgeIcon({Key? key, this.activeColor = const Color(0xffcdcdcd)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var activeColor = Theme.of(context).primaryColor;
    return CustomFutureBuilder<NotificationResponsePageOperationResult>(
      buildWidget: showBadge(badgeColor: activeColor),
      initFuture: () => ApiRepo().customersClient.getMyNotifications(0, 9),
      onLoading: (context) => LoadingNotificationBadge(),
      onError: (context, snapshot) => showBadge(badgeColor: activeColor),
      onSuccess: (context, snapshot) {
        final result = snapshot.data?.result.unReadNotificationsCount;

        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Provider.of<BottomNavigationBarProvider>(context, listen: false)
              .updateNotificationCount(result!);
        });
        return showBadge(
            showBadge: result != 0,
            badgeColor: activeColor,
            badgeContent: Text(result.toString(),
                style: TextStyle(
                  color: Colors.white,
                )));
      },
    );
  }

  Widget showBadge(
          {bool? showBadge,
          Color badgeColor = Colors.red,
          Widget? badgeContent}) =>
      b.Badge(
        badgeStyle: b.BadgeStyle(
          badgeColor: badgeColor,
          borderRadius: BorderRadius.circular(8),
        ),
        //toAnimate: false,
        showBadge: showBadge ?? false,
        badgeContent: badgeContent,
        child: UniversalImage(IconAssets.notification),
      );
}
