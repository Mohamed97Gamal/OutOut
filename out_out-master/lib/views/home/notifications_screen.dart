import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/bottom_navigation_bar_provider.dart';
import 'package:out_out/data/models/enums/notification_action.dart';
import 'package:out_out/data/view_models/notification/activated_offer.dart';
import 'package:out_out/data/view_models/notification/notification_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/containers/custom_flat_scaffold.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFlatScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          HorizontallyPaddedTitleText("Notifications"),
          const SizedBox(height: 16.0),
        ],
      ),
      slivers: [
        CustomPagedSliverListView<NotificationResponse>(
          initPageFuture: (pageKey) async {
            var notificationResult =
                await ApiRepo().customersClient.getMyNotifications(pageKey, 7);
            await ApiRepo().customersClient.markNotificationsAsRead(
                notificationResult.result.records.map((e) => e.id).toList());
            return notificationResult.result.toPagedList();
          },
          itemBuilder: (context, item, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: NotificationItem(
                notificationItem: item,
                // title: item.title,
                // subTitle: item.body,
                leading: CircleAvatar(
                  radius: 17.0,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: ClipOval(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: item.image == null
                          ? const EdgeInsets.all(8.0)
                          : EdgeInsets.zero,
                      child: UniversalImage.notification(
                        item.image,
                        width: 34.0,
                        height: 34.0,
                      ),
                    ),
                  ),
                ),
                dateTime: item.sentDate,
              ),
            );
          },
        ),
      ],
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationResponse notificationItem;
  final Widget leading;

  NotificationItem({
    Key? key,
    required this.notificationItem,
    required DateTime dateTime,
    required this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (notificationItem.action?.value ==
            NotificationAction.newOffer.value) {
          var result = await showFutureProgressDialog<ActivatedOffer>(
            context: context,
            initFuture: () async {
              context
                  .read<BottomNavigationBarProvider>()
                  .select(NavigationItem.Notifications);

              return await ApiRepo()
                  .offerClient
                  .isExpiredOffer(notificationItem.updatedEntityId!);
            },
          );
          if (result != null && result.status) {
            if (!result.result!) {
              Navigation().navToVenueDetailsScreen(context,
                  venueId: notificationItem.affectedId!);
            } else {
              final snackBar = SnackBar(
                content: const Text('This Offer is not available anymore'),
                backgroundColor: (Colors.black),
                action: SnackBarAction(
                  label: 'dismiss',
                  onPressed: () {},
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else {
            await showAdaptiveErrorDialog(
              context: context,
              title: "Error",
              content: result?.errorMessage ?? "Unknown Error",
            );
          }
        }
      },
      child: Card(
        color: !notificationItem.isRead ? Colors.grey[200] : Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2.0,
        child: ListTile(
          title: notificationItem.title == null
              ? null
              : Text(
                  notificationItem.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16),
                ),
          subtitle: Tooltip(
            message: notificationItem.body,
            child: notificationItem.body == null
                ? null
                : Text(
                    notificationItem.body!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
          ),
          leading: leading,
          trailing: SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  timeago.format(notificationItem.sentDate,
                          locale: "en_short") +
                      " ago",
                  // trailing,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Color(0xff8c8c8c),
                        fontSize: 11.0,
                      ),
                ),
                if (!notificationItem.isRead)
                  b.Badge(
                    badgeStyle: b.BadgeStyle(
                      badgeColor: Theme.of(context).primaryColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
