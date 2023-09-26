// import 'dart:math' as math;
// import 'package:flairstechsuite_mobile/models/api/responses.dart';
// import 'package:flairstechsuite_mobile/models/organization_full_dto.dart';
// import 'package:flairstechsuite_mobile/repo/repository.dart';
// import 'package:flairstechsuite_mobile/utils/hero_tag_helper.dart';
// import 'package:flairstechsuite_mobile/utils/navigation.dart';
// import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
// import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
// import 'package:flairstechsuite_mobile/views/splash_art.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/backdrop.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/circle_avatar_cached_image.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/confirmation_dialog.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
// import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
// import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class SuperAdminManageOrganizationsPage extends StatefulWidget {
//   @override
//   _SuperAdminManageOrganizationsPageState createState() => _SuperAdminManageOrganizationsPageState();
// }
//
// class _SuperAdminManageOrganizationsPageState extends State<SuperAdminManageOrganizationsPage>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
//   final RefreshNotifier refreshNotifier = RefreshNotifier();
//   AnimationController _controller;
//
//   int count = 0;
//   String searchQuery = "";
//   bool showInactive = true;
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 150),
//       value: 1.0,
//       vsync: this,
//     );
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   double get _backdropHeight {
//     final renderBox = _backdropKey.currentContext.findRenderObject() as RenderBox;
//     return renderBox.size.height;
//   }
//
//   bool get _backdropPanelVisible {
//     final status = _controller.status;
//     return status == AnimationStatus.completed || status == AnimationStatus.forward;
//   }
//
//   void _toggleBackdropPanelVisibility() {
//     setState(() {});
//     _controller.fling(velocity: _backdropPanelVisible ? -2.0 : 2.0);
//   }
//
//   void _handleDragUpdate(DragUpdateDetails details) {
//     if (_controller.isAnimating || _controller.status == AnimationStatus.completed) return;
//
//     _controller.value -= details.primaryDelta / (_backdropHeight ?? details.primaryDelta);
//   }
//
//   void _handleDragEnd(DragEndDetails details) {
//     if (_controller.isAnimating || _controller.status == AnimationStatus.completed) return;
//
//     final flingVelocity = details.velocity.pixelsPerSecond.dy / _backdropHeight;
//     if (flingVelocity < 0.0) {
//       _controller.fling(velocity: math.max(2.0, -flingVelocity));
//     } else if (flingVelocity > 0.0) {
//       _controller.fling(velocity: math.min(-2.0, -flingVelocity));
//     } else {
//       _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
//     }
//   }
//
//   Widget _buildBackDropStack({
//     BuildContext context,
//     BoxConstraints constraints,
//     Widget backDropChild,
//     Widget frontChild,
//     Widget frontChildTitle,
//   }) {
//     final panelSize = constraints.biggest;
//     const panelTop = 130.0;
//
//     final panelAnimation = _controller.drive(
//       RelativeRectTween(
//         begin: RelativeRect.fromLTRB(
//           0.0,
//           panelTop - MediaQuery.of(context).padding.bottom,
//           0.0,
//           panelTop - panelSize.height,
//         ),
//         end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
//       ),
//     );
//
//     final theme = Theme.of(context);
//
//     return Container(
//       key: _backdropKey,
//       color: theme.primaryColor,
//       child: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           ListTileTheme(
//             iconColor: theme.primaryIconTheme.color,
//             textColor: theme.primaryTextTheme.headline6.color.withOpacity(0.8),
//             selectedColor: theme.primaryTextTheme.headline6.color,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: backDropChild,
//             ),
//           ),
//           PositionedTransition(
//             rect: panelAnimation,
//             child: BackdropPanel(
//               onTap: _toggleBackdropPanelVisibility,
//               onVerticalDragUpdate: _handleDragUpdate,
//               onVerticalDragEnd: _handleDragEnd,
//               title: frontChildTitle,
//               child: frontChild,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return NotificationScaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         leading: IconButton(
//           icon: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Image.asset(ResourcesUtils.menu),
//           ),
//           onPressed: () => Provider.of<menu.MenuController>(context, listen: false).toggle(),
//         ),
//         centerTitle: true,
//         title: Text("Manage Organizations".toUpperCase()),
//         actions: <Widget>[
//           IconButton(
//             onPressed: _toggleBackdropPanelVisibility,
//             icon: AnimatedCrossFade(
//               firstChild: Icon(Icons.filter_list),
//               secondChild: Icon(Icons.close),
//               crossFadeState: _backdropPanelVisible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
//               duration: const Duration(milliseconds: 100),
//             ),
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return _buildBackDropStack(
//             context: context,
//             constraints: constraints,
//             backDropChild: ListView(
//               shrinkWrap: true,
//               children: <Widget>[
//                 TextFormField(
//                   textCapitalization: TextCapitalization.words,
//                   decoration: InputDecoration(
//                     border: UnderlineInputBorder(),
//                     filled: true,
//                     fillColor: Colors.black.withOpacity(0.7),
//                     prefixIcon: Icon(Icons.search, color: Colors.white),
//                     hintText: 'Search by name',
//                     hintStyle: TextStyle(color: Colors.white),
//                     labelStyle: TextStyle(color: Colors.white),
//                     labelText: 'Search',
//                   ),
//                   style: const TextStyle(color: Colors.white),
//                   onChanged: (s) => setState(() => searchQuery = s),
//                 ),
//                 Material(
//                   color: Colors.black.withOpacity(0.7),
//                   child: CheckboxListTile(
//                     controlAffinity: ListTileControlAffinity.leading,
//                     value: showInactive,
//                     onChanged: (b) => setState(() => showInactive = b),
//                     title: const Text("Show inactive organizations"),
//                   ),
//                 ),
//               ],
//             ),
//             frontChild: Stack(
//               fit: StackFit.expand,
//               children: <Widget>[
//                 Refreshable(
//                   refreshNotifier: refreshNotifier,
//                   child: CustomFutureBuilder<OrganizationFullDTOListResponse>(
//                     refreshIndicator: true,
//                     initFuture: () => Repository().getFullOrganizationsDetails(),
//                     onLoading: (context) {
//                       return LayoutBuilder(
//                         builder: (context, constraints) {
//                           return Padding(
//                             padding: EdgeInsets.only(bottom: constraints.maxHeight / 2),
//                             child: const SplashArt(),
//                           );
//                         },
//                       );
//                     },
//                     onSuccess: (context, snapshot) {
//                       final filteredList = snapshot.data.result.where((odto) {
//                         return _matchQuery(odto, searchQuery, showInactive);
//                       }).toList();
//                       Future(() => setState(() => count = filteredList.length));
//                       return ListView.builder(
//                         //separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
//                         padding: const EdgeInsets.only(bottom: 70.0),
//                         itemCount: filteredList.length,
//                         itemBuilder: (context, index) {
//                           final organizationFullDTO = filteredList[index];
//                           return OrganizationTile(organizationFullDTO);
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   right: 16,
//                   bottom: 16,
//                   child: FloatingActionButton.extended(
//                     onPressed: () async {
//                       final changed = await Navigation.navToCreateOrganization(context);
//                       if (changed) {
//                         refreshNotifier.refresh();
//                       }
//                     },
//                     icon: Icon(Icons.add),
//                     label: const Text("New Organization"),
//                   ),
//                 ),
//               ],
//             ),
//             frontChildTitle: Text("Organizations (Total: $count)"),
//           );
//         },
//       ),
//     );
//   }
// }
//
// bool _matchQuery(OrganizationFullDTO organizationFullDTO, String searchQuery, bool showInactive) {
//   if (searchQuery.isEmpty || organizationFullDTO.name.toLowerCase().contains(searchQuery.toLowerCase())) {
//     if (showInactive || organizationFullDTO.isActivated) {
//       return true;
//     }
//   }
//   return false;
// }
//
// class OrganizationTile extends StatelessWidget {
//   final OrganizationFullDTO organizationFullDTO;
//
//   const OrganizationTile(this.organizationFullDTO);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () {
//         Navigation.navToOrganizationProfile(context, organizationFullDTO);
//       },
//       leading: Hero(
//         tag: HeroTagHelper.organizationImage(organizationFullDTO.id),
//         child: CircleAvatarCachedImage(organizationFullDTO.logoPath, 20.0),
//       ),
//       title: Text("${organizationFullDTO.name}"),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {
//               Navigation.navToUpdateOrganization(context, organizationFullDTO);
//             },
//             tooltip: "Edit",
//           ),
//           const SizedBox(width: 8.0),
//           if (organizationFullDTO.isActivated)
//             IconButton(
//               icon: Icon(Icons.remove_circle_outline),
//               tooltip: "Deactivate",
//               onPressed: () async {
//                 final confirm = await showConfirmationDialog(
//                   context: context,
//                   title: "Deactivate ${organizationFullDTO.name}",
//                   actionText: "Are you sure you want to deactivate ${organizationFullDTO.name} ?",
//                   icon: Icons.remove_circle_outline,
//                 );
//                 if (confirm) {
//                   final response = await showFutureProgressDialog<BoolResponse>(
//                     context: context,
//                     initFuture: () => Repository().deactivateOrganization(organizationFullDTO.id),
//                   );
//                   if (response?.status ?? false) {
//                     showAdaptiveAlertDialog(
//                       context: context,
//                       content: Text("You successfully deactivated ${organizationFullDTO.name}"),
//                     );
//                     Refreshable.of(context).refresh();
//                   } else {
//                     showErrorDialog(context, response);
//                   }
//                 }
//               },
//             ),
//           if (!organizationFullDTO.isActivated)
//             IconButton(
//               icon: Icon(Icons.check_circle_outline),
//               tooltip: "Activate",
//               onPressed: () async {
//                 final confirm = await showConfirmationDialog(
//                   context: context,
//                   title: "Activate ${organizationFullDTO.name}",
//                   actionText: "Are you sure you want to activate ${organizationFullDTO.name} ?",
//                   icon: Icons.check_circle_outline,
//                 );
//                 if (confirm) {
//                   final response = await showFutureProgressDialog<BoolResponse>(
//                     context: context,
//                     initFuture: () => Repository().activateOrganization(organizationFullDTO.id),
//                   );
//                   if (response?.status ?? false) {
//                     showAdaptiveAlertDialog(
//                       context: context,
//                       content: Text("You successfully activated ${organizationFullDTO.name}"),
//                     );
//                     Refreshable.of(context).refresh();
//                   } else {
//                     showErrorDialog(context, response);
//                   }
//                 }
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }
