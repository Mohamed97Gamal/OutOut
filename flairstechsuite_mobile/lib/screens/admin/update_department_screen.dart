// import 'dart:convert';
//
// import 'package:flairstechsuite_mobile/models/api/responses.dart';
// import 'package:flairstechsuite_mobile/repo/repository.dart';
// import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
// import 'package:flairstechsuite_mobile/utils/validators/validators.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/edit_fields.dart';
// import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
// import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
// import 'package:flutter/material.dart';
//
// class UpdateDepartmentScreen extends StatefulWidget {
//   final DepartmentDTO departmentDTO;
//
//   const UpdateDepartmentScreen(this.departmentDTO);
//
//   @override
//   _UpdateDepartmentScreenState createState() => _UpdateDepartmentScreenState();
// }
//
// class _UpdateDepartmentScreenState extends State<UpdateDepartmentScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   Map<String, dynamic> departmentMap;
//
//   @override
//   void initState() {
//     super.initState();
//     final updateDepartmentViewModel = UpdateDepartmentViewModel(
//       id: widget.departmentDTO.id,
//       name: widget.departmentDTO.name,
//     );
//     departmentMap = updateDepartmentViewModel.toJson();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return NotificationScaffold(
//       appBar: AppBar(
//         title: Text("Edit Department - ${widget.departmentDTO.name}"),
//       ),
//       body: ListView(
//         children: <Widget>[
//           _EditForm(departmentMap, _formKey),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () async {
//           if (!_formKey.currentState.validate()) {
//             return;
//           }
//           final updateDepartmentViewModel = UpdateDepartmentViewModel.fromJson(
//             json.decode(json.encode(departmentMap).toString()) as Map<String, dynamic>,
//           );
//           final response = await showFutureProgressDialog<DepartmentDTOResponse>(
//             context: context,
//             initFuture: () => Repository().updateDepartment(updateDepartmentViewModel),
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
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: <Widget>[
//           StringEditingField(
//             organizationMap,
//             "Name",
//             "name",
//             (s) => requiredFieldValidator(s),
//             isRequired: true,
//           ),
//         ],
//       ),
//     );
//   }
// }
