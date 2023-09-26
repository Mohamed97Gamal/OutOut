// import 'dart:ui';
//
// import 'package:flairstechsuite_mobile/models/api/responses.dart';
// import 'package:flairstechsuite_mobile/providers/unread_announcements_provider.dart';
// import 'package:flairstechsuite_mobile/repo/repository.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/admin/admin_dashboard_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/admin/admin_manage_shifts_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/admin/all_employees_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/admin/location_requests_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/admin/manage_announcements_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/admin/view_admins_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/employee/check_inout_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/employee/employee_dashboard_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/employee/locations_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/employee/myemployee_profile_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/employee/tenrox_tasks_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/employee/view_announcements_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/manager/attendance_report_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/manager/team_location_requests_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/manager/team_members_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/superadmin/super_admin_dashboard_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/superadmin/super_admin_manage_organizations_page.dart';
// import 'package:flairstechsuite_mobile/screens/home/pages/superadmin/super_admin_manage_users_page.dart';
// import 'package:flairstechsuite_mobile/utils/date_utils.dart';
// import 'package:flairstechsuite_mobile/utils/navigation.dart';
// import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
// import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/cached_network_image.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/confirmation_dialog.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/zoom_scaffold.dart';
// import 'package:flairstechsuite_mobile/widgets/my_user_profile.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:provider/provider.dart';
//
// bool alwaysTrue() => true;
//
// Color selectedNavigationItemColor = Colors.white;
// Color nonSelectedNavigationItemColor = Colors.white;
//
// class NavigationItem extends StatelessWidget {
//   final ValueNotifier<NavigationItem> selectedNavigationItem;
//   final String title;
//   final String imageIconPath;
//   final Widget page;
//   final Function onTap;
//   final bool Function() show;
//   final bool secondary;
//   final Widget trailing;
//
//   NavigationItem({
//     @required this.selectedNavigationItem,
//     @required this.title,
//     this.imageIconPath,
//     this.show = alwaysTrue,
//     this.page,
//     this.trailing,
//     this.onTap,
//     this.secondary = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (!show()) return Container();
//     return ValueListenableBuilder(
//       valueListenable: selectedNavigationItem,
//       builder: (context, value, child) {
//         return Container(
//           width: 275,
//           color: selectedNavigationItem.value == this ? Colors.white.withOpacity(0.2) : null,
//           child: ListTile(
//             dense: true,
//             title: Row(
//               children: <Widget>[
//                 if (imageIconPath != null)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     child: Image.asset(
//                       imageIconPath,
//                       height: 20.0,
//                       width: 20.0,
//                       color: selectedNavigationItem.value == this
//                           ? selectedNavigationItemColor
//                           : nonSelectedNavigationItemColor,
//                     ),
//                   ),
//                 if (imageIconPath == null) const SizedBox(width: 40.0, height: 30.0),
//                 Text(
//                   title.toUpperCase(),
//                   style: TextStyle(
//                     color: selectedNavigationItem.value == this
//                         ? selectedNavigationItemColor
//                         : nonSelectedNavigationItemColor,
//                     fontWeight: secondary ? FontWeight.normal : FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             trailing: trailing,
//             onTap: () async {
//               if (onTap == null) {
//                 if (selectedNavigationItem.value != this) {
//                   Provider.of<menu.MenuController>(context, listen: false).toggle();
//                   selectedNavigationItem.value = this;
//                 }
//               } else {
//                 Provider.of<menu.MenuController>(context, listen: false).toggle();
//                 onTap();
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   MenuController menuController;
//   final ValueNotifier<NavigationItem> selectedNavigationItem = ValueNotifier(null);
//
//   @override
//   void initState() {
//     super.initState();
//     menuController = MenuController(
//       vsync: this,
//     )..addListener(() => setState(() {}));
//   }
//
//   @override
//   void dispose() {
//     menuController.dispose();
//     super.dispose();
//   }
//
//   List<Widget> pages;
//   List<NavigationItem> mainNavigationItemsList;
//   NavigationItem checkInOutPageNavigationItem;
//   NavigationItem tenroxTasksPageNavigationItem;
//   NavigationItem profileNavigationItem;
//   NavigationItem dashboardNavigationItem;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final userProfile = MyUserProfile.of(context);
//
//     checkInOutPageNavigationItem ??= NavigationItem(
//       selectedNavigationItem: selectedNavigationItem,
//       title: "Check In / Out",
//       page: CheckInOutPage(),
//       imageIconPath: ResourcesUtils.stopwatch,
//     );
//
//     tenroxTasksPageNavigationItem ??= NavigationItem(
//       selectedNavigationItem: selectedNavigationItem,
//       title: "My Tenrox Tasks",
//       page: TenroxTasksPage(),
//       imageIconPath: ResourcesUtils.tasks,
//     );
//
//     profileNavigationItem ??= NavigationItem(
//       selectedNavigationItem: selectedNavigationItem,
//       title: "My Profile",
//       page: MyEmployeeProfilePage(),
//       imageIconPath: ResourcesUtils.myProfile,
//     );
//
//     var dashboardNavigationItemName = "My Company";
//     if (userProfile.isSuperAdmin) {
//       dashboardNavigationItemName = "Dashboard";
//     } else if (userProfile.isAdmin) {
//       dashboardNavigationItemName = "Company Information";
//     }
//     dashboardNavigationItem ??= NavigationItem(
//       secondary: MyUserProfile.of(context).isAdmin,
//       selectedNavigationItem: selectedNavigationItem,
//       title: dashboardNavigationItemName,
//       page: dashboard,
//       imageIconPath: userProfile.isSuperAdmin || userProfile.isAdmin ? null : ResourcesUtils.myCompany,
//     );
//
//     mainNavigationItemsList ??= [
//       if (userProfile.isEmployee) checkInOutPageNavigationItem,
//       if (userProfile.isEmployee && userProfile.useTenroxTasksFeature) tenroxTasksPageNavigationItem,
//       profileNavigationItem,
//       dashboardNavigationItem,
//     ];
//
//     pages ??= [
//       if (userProfile.isEmployee)
//         NavigationItem(
//           selectedNavigationItem: selectedNavigationItem,
//           title: "Announcements",
//           page: ViewAnnouncementsPage(),
//           trailing: Consumer<UnreadAnnouncementsProvider>(
//             builder: (context, provider, _) {
//               final data = provider.current ?? -1;
//               if (data < 1)return SizedBox(.shrink();
//               return Container(
//                 clipBehavior: Clip.antiAlias,
//                 padding: const EdgeInsets.all(4),
//                 child: FittedBox(
//                   child: Text(data.toString(), style: Theme.of(context).textTheme.bodyText1),
//                   fit: BoxFit.scaleDown,
//                 ),
//                 constraints: const BoxConstraints(minWidth: 24, minHeight: 24, maxHeight: 24, maxWidth: 48),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.8),
//                   borderRadius: const BorderRadius.all(Radius.circular(12)),
//                 ),
//               );
//             },
//           ),
//           imageIconPath: ResourcesUtils.announcements,
//         ),
//       if (userProfile.isEmployee) checkInOutPageNavigationItem,
//       if (userProfile.isEmployee && userProfile.useTenroxTasksFeature) tenroxTasksPageNavigationItem,
//       if (userProfile.isEmployee) profileNavigationItem,
//       if (!userProfile.isAdmin) dashboardNavigationItem,
//       if (userProfile.isSuperAdmin)
//         NavigationExpansionTile(
//           imageIconPath: ResourcesUtils.appLogo,
//           selectedNavigationItem: selectedNavigationItem,
//           title: "Control Panel",
//           children: <Widget>[
//             NavigationItem(
//               secondary: true,
//               selectedNavigationItem: selectedNavigationItem,
//               title: "Manage Organizations",
//               page: SuperAdminManageOrganizationsPage(),
//             ),
//             NavigationItem(
//               secondary: true,
//               selectedNavigationItem: selectedNavigationItem,
//               title: "Manage Users",
//               page: SuperAdminManageUsersPage(),
//             ),
//           ],
//         ),
//       if (userProfile.isAdmin)
//         NavigationExpansionTile(
//           selectedNavigationItem: selectedNavigationItem,
//           title: "My Company",
//           imageIconPath: ResourcesUtils.myCompany,
//           children: <Widget>[
//             dashboardNavigationItem,
//             NavigationItem(
//               secondary: true,
//               selectedNavigationItem: selectedNavigationItem,
//               title: "Manage Shifts",
//               page: ManageShiftsPage(),
//             ),
//             NavigationItem(
//               secondary: true,
//               selectedNavigationItem: selectedNavigationItem,
//               title: "All Employees",
//               page: AllEmployeesPage(),
//             ),
//             NavigationItem(
//               secondary: true,
//               selectedNavigationItem: selectedNavigationItem,
//               title: "Location Requests",
//               page: LocationRequestsPage(),
//             ),
//             NavigationItem(
//               secondary: true,
//               selectedNavigationItem: selectedNavigationItem,
//               title: "Admins",
//               page: ViewAdminsPage(),
//             ),
//             NavigationItem(
//               secondary: true,
//               selectedNavigationItem: selectedNavigationItem,
//               title: "Attendance Report",
//               page: AttendanceReportPage(),
//             ),
//             NavigationItem(
//               secondary: true,
//               selectedNavigationItem: selectedNavigationItem,
//               title: "Manage Announcements",
//               page: ManageAnnouncementsPage(),
//             ),
//           ],
//         ),
//       if (userProfile.isManager)
//         NavigationExpansionTile(
//           selectedNavigationItem: selectedNavigationItem,
//           title: "My Team",
//           imageIconPath: ResourcesUtils.myTeam,
//           children: <Widget>[
//             NavigationItem(
//               secondary: true,
//               selectedNavigationItem: selectedNavigationItem,
//               title: "Team Members",
//               page: TeamMembersPage(),
//             ),
//             NavigationItem(
//               secondary: true,
//               selectedNavigationItem: selectedNavigationItem,
//               title: "Location Requests",
//               page: TeamLocationRequestsPage(),
//             ),
//             NavigationItem(
//               secondary: true,
//               selectedNavigationItem: selectedNavigationItem,
//               title: "Attendance Report",
//               page: AttendanceReportPage(),
//             ),
//           ],
//         ),
//       if (userProfile.isEmployee)
//         NavigationItem(
//           selectedNavigationItem: selectedNavigationItem,
//           title: "My Locations",
//           page: LocationsPage(),
//           imageIconPath: ResourcesUtils.myLocations,
//         ),
//       if (userProfile.useTenroxTasksFeature == true)
//         NavigationExpansionTile(
//           selectedNavigationItem: selectedNavigationItem,
//           title: "Self Services",
//           imageIconPath: ResourcesUtils.myServices,
//           children: [
//             NavigationItem(
//               selectedNavigationItem: selectedNavigationItem,
//               title: "Work From Home Request",
//               onTap: () async {
//                 final confirm = await showConfirmationDialog(
//                   context: context,
//                   icon: Icons.event,
//                   title: "Work From Home Request",
//                   actionText: "Are you sure you want to request \"Work From Home\" "
//                       "today on ${DateUtils.dateFormat.format(DateTime.now())}.",
//                 );
//                 if (confirm) {
//                   final response = await showFutureProgressDialog(
//                     context: context,
//                     initFuture: () => Repository().submitWFHRequest(),
//                   );
//                   if (response?.status ?? false) {
//                     await showAdaptiveAlertDialog(
//                       context: context,
//                       content: const Text("You have successfully submitted Work from home request today."),
//                     );
//                   } else {
//                     await showErrorDialog(context, response);
//                   }
//                 }
//               },
//             ),
//             NavigationItem(
//               selectedNavigationItem: selectedNavigationItem,
//               title: "Annual Leave Request",
//               onTap: () async {
//                 final confirm = await showConfirmationDialog(
//                   context: context,
//                   icon: Icons.event,
//                   title: "Annual Leave Request",
//                   actionText: "Are you sure you want to request \"Annual Leave\" "
//                       "today on ${DateUtils.dateFormat.format(DateTime.now())}.",
//                 );
//                 if (confirm) {
//                   final response = await showFutureProgressDialog(
//                     context: context,
//                     initFuture: () => Repository().submitAnnualLeaveRequest(),
//                   );
//                   if (response?.status ?? false) {
//                     await showAdaptiveAlertDialog(
//                       context: context,
//                       content: const Text("You have successfully submitted Annual Leave request today."),
//                     );
//                   } else {
//                     await showErrorDialog(context, response);
//                   }
//                 }
//               },
//             ),
        //     NavigationItem(
        //       selectedNavigationItem: selectedNavigationItem,
        //       title: "Sick Leave Request",
        //       onTap: () async {
        //         final confirm = await showConfirmationDialog(
        //           context: context,
        //           icon: Icons.event,
        //           title: "Sick Leave Request",
        //           actionText: "Are you sure you want to request \"Sick Leave\" "
        //               "today on ${DateUtils.dateFormat.format(DateTime.now())}.",
        //         );
        //         if (confirm) {
        //           final response = await showFutureProgressDialog(
        //             context: context,
        //             initFuture: () => Repository().submitSickLeaveRequest(),
        //           );
        //           if (response?.status ?? false) {
        //             await showAdaptiveAlertDialog(
        //               context: context,
        //               content: const Text("You have successfully submitted Sick Leave request today."),
        //             );
        //           } else {
        //             await showErrorDialog(context, response);
        //           }
        //         }
        //       },
        //     ),
        //   ],
        // ),
//       NavigationItem(
//         selectedNavigationItem: selectedNavigationItem,
//         title: "Logout",
//         onTap: () async {
//           final confirm = await showConfirmationDialog(
//             context: context,
//             actionText: "Are you sure you want to logout ?",
//             title: "Logout",
//             icon: FontAwesomeIcons.signOutAlt,
//           );
//           if (confirm) {
//             final result = await showFutureProgressDialog<bool>(
//               nullable: true,
//               context: context,
//               initFuture: () async {
//                 if (userProfile.isEmployee) {
//                   bool isCheckedIn;
//                   final response = await Repository().getMyCheckInOutHistoryToday();
//                   if (response.result.isNotEmpty) {
//                     final historyDTO = response.result.last;
//                     if (historyDTO != null) {
//                       if (historyDTO.checkInOutDurations.isNotEmpty) {
//                         isCheckedIn = historyDTO.checkInOutDurations.last.checkOutDTO == null;
//                       } else {
//                         isCheckedIn = false;
//                       }
//                     }
//                   } else {
//                     isCheckedIn = false;
//                   }
//
//                   if (isCheckedIn) {
//                     final enabled = await Geolocator().isLocationServiceEnabled();
//                     if (!enabled) {
//                       await showAdaptiveAlertDialog(
//                         context: context,
//                         content: Text("Location service is disabled."),
//                       );
//                       return false;
//                     }
//
//                     final currentPosition = await Geolocator().getCurrentPosition(
//                       desiredAccuracy: LocationAccuracy.bestForNavigation,
//                       locationPermissionLevel: GeolocationPermission.locationWhenInUse,
//                     );
//                     if (currentPosition == null) {
//                       await showAdaptiveAlertDialog(
//                         context: context,
//                         content: Text("Couldn't get location data."),
//                       );
//                       return false;
//                     }
//
//                     final gpsLocation = GpsLocation(
//                       latitude: currentPosition.latitude,
//                       longitude: currentPosition.longitude,
//                     );
//
//                     final checkOutResponse = await Repository().checkOut(gpsLocation);
//                     if (checkOutResponse == null || !checkOutResponse.status) {
//                       await showErrorDialog(context, checkOutResponse);
//                       return false;
//                     }
//                   }
//                 }
//                 return true;
//               },
//             );
//             if (result ?? false) {
//               final response = await showFutureProgressDialog<BoolResponse>(
//                 context: context,
//                 initFuture: () => Repository().logout(),
//               );
//               if (response?.status != true) {
//                 await showErrorDialog(context, response);
//                 return;
//               }
//               Navigation.logout();
//             }
//           }
//         },
//         imageIconPath: ResourcesUtils.signOut,
//       ),
//     ];
//     selectedNavigationItem.value ??= userProfile.isSuperAdmin ? dashboardNavigationItem : checkInOutPageNavigationItem;
//   }
//
//   static Widget get dashboard {
//     return UserSpecificDashboard();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final userProfile = MyUserProfile.of(context);
//     return WillPopScope(
//       onWillPop: () async {
//         if (selectedNavigationItem.value != checkInOutPageNavigationItem) {
//           selectedNavigationItem.value = checkInOutPageNavigationItem;
//           return false;
//         }
//         return true;
//       },
//       child: ChangeNotifierProvider.value(
//         value: menuController,
//         child: ValueListenableBuilder(
//           valueListenable: selectedNavigationItem,
//           builder: (context, value, child) {
//             return ZoomScaffold(
//               contentScreen: selectedNavigationItem.value.page,
//               menuScreen: Stack(
//                 children: <Widget>[
//                   Positioned.fill(
//                     child: Image.asset(
//                       ResourcesUtils.sandClockBg,
//                       fit: BoxFit.cover,
//                       filterQuality: FilterQuality.low,
//                     ),
//                   ),
//                   ListView(
//                     padding: const EdgeInsets.symmetric(vertical: 16.0),
//                     children: <Widget>[
//                       Builder(
//                         builder: (_context) {
//                           return DrawerHeader(
//                             child: DefaultTextStyle(
//                               style: TextStyle(color: Colors.white),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Row(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                                         child: AvatarNetworkImage(
//                                           userProfile.profileImage,
//                                           width: 60.0,
//                                           height: 60.0,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         width: 150,
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Text(
//                                               userProfile.fullName ?? "",
//                                               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//                                             ),
//                                             const SizedBox(height: 2),
//                                             Text(
//                                               userProfile.title ?? "",
//                                               style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 8.0),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       Material(
//                         color: Colors.transparent,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.max,
//                           children: pages,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               bottomNavigationBar: userProfile.isEmployee
//                   ? BottomNavigationBar(
//                       elevation: 8.0,
//                       currentIndex: mainNavigationItemsList.contains(selectedNavigationItem.value)
//                           ? mainNavigationItemsList.indexOf(selectedNavigationItem.value)
//                           : mainNavigationItemsList.length - 1,
//                       unselectedItemColor: Colors.white,
//                       showSelectedLabels: false,
//                       showUnselectedLabels: false,
//                       selectedItemColor: Theme.of(context).primaryColor,
//                       type: BottomNavigationBarType.fixed,
//                       onTap: (index) => selectedNavigationItem.value = mainNavigationItemsList[index],
//                       items: <BottomNavigationBarItem>[
//                         BottomNavigationBarItem(
//                           label: "Check In/Out",
//                           icon: Image.asset(
//                             ResourcesUtils.stopwatch,
//                             height: 25.0,
//                             color: Colors.black54,
//                           ),
//                           activeIcon: Image.asset(
//                             ResourcesUtils.stopwatchActive,
//                             height: 25.0,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                         if (userProfile.useTenroxTasksFeature)
//                           BottomNavigationBarItem(
//                             label: "Tenrox Tasks",
//                             icon: Image.asset(
//                               ResourcesUtils.tasks,
//                               height: 25.0,
//                               color: Colors.black54,
//                             ),
//                             activeIcon: Image.asset(
//                               ResourcesUtils.tasks,
//                               height: 25.0,
//                               color: Theme.of(context).primaryColor,
//                             ),
//                           ),
//                         BottomNavigationBarItem(
//                           label: "My Profile",
//                           icon: Image.asset(
//                             ResourcesUtils.myProfile,
//                             height: 25.0,
//                             color: Colors.black54,
//                           ),
//                           activeIcon: Image.asset(
//                             ResourcesUtils.myProfileActive,
//                             height: 25.0,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                         BottomNavigationBarItem(
//                           label: "My Company",
//                           icon: Image.asset(
//                             ResourcesUtils.myCompany,
//                             height: 25.0,
//                             color: Colors.black54,
//                           ),
//                           activeIcon: Image.asset(
//                             mainNavigationItemsList.contains(selectedNavigationItem.value)
//                                 ? ResourcesUtils.myCompanyActive
//                                 : ResourcesUtils.myCompany,
//                             height: 25.0,
//                             color: mainNavigationItemsList.contains(selectedNavigationItem.value)
//                                 ? Theme.of(context).primaryColor
//                                 : Colors.black54,
//                           ),
//                         ),
//                       ],
//                     )
//                   : null,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class NavigationExpansionTile extends StatelessWidget {
//   final String title;
//   final String imageIconPath;
//   final List<Widget> children;
//
//   NavigationExpansionTile({
//     Key key,
//     @required this.selectedNavigationItem,
//     @required this.title,
//     @required this.children,
//     this.imageIconPath,
//   }) : super(key: key);
//
//   final ValueNotifier<NavigationItem> selectedNavigationItem;
//
//   @override
//   Widget build(BuildContext context) {
//    return SizedBox(
//       width: 275.0,
//       child: ExpansionTile(
//         trailing: Icon(Icons.keyboard_arrow_down, color: Colors.white),
//         title: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               child: Image.asset(
//                 imageIconPath,
//                 height: 20.0,
//                 width: 20.0,
//                 color:
//                     selectedNavigationItem.value == this ? selectedNavigationItemColor : nonSelectedNavigationItemColor,
//               ),
//             ),
//             Text(
//               title.toUpperCase(),
//               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),
//             ),
//           ],
//         ),
//         children: children,
//       ),
//     );
//   }
// }
//
// class UserSpecificDashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final userProfile = MyUserProfile.of(context);
//     if (userProfile.isSuperAdmin) {
//       return SuperAdminDashboardPage();
//     } else if (userProfile.isAdmin) {
//       return AdminDashboardPage();
//     }
//     return EmployeeDashboardPage();
//   }
// }
