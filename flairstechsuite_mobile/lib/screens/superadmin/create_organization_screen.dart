// import 'dart:convert';
//
// import 'package:flairstechsuite_mobile/models/address_dto.dart';
// import 'package:flairstechsuite_mobile/models/api/responses.dart';
// import 'package:flairstechsuite_mobile/models/organization_dto.dart';
// import 'package:flairstechsuite_mobile/repo/repository.dart';
// import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
// import 'package:flairstechsuite_mobile/utils/validators/validators.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/edit_fields.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/title_text.dart';
// import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class CreateOrganizationScreen extends StatefulWidget {
//   @override
//   _CreateOrganizationScreenState createState() => _CreateOrganizationScreenState();
// }
//
// class _CreateOrganizationScreenState extends State<CreateOrganizationScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   Map<String, dynamic> organizationMap;
//
//   @override
//   void initState() {
//     super.initState();
//     organizationMap = OrganizationDTO.newEntry().toJson();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return NotificationScaffold(
//       appBar: AppBar(
//         title: const Text("New Organization"),
//       ),
//       body: _EditForm(organizationMap, _formKey),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () async {
//           if (!_formKey.currentState.validate()) {
//             return;
//           }
//           final organizationDTO = OrganizationDTO.fromJson(
//             json.decode(json.encode(organizationMap).toString()) as Map<String, dynamic>,
//           );
//           final response = await showFutureProgressDialog<OrganizationDTOResponse>(
//             context: context,
//             initFuture: () => Repository().createOrganization(organizationDTO),
//           );
//           if (response?.status ?? false) {
//             Navigator.of(context).pop(true);
//           } else {
//             showErrorDialog(context, response);
//           }
//         },
//         label: const Text("Save"),
//         icon: Icon(Icons.save),
//       ),
//     );
//   }
// }
//
// class _EditForm extends StatelessWidget {
//   final Map<String, dynamic> organizationMap;
//   final GlobalKey<FormState> _formKey;
//
//   const _EditForm(this.organizationMap, this._formKey);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.only(bottom: 78.0),
//       children: <Widget>[
//         Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               StringEditingField(
//                 organizationMap,
//                 "Name",
//                 "name",
//                 (s) => requiredFieldValidator(s),
//                 isRequired: true,
//               ),
//               StringEditingField(
//                 organizationMap,
//                 "Key",
//                 "key",
//                 (s) => requiredFieldValidator(s),
//                 isRequired: true,
//               ),
//               StringEditingField(
//                 organizationMap,
//                 "Business",
//                 "business",
//                 (s) => null,
//               ),
//               StringEditingField(
//                 organizationMap,
//                 "Website",
//                 "website",
//                 (s) => null,
//               ),
//               StringEditingField(
//                 organizationMap,
//                 "Contact Number",
//                 "contactNumber",
//                 (s) => null,
//               ),
//               const SizedBox(height: 8.0),
//               const TitleText("Addresses"),
//               const SizedBox(height: 8.0),
//               OrganizationAddressesEditField(organizationMap['addresses'] as List<AddressDTO>),
//               const SizedBox(height: 8.0),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class OrganizationAddressesEditField extends StatefulWidget {
//   final List<AddressDTO> addressDTOs;
//
//   const OrganizationAddressesEditField(this.addressDTOs);
//
//   @override
//   _OrganizationAddressesEditFieldState createState() => _OrganizationAddressesEditFieldState();
// }
//
// class _OrganizationAddressesEditFieldState extends State<OrganizationAddressesEditField> {
//   _OrganizationAddressesEditFieldState();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Column(
//           children: [
//             for (final addressDTO in widget.addressDTOs)
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Expanded(
//                       child: Text(
//                     addressDTO.description,
//                     textAlign: TextAlign.center,
//                   )),
//                   IconButton(
//                     icon: Icon(FontAwesomeIcons.solidTrashAlt),
//                     onPressed: () {
//                       setState(() {
//                         widget.addressDTOs.removeWhere((x) => x.description == addressDTO.description);
//                       });
//                     },
//                   )
//                 ],
//               ),
//           ],
//         ),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: ElevatedButton.icon(
//                   icon: Icon(Icons.add),
//                   onPressed: () async {
//                     final added = await showOrganizationAddressAddDialog(context);
//                     if (added != null) {
//                       setState(() {
//                         widget.addressDTOs.add(added);
//                       });
//                     }
//                   },
//                   label: const Text("Add"),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// Future<AddressDTO> showOrganizationAddressAddDialog(BuildContext context) async {
//   return showDialog<AddressDTO>(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) {
//       var addressDTO = AddressDTO();
//       return AlertDialog(
//         title: Row(
//           children: <Widget>[
//             Icon(Icons.add),
//             const SizedBox(width: 8.0),
//             Text(
//               "Add Address",
//               style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         content: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 4.0),
//           child: ListBody(
//             children: <Widget>[
//               TextField(
//                 decoration: const InputDecoration(labelText: "Name"),
//                 onChanged: (s) => addressDTO = addressDTO.copyWith(name: s),
//               ),
//               TextField(
//                 decoration: const InputDecoration(labelText: "Description"),
//                 onChanged: (s) => addressDTO = addressDTO.copyWith(description: s),
//               ),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           FlatButton(
//             onPressed: () {
//               Navigator.of(context).pop(addressDTO);
//             },
//             child: const Text("Ok"),
//           ),
//           FlatButton(
//             onPressed: () {
//               Navigator.of(context).pop(null);
//             },
//             child: const Text("Cancel"),
//           ),
//         ],
//       );
//     },
//   );
// }
