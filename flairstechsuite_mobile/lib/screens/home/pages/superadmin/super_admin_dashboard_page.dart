// import 'package:flairstechsuite_mobile/models/api/responses.dart';
// import 'package:flairstechsuite_mobile/repo/repository.dart';
// import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/circle_avatar_cached_image.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
// import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
// import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class SuperAdminDashboardPage extends StatelessWidget {
//   final RefreshNotifier refreshNotifier = RefreshNotifier();
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
//         title: const Text("Dashboard"),
//       ),
//       body: Refreshable(
//         refreshNotifier: refreshNotifier,
//         child: CustomFutureBuilder<OrganizationFullDTOListResponse>(
//           refreshIndicator: true,
//           initFuture: () => Repository().getFullOrganizationsDetails(),
//           onSuccess: (context, snapshot) {
//             return ListView.builder(
//               padding: const EdgeInsets.only(bottom: 70.0),
//               itemCount: snapshot.data.result.length,
//               itemBuilder: (context, index) {
//                 final organizationFullDTO = snapshot.data.result[index];
//                 return Card(
//                   margin: const EdgeInsets.all(16.0),
//                   elevation: 4.0,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
//                         color: Theme.of(context).accentColor,
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: <Widget>[
//                             CircleAvatarCachedImage(organizationFullDTO.logoPath, 20.0),
//                             const SizedBox(width: 24.0),
//                             Expanded(
//                               child: Text(
//                                 "${organizationFullDTO.name}",
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   fontSize: 17.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           mainAxisSize: MainAxisSize.max,
//                           children: <Widget>[
//                             Text("Admins: ${organizationFullDTO.adminsCount}"),
//                             Text("Employees: ${organizationFullDTO.employeesCount}"),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
