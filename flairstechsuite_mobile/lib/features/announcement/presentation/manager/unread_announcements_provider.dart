import 'dart:async';
import 'dart:io';

import 'package:flairstechsuite_mobile/main.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/models/notification.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

// ignore: prefer_mixin
class UnreadAnnouncementsProvider extends ChangeNotifier
    with WidgetsBindingObserver {
  int? _value;
  StreamSubscription? _sub;
  final _announcementTypes = {
    NotificationType.sendNotificationAnnouncement,
    NotificationType.createEditAnnouncement
  };

  UnreadAnnouncementsProvider() {
    WidgetsBinding.instance!.addObserver(this);
    _sub = localNotificationStream.listen((notification) {
      if (!_announcementTypes.contains(notification.type)) return;
      refresh();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _sub?.cancel();
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   if (state == AppLifecycleState.resumed) refresh();
  // }

  Future<IntResponse> get() async {
    final response = await Repository().getUnreadAnnouncementsCount();
    if (response.status && response.result != _value) {
      _value = response.result;
      notifyListeners();
    }
    _updateIosNotificationBadgeCount(_value);
    return response;
  }

  int? get current {
    if (_value == null) refresh();
    return _value;
  }

  void refresh() {
    get();
  }

  void invalidate() => _value = null;

  void _updateIosNotificationBadgeCount(int? count) {
    if (Platform.isAndroid) return;
    if (count != null && count > 0) {
      FlutterAppBadger.updateBadgeCount(count);
    } else {
      FlutterAppBadger.removeBadge();
    }
  }
}
