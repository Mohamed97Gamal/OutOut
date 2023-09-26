// import 'package:flairstechsuite_mobile/models/api/responses.dart';
// import 'package:flairstechsuite_mobile/models/organization_dto.dart';
// import 'package:flairstechsuite_mobile/repo/repository.dart';
// import 'package:flairstechsuite_mobile/utils/navigation.dart';
// import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
// import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/confirmation_dialog.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/custom_picker.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
// import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/title_text.dart';
// import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class SuperAdminManageUsersPage extends StatefulWidget {
//   @override
//   _SuperAdminManageUsersPageState createState() => _SuperAdminManageUsersPageState();
// }
//
// class _SuperAdminManageUsersPageState extends State<SuperAdminManageUsersPage> {
//   final RefreshNotifier refreshNotifier = RefreshNotifier();
//   OrganizationDTO _selectedOrganization;
//
//   @override
//   Widget build(BuildContext context) {
//     return NotificationScaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Image.asset(ResourcesUtils.menu),
//           ),
//           onPressed: () => Provider.of<menu.MenuController>(context, listen: false).toggle(),
//         ),
//         centerTitle: true,
//         title: Text("Manage Users".toUpperCase()),
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           ListView(
//             primary: true,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: CustomFutureBuilder<OrganizationFullDTOListResponse>(
//                   refreshIndicator: true,
//                   initFuture: () => Repository().getFullOrganizationsDetails(),
//                   onSuccess: (context, snapshot) {
//                     return AdaptivePicker<OrganizationDTO>(
//                       decorationLabelText: "Organization : ",
//                       items: <DropdownMenuItem<OrganizationDTO>>[
//                         const DropdownMenuItem<OrganizationDTO>(
//                           value: null,
//                           child: Text("All Organizations"),
//                         ),
//                         for (final org in snapshot.data.result)
//                           DropdownMenuItem<OrganizationDTO>(
//                             value: org,
//                             child: Text("${org.name}"),
//                           ),
//                       ],
//                       onChanged: (organization) {
//                         setState(() {
//                           _selectedOrganization = organization;
//                         });
//                         refreshNotifier.refresh();
//                       },
//                       value: _selectedOrganization,
//                     );
//                   },
//                 ),
//               ),
//               const Divider(),
//               const SizedBox(height: 8.0),
//               const TitleText("Admins List"),
//               const SizedBox(height: 8.0),
//               Refreshable(
//                 refreshNotifier: refreshNotifier,
//                 child: CustomFutureBuilder<AdminsListDTOResponse>(
//                   initFuture: () async => Repository().getAdminsList(_selectedOrganization?.id),
//                   onSuccess: (context, snapshot) {
//                     if (snapshot.data.result.isEmpty) {
//                       return const Center(
//                         child: Text("No Admins found !"),
//                       );
//                     }
//                     return ListView.separated(
//                       primary: false,
//                       shrinkWrap: true,
//                       separatorBuilder: (context, index) => const Divider(height: 1),
//                       padding: const EdgeInsets.only(bottom: 70.0),
//                       itemCount: snapshot.data.result.length,
//                       itemBuilder: (context, index) {
//                         final applicationUserDTO = snapshot.data.result[index];
//                         return AdminTile(applicationUserDTO);
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             right: 16,
//             bottom: 16,
//             child: FloatingActionButton.extended(
//               onPressed: () async {
//                 final changed = await Navigation.navToCreateAdmin(context, _selectedOrganization);
//                 if (changed) {
//                   refreshNotifier.refresh();
//                 }
//               },
//               icon: Icon(Icons.add),
//               label: const Text("New Admin"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class AdminTile extends StatelessWidget {
//   final AdminDTO adminDTO;
//
//   const AdminTile(this.adminDTO);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text("${adminDTO.admin.fullName}"),
//       subtitle: Text("${adminDTO.organizationName}"),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           IconButton(
//             icon: Icon(Icons.remove_circle_outline),
//             tooltip: "Delete Admin",
//             onPressed: () async {
//               final confirm = await showConfirmationDialog(
//                 context: context,
//                 title: "Delete Admin from ${adminDTO.admin.fullName}",
//                 actionText: "Are you sure you want to delete admin from ${adminDTO.admin.fullName} ?",
//                 icon: Icons.remove_circle_outline,
//               );
//               if (confirm) {
//                 final response = await showFutureProgressDialog<BoolResponse>(
//                   context: context,
//                   initFuture: () => Repository().deleteAdmin(adminDTO.organizationId, adminDTO.admin.applicationUserId),
//                 );
//                 if (response?.status ?? false) {
//                   showAdaptiveAlertDialog(
//                     context: context,
//                     content: Text("You successfully delete admin from ${adminDTO.admin.fullName}"),
//                   );
//                   Refreshable.of(context).refresh();
//                 } else {
//                   showErrorDialog(context, response);
//                 }
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
