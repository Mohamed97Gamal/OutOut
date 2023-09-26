import 'dart:async';

import 'package:flairstechsuite_mobile/main.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/auth/my_user_info_response.dart';
import 'package:flairstechsuite_mobile/models/notification.dart';
import 'package:flairstechsuite_mobile/repo/api/customer_portal/customer_portal_api_repo.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flutter/widgets.dart';

// ignore: prefer_mixin
class MyProfileProvider extends ChangeNotifier with WidgetsBindingObserver {
  EmployeeProfileDTO? _value;
  MyUserInfoResponse? _customerPortalUserInfo;
  StreamSubscription? _sub;
  var _isRunning = false;
  Timer? _retryTimer;

  MyProfileProvider() {
    WidgetsBinding.instance!.addObserver(this);
    _sub = localNotificationStream.listen((notification) {
      if (notification.type != NotificationType.userRoleChanged) return;
      //AuthRepository().token = null;
      refresh();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _sub?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Refresh the token in case the user role has changed
      // AuthRepository().token = null;
      refresh();
    }
  }

  Future<EmployeeProfileDTOResponse> get({bool force = false}) async {
    if (force != true && _value != null) {
      return EmployeeProfileDTOResponse(result: _value, status: true);
    }
    _isRunning = true;
    _retryTimer?.cancel();
    final response = await Repository().getMyEmployeeProfile();
    if (response.status) {
      _value = response.result;
      notifyListeners();
    } else {
      // _retryTimer = Timer(Duration(seconds: 3), refresh);
    }
    final customerPortalResponse = await CustomerPortalApiRepo().authClient.getMyUserInfo();
    if (customerPortalResponse.status!) {
      _customerPortalUserInfo = customerPortalResponse.result;
      notifyListeners();
    } else {
      // _retryTimer = Timer(Duration(seconds: 3), refresh);
    }
    _isRunning = false;
    return response;
  }

  EmployeeProfileDTO? get current {
    if (_value == null) refresh();
    return _value;
  }

  MyUserInfoResponse? get customerPortalUserInfo {
    if (_customerPortalUserInfo == null) refresh();
    return _customerPortalUserInfo;
  }

  void refresh() {
    if (!_isRunning) get(force: true);
  }

  void invalidate() => _value = null;
}
