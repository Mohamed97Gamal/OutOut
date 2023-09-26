import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/auth/my_user_info_response.dart';
import 'package:flairstechsuite_mobile/navigation/my_router.dart';
import 'package:flairstechsuite_mobile/navigation/navigation_item.dart';
import 'package:flairstechsuite_mobile/providers/my_profile_provider.dart';
import 'package:flairstechsuite_mobile/features/announcement/presentation/manager/unread_announcements_provider.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/common.dart';
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/cached_network_image.dart';
import 'package:flairstechsuite_mobile/widgets/basic/confirmation_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';

import 'package:flairstechsuite_mobile/widgets/basic/scale_down.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class DrawerScaffold extends StatefulWidget {
  final WidgetBuilder? builder;

  DrawerScaffold({this.builder});

  @override
  _DrawerScaffoldState createState() => _DrawerScaffoldState();
}

class _DrawerScaffoldState extends State<DrawerScaffold> with TickerProviderStateMixin {
  static const _scaleDownCurve = Interval(0.0, 0.3, curve: Curves.easeOut);
  static const _scaleUpCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
  static const _slideOutCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
  static const _slideInCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
  MenuController? menuController;

  @override
  void initState() {
    super.initState();
    menuController = MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: menuController,
      child: Scaffold(
        body: Stack(
          children: [
            Consumer<MyProfileProvider>(
              builder: (context, provider, _) => _buildMenu(
                context,
                provider.current,
                provider.customerPortalUserInfo,
              ),
            ),
            Builder(builder: (context) => _buildScreen(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context, EmployeeProfileDTO? userProfile, MyUserInfoResponse? customerPortalUserInfo) {
    final items = _getItems(context, userProfile, customerPortalUserInfo);
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              ResourcesUtils.sandClockBg,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
            ),
          ),
          userProfile == null
              ? SizedBox(
            width: 276.0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white)),
                  ),
                  SizedBox(height: 12.0),
                  Text("Something went wrong", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 2.0),
                  Text("Retrying...", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          )
              : Material(
            type: MaterialType.transparency,
            child: SizedBox(
              width: 276.0,
              child: ListView.builder(
                key: PageStorageKey("drawer_list"),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                itemCount: (items?.length ?? 0) + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return DrawerHeader(
                      child: DefaultTextStyle(
                        style: const TextStyle(color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: AvatarNetworkImage(
                                    userProfile.profileImagePath,
                                    width: 60.0,
                                    height: 60.0,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        userProfile.fullName ?? "",
                                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        userProfile.title ?? "",
                                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    );
                  }
                  return _DrawerItemWidget(item: items![index - 1]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DrawerItem>? _getItems(
      BuildContext context,
      EmployeeProfileDTO? userProfile,
      MyUserInfoResponse? customerPortalUserInfo,
      ) {
    if (userProfile == null) return null;
    final profileProvider = context.read<MyProfileProvider>();
    FirebaseCrashlytics.instance.setUserIdentifier(profileProvider.current!.organizationEmail!);
    return [
      RouteDrawerItem(
        title: "Announcements",
        route: MyRouter.viewAnnouncements,
        trailing: Consumer<UnreadAnnouncementsProvider>(
          builder: (context, provider, _) {
            final data = provider.current ?? -1;
            if (data < 1) return const SizedBox.shrink();
            return Container(
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.all(4),
              child: ScaleDown(child: Text(data.toString(), style: Theme.of(context).textTheme.bodyText1)),
              constraints: const BoxConstraints(minWidth: 24, minHeight: 24, maxHeight: 24, maxWidth: 48),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            );
          },
        ),
        imageIconPath: ResourcesUtils.announcements,
      ),
      RouteDrawerItem(
        title: "Check In/Out",
        route: MyRouter.checkInOut,
        imageIconPath: ResourcesUtils.stopwatch,
      ),
      if (userProfile.useTenroxTasksFeature!)
        RouteDrawerItem(
          title: "My Tenrox Tasks",
          route: MyRouter.myTasks,
          imageIconPath: ResourcesUtils.tasks,
        ),
      RouteDrawerItem(
        title: "My Profile",
        route: MyRouter.myProfile,
        imageIconPath: ResourcesUtils.myProfile,
      ),
      if (!userProfile.isAdmin!)
        RouteDrawerItem(
          title: "My Company",
          imageIconPath: ResourcesUtils.myCompany,
          route: MyRouter.employeeDashboard,
        ),
      if (userProfile.isAdmin!)
        ExpansionDrawerItem(
          title: "My Company",
          imageIconPath: ResourcesUtils.myCompany,
          children: [
            RouteDrawerItem(
              secondary: true,
              title: "Company Information",
              route: MyRouter.adminDashboard,
            ),
            RouteDrawerItem(
              secondary: true,
              title: "Manage Shifts",
              route: MyRouter.manageShifts,
            ),
            RouteDrawerItem(
              secondary: true,
              title: "Manage Cycles",
              route: MyRouter.manageCycles,
            ),
            RouteDrawerItem(
              secondary: true,
              title: "All Employees",
              route: MyRouter.allEmployees,
            ),
            RouteDrawerItem(
              secondary: true,
              title: "Location Requests",
              route: MyRouter.adminLocationRequests,
            ),
            RouteDrawerItem(
              secondary: true,
              title: "Admins",
              route: MyRouter.adminsList,
            ),
            RouteDrawerItem(
              secondary: true,
              title: "Attendance Report",
              route: MyRouter.adminAttendanceReport,
            ),
            RouteDrawerItem(
              secondary: true,
              title: "Balance Report",
              route: MyRouter.adminBalanceReport,
            ),
            RouteDrawerItem(
              secondary: true,
              title: "Manage Announcements",
              route: MyRouter.manageAnnouncements,
            ),
          ],
        ),
      if (customerPortalUserInfo?.isInternalAdmin ?? false)
        RouteDrawerItem(
          title: "Partners Management",
          imageIconPath: ResourcesUtils.myCompany,
          route: MyRouter.partnersManagement,
        ),
      if (userProfile.isManager!)
        ExpansionDrawerItem(
          title: "My Team",
          imageIconPath: ResourcesUtils.myTeam,
          children: [
            RouteDrawerItem(
              secondary: true,
              title: "Team Members",
              route: MyRouter.teamMembers,
            ),
            RouteDrawerItem(
              secondary: true,
              title: "Location Requests",
              route: MyRouter.managerLocationRequests,
            ),
            RouteDrawerItem(
              secondary: true,
              title: "Attendance Report",
              route: MyRouter.managerAttendanceReport,
            ),
            RouteDrawerItem(
              secondary: true,
              title: "Balance Report",
              route: MyRouter.managerBalanceReport,
            ),
            RouteDrawerItem(
              secondary: true,
              title: "My Team Leaves",
              route: MyRouter.TeamStatus,
            ),
          ],
        ),
      RouteDrawerItem(
        title: "My Balance",
        route: MyRouter.myBalance,
        imageIconPath: ResourcesUtils.myBalance,
      ),
      RouteDrawerItem(
        title: "My Locations",
        route: MyRouter.myLocations,
        imageIconPath: ResourcesUtils.myLocations,
      ),
      RouteDrawerItem(
        title: "My Calendar",
        route: MyRouter.myCalendar,
        imageIconPath: ResourcesUtils.myCalendar,
      ),
      RouteDrawerItem(
        title: "Quick Leave Request",
        route: MyRouter.quickLeaveRequest,
        imageIconPath: ResourcesUtils.quickLeaveRequest,
      ),
      // if (userProfile.useTenroxTasksFeature == true)
      //   ExpansionDrawerItem(
      //     title: "Self Services",
      //     imageIconPath: ResourcesUtils.myServices,
      //     children: [
      //       ActionDrawerItem(
      //         title: "Submit Emergency Leave",
      //         secondary: true,
      //         action: () async {
      //           final confirm = await showConfirmationDialog(
      //             context: context,
      //             icon: Icons.event,
      //             title: "Annual Leave Request",
      //             actionText: "Are you sure you want to Submit \"Emergency Leave\" "
      //                 "today on ${date_utils.DateUtils.dateFormat.format(DateTime.now())}.",
      //           );
      //           if (confirm) {
      //             final response = await showFutureProgressDialog(
      //               context: context,
      //               initFuture: () => Repository().submitAnnualLeaveRequest(),
      //             );
      //             if (response?.status ?? false) {
      //               await showAdaptiveAlertDialog(
      //                 context: context,
      //                 content: const Text("You have successfully submitted Emergency Leave request today."),
      //               );
      //             } else {
      //               await showErrorDialog(context, response);
      //             }
      //           }
      //         },
      //       ),
      //     ],
      //   ),
      ActionDrawerItem(
        title: "Logout",
        action: () async {
          final confirm = await showConfirmationDialog(
            context: context,
            actionText: "Are you sure you want to logout ?",
            title: "Logout",
            icon: FontAwesomeIcons.signOutAlt,
          );
          if (confirm != true) return;
          final result = await showFutureProgressDialog<bool>(
            nullable: true,
            context: context,
            initFuture: () async {
              late bool isCheckedIn;
              String? selectedLocation;
              final response = await Repository().getMyCheckInOutHistoryToday();
              if (response.result!.isNotEmpty) {
                final historyDTO = response.result?.last;
                if (historyDTO != null) {
                  if (historyDTO.checkInOutDurations!.isNotEmpty) {
                    isCheckedIn = historyDTO.checkInOutDurations!.last.checkOutDTO == null;
                    if (isCheckedIn) {
                      selectedLocation = historyDTO.checkInOutDurations!.last.checkInDTO!.placeId;
                    }
                  } else {
                    isCheckedIn = false;
                  }
                }
              } else {
                isCheckedIn = false;
              }

              if (isCheckedIn) {
                final enabled = await Geolocator.isLocationServiceEnabled();
                if (!enabled) {
                  await showAdaptiveAlertDialog(
                    context: context,
                    content: Text("Location service is disabled."),
                  );
                  return false;
                }

               final Position? currentPosition = await Geolocator.getCurrentPosition();
                if (currentPosition == null) {
                  await showAdaptiveAlertDialog(
                    context: context,
                    content: Text("Couldn't get location data."),
                  );
                  return false;
                }

                final gpsLocation = GpsLocation(
                  latitude: currentPosition.latitude,
                  longitude: currentPosition.longitude,
                );

                final checkOutResponse = await Repository().checkOutNew(gpsLocation, selectedLocation);
                if (checkOutResponse == null || !checkOutResponse.status) {
                  await showErrorDialog(context, checkOutResponse);
                  return false;
                }
              }

              return true;
            },
          );
          if (result ?? false) {
            final response = await showFutureProgressDialog<BoolResponse>(
              context: context,
              initFuture: () => Repository().deleteMyFCMToken(),
            );
            if (response?.status != true) {
              await showErrorDialog(context, response);
              return;
            }

            Navigation.logout();
          }
        },
        imageIconPath: ResourcesUtils.signOut,
      ),
    ];
  }

  Widget _zoomAndSlideContent(BuildContext context, Widget content) {
    double? slidePercent, scalePercent;

    switch (Provider.of<MenuController>(context, listen: true).state) {
      case MenuState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.open:
        WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.opening:
        slidePercent = _slideOutCurve.transform(Provider.of<MenuController>(context, listen: true).percentOpen);
        scalePercent = _scaleDownCurve.transform(Provider.of<MenuController>(context, listen: true).percentOpen);
        break;
      case MenuState.closing:
        slidePercent = _slideInCurve.transform(Provider.of<MenuController>(context, listen: true).percentOpen);
        scalePercent = _scaleUpCurve.transform(Provider.of<MenuController>(context, listen: true).percentOpen);
        break;
    }

    final slideAmount = 276.0 * slidePercent;
    final contentScale = 1.0 - (0.2 * scalePercent);
    final cornerRadius = 16.0 * Provider.of<MenuController>(context, listen: true).percentOpen;

    return Transform(
      transform: Matrix4.translationValues(slideAmount, 0.0, 0.0)..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: const Offset(0.0, 5.0),
              blurRadius: 15.0,
              spreadRadius: 10.0,
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(cornerRadius),
              child: content,
            ),
            if (slidePercent == 1.0)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    if (slidePercent == 1.0) {
                      Future(() => Provider.of<MenuController>(context, listen: false).toggle());
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return _zoomAndSlideContent(
      context,
      GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 6.0) {
            Provider.of<MenuController>(context, listen: false).open();
          } else if (details.delta.dx < -6.0) {
            Provider.of<MenuController>(context, listen: false).close();
          }
        },
        child: Builder(builder: widget.builder!),
      ),
    );
  }
}

class _DrawerScaffoldMenuController extends StatefulWidget {
  final DrawerScaffoldBuilder? builder;

  _DrawerScaffoldMenuController({
    this.builder,
  });

  @override
  _DrawerScaffoldMenuControllerState createState() => _DrawerScaffoldMenuControllerState();
}

class _DrawerScaffoldMenuControllerState extends State<_DrawerScaffoldMenuController> {
  @override
  Widget build(BuildContext context) {
    return widget.builder!(context, Provider.of<MenuController>(context, listen: true));
  }
}

typedef DrawerScaffoldBuilder = Widget Function(BuildContext context, MenuController menuController);


class MenuController extends ChangeNotifier {
  final TickerProvider vsync;
  final AnimationController _animationController;
  MenuState state = MenuState.closed;

  MenuController({
    required this.vsync,
  }) : _animationController = AnimationController(vsync: vsync) {
    _animationController
      ..duration = const Duration(milliseconds: 250)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.forward:
            state = MenuState.opening;
            break;
          case AnimationStatus.reverse:
            state = MenuState.closing;
            break;
          case AnimationStatus.completed:
            state = MenuState.open;
            break;
          case AnimationStatus.dismissed:
            state = MenuState.closed;
            break;
        }
        notifyListeners();
      });
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double get percentOpen {
    return _animationController.value;
  }

  void open() {
    _animationController.forward();
  }

  void close() {
    _animationController.reverse();
  }

  void toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }
}

enum MenuState {
  closed,
  opening,
  open,
  closing,
}

class _DrawerItemWidget extends StatelessWidget {
  final DrawerItem item;

  _DrawerItemWidget({required this.item}) : assert(item != null);

  @override
  Widget build(BuildContext context) {
    final item = this.item;
    if (item is ExpansionDrawerItem) return _ExpansionItemWidget(item: item);
    final isCurrent = _isItemSelected(context, item);
    return Container(
      color: isCurrent ? Colors.white.withOpacity(0.2) : null,
      child: ListTile(
        dense: true,
        enabled: !isCurrent,
        title: Row(
          children: <Widget>[
            if (item.imageIconPath != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 20, start: 4),
                child: Image.asset(
                  item.imageIconPath!,
                  height: 20.0,
                  width: 20.0,
                  color: isCurrent ? _selectedNavigationItemColor : _nonSelectedNavigationItemColor,
                ),
              ),
            if (item.imageIconPath == null) const SizedBox(width: 44.0, height: 30.0),
            Expanded(
              child: ScaleDown(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  item.title!.toUpperCase(),
                  maxLines: 1,
                  style: TextStyle(
                      color: isCurrent ? _selectedNavigationItemColor : _nonSelectedNavigationItemColor,
                      fontWeight: item.secondary ? FontWeight.normal : FontWeight.bold,
                      fontSize: item.secondary ? 12 : 14),
                ),
              ),
            ),
          ],
        ),
        trailing: item.trailing,
        onTap: () {
          if (item is RouteDrawerItem) {
            if (isCurrent) return;
            Provider.of<MenuController>(context, listen: false).close();
            Navigator.of(context).pushNamedAndRemoveUntil(item.route, (_) => false);
          } else if (item is ActionDrawerItem) {
            Provider.of<MenuController>(context, listen: false).close();
            item.action();
          } else {
            throw Exception("Unknown DrawerItem");
          }
        },
      ),
    );
  }

  bool _isItemSelected(BuildContext context, DrawerItem item) {
    if (item is RouteDrawerItem) {
      return ModalRoute.of(context)!.settings.name == item.route;
    }
    return false;
  }
}

class _ExpansionItemWidget extends StatefulWidget {
  final ExpansionDrawerItem item;

