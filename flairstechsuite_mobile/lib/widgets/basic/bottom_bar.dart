import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/navigation/my_router.dart';
import 'package:flairstechsuite_mobile/navigation/navigation_item.dart';
import 'package:flairstechsuite_mobile/providers/my_profile_provider.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProfileProvider>(
      builder: (context, provider, _) {
        final items = _getItems(context, provider.current);
        final currentRoute = ModalRoute.of(context);
        final currentIndex = items.indexWhere((e) => currentRoute!.settings.name == e.route);
        return BottomNavigationBar(
          elevation: 8.0,
          currentIndex: currentIndex >= 0 ? currentIndex : items.length - 1,
          unselectedItemColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            final item = items[index];
            if (item.route == currentRoute!.settings.name) return;
            WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
            Navigator.of(context).pushNamedAndRemoveUntil(item.route, (_) => false);
          },
          items: items.map((e) {
            final icon = Image.asset(e.imageIconPath!, height: 25.0, color: Colors.black54);
            final activeIcon = Image.asset(e.activeImageIconPath!, height: 25.0, color: Theme.of(context).primaryColor);
            return BottomNavigationBarItem(
              label: e.title,
              icon: icon,
              activeIcon: currentIndex >= 0 ? activeIcon : icon,
            );
          }).toList(),
        );
      },
    );
  }

  List<RouteDrawerItem> _getItems(BuildContext context, EmployeeProfileDTO? userProfile) {
    final isAdmin = userProfile?.isAdmin ?? false;
    final useTenroxTasksFeature = userProfile?.useTenroxTasksFeature ?? false;
    return [
      RouteDrawerItem(
        title: "Check In/Out",
        route: MyRouter.checkInOut,
        imageIconPath: ResourcesUtils.stopwatch,
        activeImageIconPath: ResourcesUtils.stopwatchActive,
      ),
      if (useTenroxTasksFeature)
        RouteDrawerItem(
          title: "My Tenrox Tasks",
          route: MyRouter.myTasks,
          imageIconPath: ResourcesUtils.tasks,
          activeImageIconPath: ResourcesUtils.tasks,
        ),
      RouteDrawerItem(
        title: "My Profile",
        route: MyRouter.myProfile,
        imageIconPath: ResourcesUtils.myProfile,
        activeImageIconPath: ResourcesUtils.myProfileActive,
      ),
      RouteDrawerItem(
        route: !isAdmin ? MyRouter.employeeDashboard : MyRouter.adminDashboard,
        title: !isAdmin ? "My Company" : "Company Information",
        imageIconPath: ResourcesUtils.myCompany,
        activeImageIconPath: ResourcesUtils.myCompanyActive,
      ),
    ];
  }
}
