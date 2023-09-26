import 'dart:async';

import '../data/model/announcement_dto.dart';
import '../domain/entity/announcement.dart';
import 'widgets/view_screen/view_announcement_body.dart';
import '../../../main.dart';
import '../../../models/notification.dart';
import 'manager/unread_announcements_provider.dart';
import '../../../repo/repository.dart';
import '../../../utils/resources_utils.dart';
import '../../../widgets/basic/bottom_bar.dart';
import '../../../widgets/basic/drawer_scaffold.dart' as menu;
import '../../../widgets/basic/scale_down.dart';
import '../../../widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ViewAnnouncementsPage extends StatefulWidget {
  @override
  _ViewAnnouncementsPageState createState() => _ViewAnnouncementsPageState();
}

class _ViewAnnouncementsPageState extends State<ViewAnnouncementsPage> {
  static const _PAGE_SIZE = 5;
  List<AnnouncementEntity>? _announcements;
  int? _recordsTotalCount;
  StreamSubscription? _notificationSub;
  StreamSubscription? _unreadStatusSub;

  bool get _hasData => _recordsTotalCount != null && _announcements != null;

  @override
  void initState() {
    super.initState();
    Provider.of<UnreadAnnouncementsProvider>(context, listen: false).refresh();
    _notificationSub = localNotificationStream.listen((notification) {
      final announcements = {
        NotificationType.sendNotificationAnnouncement,
        NotificationType.createEditAnnouncement
      };
      if (!announcements.contains(notification.type)) return;
      _refresh(refreshUnreadCount: false);
    });
    _unreadStatusSub =
        announcementReadStatusStream.stream.listen((_) => _refresh());
  }

  @override
  void dispose() {
    _notificationSub?.cancel();
    _unreadStatusSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return menu.DrawerScaffold(
      builder: (context) {
        return NotificationScaffold(
            bottomNavigationBar: const MyBottomNavigationBar(),
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(ResourcesUtils.menu),
                ),
                onPressed: () =>
                    Provider.of<menu.MenuController>(context, listen: false)
                        .toggle(),
              ),
              title: const ScaleDown(child: Text("ANNOUNCEMENTS")),
            ),
            body: ViewAnnouncementBody(
              announcements: _announcements,
              hasData: _hasData,
              onLoadMore: _load,
              recordsTotalCount: _recordsTotalCount,
              refresh: _refresh,
            ));
      },
    );
  }

  Future<bool> _load() async {
    final response = await Repository().getPublishedAnnouncements(
      pageNumber: ((_announcements?.length ?? 0) / _PAGE_SIZE).ceil(),
      pageSize: _PAGE_SIZE,
    );
    if (response.status == true) {
      setState(() {
        _recordsTotalCount = response.result!.recordsTotalCount;
        _announcements = (_announcements ?? []).toList()
          ..addAll(response.result!.records!);
      });
    }
    return response.status;
  }

  void _refresh({bool refreshUnreadCount = true}) {
    if (refreshUnreadCount == true)
      Provider.of<UnreadAnnouncementsProvider>(context, listen: false)
          .refresh();
    if (!mounted) return;
    setState(() {
      _recordsTotalCount = null;
      _announcements = null;
    });
  }
}
