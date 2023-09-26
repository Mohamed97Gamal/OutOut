// import 'package:flairstechsuite_mobile/models/address_dto.dart';
// import 'package:flairstechsuite_mobile/models/organization_dto.dart';
// import 'package:flairstechsuite_mobile/utils/hero_tag_helper.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/circle_avatar_cached_image.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/title_text.dart';
// import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class OrganizationProfileScreen extends StatelessWidget {
//   final OrganizationDTO organizationDTO;
//
//   const OrganizationProfileScreen(this.organizationDTO);
//
//   @override
//   Widget build(BuildContext context) {
//     return NotificationScaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             expandedHeight: 200.0,
//             floating: false,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               centerTitle: true,
//               title: Text("${organizationDTO.name}"),
//               background: Center(
//                 child: Hero(
//                   tag: HeroTagHelper.organizationImage(organizationDTO.id),
//                   child: CircleAvatarCachedImage(
//                     organizationDTO.logoPath,
//                     60,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate(
//               <Widget>[
//                 ListTile(
//                   leading: Icon(Icons.person),
//                   title: Text("${organizationDTO.name}"),
//                   subtitle: const Text("Organization Name"),
//                 ),
//                 if (!nullOrEmpty(organizationDTO.business))
//                   ListTile(
//                     leading: Icon(Icons.business),
//                     title: Text("${organizationDTO.business}"),
//                     subtitle: const Text("Business"),
//                   ),
//                 if (!nullOrEmpty(organizationDTO.contactNumber))
//                   ListTile(
//                     leading: Icon(Icons.phone),
//                     title: Text("${organizationDTO.contactNumber}"),
//                     subtitle: const Text("Contact Number"),
//                     onTap: () => launch("tel://${organizationDTO.contactNumber}"),
//                   ),
//                 if (!nullOrEmpty(organizationDTO.website))
//                   ListTile(
//                     leading: Icon(Icons.link),
//                     title: Text("${organizationDTO.website}"),
//                     subtitle: const Text("Website"),
//                     onTap: () => launch("${organizationDTO.website}"),
//                   ),
//                 const TitleText("Addresses"),
//                 for (final AddressDTO addressDTO in organizationDTO.addresses)
//                   ListTile(
//                     leading: Icon(Icons.location_on),
//                     title: Text("${addressDTO.description}"),
//                     subtitle: nullOrEmpty(addressDTO.name) ? Text("${addressDTO.name}") : null,
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