  _ExpansionItemWidget({required this.item}) : assert(item != null);

  @override
  State<StatefulWidget> createState() => _ExpansionItemWidgetState();
}

class _ExpansionItemWidgetState extends State<_ExpansionItemWidget> {
  bool? _initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final currentRouteName = ModalRoute.of(context)?.settings?.name;
    _initiallyExpanded = _initiallyExpanded ??
        widget.item.children.indexWhere((e) => e is RouteDrawerItem ? e.route == currentRouteName : false) != -1;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        key: PageStorageKey(widget.item),
        initiallyExpanded: _initiallyExpanded!,
        trailing: Builder(
          builder: (context) {
            final isExpanded = tryCast<bool>(PageStorage.of(context)?.readState(context)) ?? _initiallyExpanded!;
            return Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.white);
          },
        ),
        onExpansionChanged: (v) => setState(() => _initiallyExpanded = v),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 20, start: 4),
              child: Image.asset(
                widget.item.imageIconPath!,
                height: 20.0,
                width: 20.0,
                color: _selectedNavigationItemColor,
              ),
            ),
            Expanded(
              child: ScaleDown(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  widget.item.title!.toUpperCase(),
                  maxLines: 1,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
            ),
          ],
        ),
        children: widget.item.children.map((e) => _DrawerItemWidget(item: e)).toList(),
      ),
    );
  }
}

const _selectedNavigationItemColor = Colors.white;
const _nonSelectedNavigationItemColor = Colors.white;
