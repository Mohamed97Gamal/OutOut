import 'dart:async';

import '../data/model/announcement_dto.dart';
import 'widgets/manage_screen/manage_announcement_body.dart';
import '../../../main.dart';
import '../../../models/notification.dart';
import 'manager/unread_announcements_provider.dart';
import '../../../repo/repository.dart';
import '../../../utils/navigation.dart';
import '../../../utils/resources_utils.dart';
import '../../../widgets/basic/bottom_bar.dart';
import '../../../widgets/basic/drawer_scaffold.dart' as menu;
import '../../../widgets/basic/scale_down.dart';
import '../../../widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ManageAnnouncementsPage extends StatefulWidget {
  @override
  _ManageAnnouncementsPageState createState() =>
      _ManageAnnouncementsPageState();
}

class _ManageAnnouncementsPageState extends State<ManageAnnouncementsPage> {
  static const _PAGE_SIZE = 5;
  List<AnnouncementDTO>? _announcements;
  int? _recordsTotalCount;
  StreamSubscription? _sub;

  bool get _hasData => _recordsTotalCount != null && _announcements != null;

  @override
  void initState() {
    super.initState();
    Provider.of<UnreadAnnouncementsProvider>(context, listen: false).refresh();
    _sub = localNotificationStream.listen((notification) {
      final announcements = {
        NotificationType.sendNotificationAnnouncement,
        NotificationType.createEditAnnouncement
      };
      if (!announcements.contains(notification.type)) return;
      _refresh(refreshUnreadCount: false);
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
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
                  Provider.of<menu.MenuController>(context, listen: false).toggle(),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  final result =
                      await Navigation.navToCreateAnnouncement(context);
                  if (result == true) _refresh();
                },
              )
            ],
            title: const ScaleDown(child: Text("MANAGE ANNOUNCEMENTS")),
          ),
          body: ManageAnnouncementBody(
            hasData: _hasData,
            refresh: _refresh,
            onLoadMore: _load,
            announcements: _announcements,
            recordsTotalCount: _recordsTotalCount,
          ),
          //_buildBody(context),
        );
      },
    );
  }

  Future<bool> _load() async {
    final response = await Repository().getAllAnnouncements(
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

  _refresh({bool refreshUnreadCount = true}) {
    if (refreshUnreadCount == true)
      Provider.of<UnreadAnnouncementsProvider>(context, listen: false)
          .refresh();
    setState(() {
      _recordsTotalCount = null;
      _announcements = null;
    });
  }
}
