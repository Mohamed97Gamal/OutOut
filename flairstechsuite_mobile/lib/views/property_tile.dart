// class PropertyTile extends StatelessWidget {
//   final String propertyName, propertyValue;
//   final bool validator;
//
//   const PropertyTile({
//     @required this.propertyName,
//     @required this.propertyValue,
//     this.validator = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (validator && !nullOrEmpty(propertyValue) && propertyValue != "null") {
//       return Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               "$propertyName:",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(width: 8.0),
//             Expanded(
//               child: Text("$propertyValue", softWrap: true),
//             ),
//           ],
//         ),
//       );
//     }
//     return Container();
//   }
// }

// class LinkPropertyTile extends StatelessWidget {
//   final String propertyName, propertyValue;
//   final bool validator;
//
//   const LinkPropertyTile({
//     @required this.propertyName,
//     @required this.propertyValue,
//     this.validator = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (validator && !nullOrEmpty(propertyValue) && propertyValue != "null") {
//       return Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: Row(
//           children: <Widget>[
//             Text("$propertyName:", style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(width: 8.0),
//             InkWell(
//               onLongPress: () {
//                 Scaffold.of(context).showSnackBar(
//                   const SnackBar(content: Text("Link copied !")),
//                 );
//                 Clipboard.setData(ClipboardData(text: propertyValue));
//               },
//               onTap: () => launchURL(propertyValue),
//               child: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Text(
//                   "$propertyValue",
//                   style: TextStyle(color: Colors.blueAccent),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//     return Container();
//   }
// }

// class MobilePropertyTile extends StatelessWidget {
//   final String propertyName, propertyValue;
//   final bool validator;
//
//   const MobilePropertyTile({
//     @required this.propertyName,
//     @required this.propertyValue,
//     this.validator = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (validator && !nullOrEmpty(propertyValue) && propertyValue != "null") {
//       return Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: Row(
//           children: <Widget>[
//             Text("$propertyName:", style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(width: 8.0),
//             InkWell(
//               onTap: () {
//                 launchURL("tel://$propertyValue");
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Text(
//                   "$propertyValue",
//                   style: TextStyle(color: Colors.blueAccent),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//     return Container();
//   }
// }

// class EmailPropertyTile extends StatelessWidget {
//   final String propertyName, propertyValue;
//   final bool validator;
//
//   const EmailPropertyTile({
//     @required this.propertyName,
//     @required this.propertyValue,
//     this.validator = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (validator && !nullOrEmpty(propertyValue) && propertyValue != "null") {
//       return Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: Row(
//           children: <Widget>[
//             Text("$propertyName:", style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(width: 8.0),
//             InkWell(
//               onTap: () {
//                 launchURL("mailto:$propertyValue");
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Text(
//                   "$propertyValue",
//                   style: TextStyle(color: Colors.blueAccent),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//     return Container();
//   }
// }
