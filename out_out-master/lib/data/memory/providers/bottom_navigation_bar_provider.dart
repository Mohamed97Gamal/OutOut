import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:out_out/navigation/navigation.dart';

enum NavigationItem {
  Home,
  Venues,
  Events,
  Notifications,
  Profile,
}

class BottomNavigationBarProvider with ChangeNotifier, DiagnosticableTreeMixin {
  static final BottomNavigationBarProvider instance =
      BottomNavigationBarProvider();

  bool _show = false;
  int _selectedIndex = 0;
  List<int> _selectedIndexesHistory = [];
  int notificationCount = 0;
  bool get show => _show;
  List<int> get selectedIndexesHistory => _selectedIndexesHistory;
  void set selectedIndexesHistory(List<int> selectedIndexesHistory) {
    _selectedIndexesHistory = selectedIndexesHistory;
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;

  void hide() {
    _show = false;
    _selectedIndex = -1;
    _selectedIndexesHistory.add(_selectedIndex);
    notifyListeners();
  }

  void clearAndSelect(NavigationItem navigationItem) {
    _show = true;
    _selectedIndex = navigationItem.index;
    _selectedIndexesHistory = [_selectedIndex];
    notifyListeners();
  }

  void clearAndHide() {
    _show = true;
    _selectedIndex = -1;
    _selectedIndexesHistory = [_selectedIndex];
    notifyListeners();
  }

  void select(NavigationItem navigationItem) {
    _show = true;
    _selectedIndex = navigationItem.index;
    _selectedIndexesHistory.add(_selectedIndex);
    notifyListeners();
  }

  void back() {
    if (_selectedIndexesHistory.length < 2) {
      return;
    }
    _selectedIndexesHistory.removeLast();
    var lastSelected = _selectedIndexesHistory.last;
    _show = (lastSelected != -1);
    _selectedIndex = lastSelected;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('show', value: show));
    properties.add(IntProperty('selectedIndex', selectedIndex));
  }

  void navTo(BuildContext context, NavigationItem navigationItem) {
    if (navigationItem.index == selectedIndex) {
      return;
    }

    switch (navigationItem) {
      case NavigationItem.Home:
        Navigation().navToHomeScreen(context);
        break;
      case NavigationItem.Venues:
        Navigation().navToVenuesScreen(context);
        break;
      case NavigationItem.Events:
        Navigation().navToEventsScreen(context);
        break;
      case NavigationItem.Notifications:
        Navigation().navToNotificationsScreen(context);
        break;
      case NavigationItem.Profile:
        Navigation().navToMyProfileScreen(context);
        break;
    }
  }

  void updateNotificationCount(int value) {
    notificationCount = value;
    notifyListeners();
  }
}
