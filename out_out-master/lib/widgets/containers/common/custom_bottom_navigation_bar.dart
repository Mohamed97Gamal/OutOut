import 'dart:io';
import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/memory/providers/bottom_navigation_bar_provider.dart';
import 'package:out_out/widgets/home/notification_badge.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final Color? backgroundColor;

  const CustomBottomNavigationBar({Key? key, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "BottomNavigationBar",
      child: Container(
        padding: EdgeInsets.only(top: Platform.isIOS ? 16.0 : 8.0, right: 5.0, left: 5.0, bottom: Platform.isIOS ? 0 : 8.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 15,
              blurRadius: 50,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Platform.isAndroid ? BottomNavigationBarAndroid() : BottomNavigationBarIOS(),
      ),
    );
  }
}

class BottomNavigationBarAndroid extends StatelessWidget {
  const BottomNavigationBarAndroid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bottomNavProvider = context.watch<BottomNavigationBarProvider>();
    if (!bottomNavProvider.show || bottomNavProvider.selectedIndex == -1) {
      return SizedBox.shrink();
    }

    final activeColor = Theme.of(context).primaryColor;
    return BottomNavigationBar(
      currentIndex: bottomNavProvider.selectedIndex,
      onTap: (index) {
        bottomNavProvider.navTo(context, NavigationItem.values[index]);
      },
      selectedLabelStyle: TextStyle(
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 11,
      ),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      items: [
        BottomNavigationBarItem(
          tooltip: "Home",
          label: "Home",
          icon: UniversalImage(IconAssets.home),
          activeIcon: UniversalImage(IconAssets.home, color: activeColor),
        ),
        BottomNavigationBarItem(
          tooltip: "Venues",
          label: "Venues",
          icon: UniversalImage(IconAssets.venue),
          activeIcon: UniversalImage(IconAssets.venue, color: activeColor),
        ),
        BottomNavigationBarItem(
          tooltip: "Events",
          label: "Events",
          icon: UniversalImage(IconAssets.event),
          activeIcon: UniversalImage(IconAssets.event, color: activeColor),
        ),
        BottomNavigationBarItem(
          tooltip: "Notifications",
          label: "Notifications",
          icon: NotificationBadgeIcon(
            activeColor: activeColor,
          ),
          activeIcon: UniversalImage(IconAssets.notification, color: activeColor),
        ),
        BottomNavigationBarItem(
          tooltip: "Profile",
          label: "Profile",
          icon: UniversalImage(IconAssets.profile),
          activeIcon: UniversalImage(IconAssets.profile, color: activeColor),
        ),
      ],
    );
  }
}

class BottomNavigationBarIOS extends StatelessWidget {
  const BottomNavigationBarIOS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bottomNavProvider = context.watch<BottomNavigationBarProvider>();
    if (!bottomNavProvider.show || bottomNavProvider.selectedIndex == -1) {
      return SizedBox.shrink();
    }

    final activeColor = Theme.of(context).primaryColor;
    return SizedBox(
      height: 80,
      child: OverflowBox(
        maxHeight: double.infinity,
        child: BottomNavigationBar(
          currentIndex: bottomNavProvider.selectedIndex,
          onTap: (index) {
            bottomNavProvider.navTo(context, NavigationItem.values[index]);
          },
          showUnselectedLabels: false,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 11,
          ),
          // unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,

          items: [
            BottomNavigationBarItem(
              tooltip: "Home",
              label: "",
              icon: BottomNavBarIcon(title: "Home", notificationImage: UniversalImage(IconAssets.home)),
              //UniversalImage(IconAssets.home),
              activeIcon: BottomNavBarIcon(
                isActive: true,
                title: "Home",
                notificationImage: UniversalImage(
                  IconAssets.home,
                  color: activeColor,
                ),
                color: activeColor,
              ),
              // UniversalImage(IconAssets.home, color: activeColor),
            ),
            BottomNavigationBarItem(
              tooltip: "Venues",
              label: "",
              icon: BottomNavBarIcon(title: "Venues", notificationImage: UniversalImage(IconAssets.venue)),
              //UniversalImage(IconAssets.venue),
              activeIcon: BottomNavBarIcon(
                isActive: true,
                title: "Venues",
                notificationImage: UniversalImage(
                  IconAssets.venue,
                  color: activeColor,
                ),
                color: activeColor,
              ),
              //UniversalImage(IconAssets.venue, color: activeColor),
            ),
            BottomNavigationBarItem(
              tooltip: "Events",
              label: "",
              icon: BottomNavBarIcon(title: "Events", notificationImage: UniversalImage(IconAssets.event)),
              //UniversalImage(IconAssets.event),
              activeIcon: BottomNavBarIcon(
                isActive: true,
                title: "Events",
                notificationImage: UniversalImage(
                  IconAssets.event,
                  color: activeColor,
                ),
                color: activeColor,
              ),
              // UniversalImage(IconAssets.event, color: activeColor),
            ),
            BottomNavigationBarItem(
              tooltip: "Notifications",
              label: "",
              icon: BottomNavBarIcon(
                  title: "Notifications",
                  notificationBadgeIcon: NotificationBadgeIcon(
                    activeColor: activeColor,
                  )),
              // NotificationBadgeIcon(),
              activeIcon: BottomNavBarIcon(
                isActive: true,
                title: "Notifications",
                notificationImage: UniversalImage(
                  IconAssets.notification,
                  color: activeColor,
                ),
                color: activeColor,
              ),
              // UniversalImage(IconAssets.notification, color: activeColor),
            ),
            BottomNavigationBarItem(
              tooltip: "Profile",
              label: "",
              icon: BottomNavBarIcon(title: "Profile", notificationImage: UniversalImage(IconAssets.profile)),
              //UniversalImage(IconAssets.profile),
              activeIcon: BottomNavBarIcon(
                title: "Profile",
                isActive: true,
                notificationImage: UniversalImage(
                  IconAssets.profile,
                  color: activeColor,
                ),
                color: activeColor,
              ),
              // UniversalImage(IconAssets.profile, color: activeColor),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBarIcon extends StatelessWidget {
  final String title;
  final UniversalImage? notificationImage;
  final NotificationBadgeIcon? notificationBadgeIcon;
  final Color color;
  final bool isActive;
  const BottomNavBarIcon({
    Key? key,
    required this.title,
    this.notificationBadgeIcon,
    this.notificationImage,
    this.color = const Color(0xffcdcdcd),
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        notificationImage ?? SizedBox(),
        notificationBadgeIcon ?? SizedBox(),
        SizedBox(height: 3),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            title,
            softWrap: true,
            style: TextStyle(overflow: TextOverflow.visible, fontWeight: isActive ? FontWeight.w500 : FontWeight.w300, fontSize: 15, color: color),
          ),
        ),
      ],
    );
  }
}
