import 'dart:async';

import 'package:flairstechsuite_mobile/features/announcement/data/model/announcement_dto.dart';
import 'package:flairstechsuite_mobile/models/notification.dart';
import 'package:flairstechsuite_mobile/navigation/my_router.dart';
import 'package:flairstechsuite_mobile/utils/common.dart';
import 'package:flairstechsuite_mobile/utils/ui_utils.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

import '../main.dart';

class NotificationScaffold extends Scaffold {
  const NotificationScaffold({
    Key? key,
    PreferredSizeWidget? appBar,
    Widget? body,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    FloatingActionButtonAnimator? floatingActionButtonAnimator,
    List<Widget>? persistentFooterButtons,
    Widget? drawer,
    Widget? endDrawer,
    Widget? bottomNavigationBar,
    Widget? bottomSheet,
    Color? backgroundColor,
    bool? resizeToAvoidBottomInset,
    bool primary = true,
    DragStartBehavior drawerDragStartBehavior = DragStartBehavior.start,
    bool extendBody = false,
    bool extendBodyBehindAppBar = false,
    Color? drawerScrimColor,
    double? drawerEdgeDragWidth,
    bool drawerEnableOpenDragGesture = true,
    bool endDrawerEnableOpenDragGesture = true,
  }) : super(
          key: key,
          appBar: appBar,
          body: body,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButtonAnimator: floatingActionButtonAnimator,
          persistentFooterButtons: persistentFooterButtons,
          drawer: drawer,
          endDrawer: endDrawer,
          bottomNavigationBar: bottomNavigationBar,
          bottomSheet: bottomSheet,
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          primary: primary,
          drawerDragStartBehavior: drawerDragStartBehavior,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          drawerScrimColor: drawerScrimColor,
          drawerEdgeDragWidth: drawerEdgeDragWidth,
          drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
          endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        );

  @override
  ScaffoldState createState() => _NotificationScaffoldState();
}

class _NotificationScaffoldState extends ScaffoldState {
  StreamSubscription? _sub;
  final _announcementTypes = {
    NotificationType.sendNotificationAnnouncement,
    NotificationType.createEditAnnouncement
  };

  @override
  void initState() {
    super.initState();
    _sub = localNotificationStream.listen((notification) {
      final body = _buildNotificationBody(notification);
      if (body == null) return;
      // ignore: deprecated_member_use
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: EdgeInsets.zero,
          content: InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: body,
            ),
            onTap: _snackBarCallback(notification),
          ),
        ),
      );
    });
  }

  GestureTapCallback? _snackBarCallback(NotificationContent notification) {
    if (_announcementTypes.contains(notification.type)) {
      final announcementId = tryCast<String>(notification.payload);
      if (announcementId == null || announcementId?.isEmpty == true)
        return null;
      return () async {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        final result =
            await Navigator.of(context).pushNamedAndRemoveUntil<bool>(
          MyRouter.routeWithId(MyRouter.viewAnnouncementsDetails,
              id: announcementId),
          (r) => !r.settings.name!
              .startsWith(MyRouter.viewAnnouncementsDetails + "/"),
        );
        if (result == true) announcementReadStatusStream.add(null);
      };
    } else if (notification.type == NotificationType.managerLocationRequest) {
      return () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        Navigator.of(context).pushNamedAndRemoveUntil(
            MyRouter.managerLocationRequests, (_) => false);
      };
    } else if (notification.type == NotificationType.checkInOutReminder) {
      return () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(MyRouter.checkInOut, (_) => false);
      };
    } else if (notification.type == NotificationType.sendStartTaskReminder) {
      return () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(MyRouter.myTasks, (_) => false);
      };
    } else if (notification.type ==
        NotificationType.locationRequestStatusChanged) {
      return () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(MyRouter.myLocations, (_) => false);
      };
    }
    return null;
  }

  Widget? _buildNotificationBody(NotificationContent notification) {
    if (notification == null) return null;
    final children = UIUtils.separate(
      widgets: [
        if (_announcementTypes.contains(notification.type))
          Text(
            "Announcement:",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        if (notification.title != null)
          Text(
            notification.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        if (notification.body != null)
          Text(
            notification.body!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
      ],
      separator: const SizedBox(height: 2),
    );
    if (children.isEmpty) return null;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children as List<Widget>,
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
