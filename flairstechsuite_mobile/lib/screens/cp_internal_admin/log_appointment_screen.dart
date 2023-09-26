import 'dart:async';

import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_appointment_response_operation_result.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_mood.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/my_partner_response_operation_result.dart';
import 'package:flairstechsuite_mobile/repo/api/customer_portal/customer_portal_api_repo.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/edit_fields.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class LogAppointmentScreen extends StatefulWidget {
  final String? clientProfileId, clientProfileAppointmentId;
  final DateTime? scheduledDate;

  LogAppointmentScreen.scheduled({
    required this.clientProfileId,
    required this.clientProfileAppointmentId,
    required this.scheduledDate,
  }) : super();

  LogAppointmentScreen.unscheduled({
    required this.clientProfileId,
  })  : clientProfileAppointmentId = null,
        scheduledDate = null,
        super();

  @override
  _LogAppointmentScreenState createState() => _LogAppointmentScreenState();
}

class _LogAppointmentScreenState extends State<LogAppointmentScreen> {
  ClientProfileMood? selectedMood;
  String? selectedMoodError;
  final List<TextEditingController> newIssueControllers = [TextEditingController()];
  final List<TextEditingController> newOpportunityControllers = [TextEditingController()];
  final TextEditingController notesController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return NotificationScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Log Touchpoint".toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomFutureBuilder(
            initFuture: () => Future.value(true),
            onSuccess: (context, snapshot) {
              return Column(
                children: [
                  Card(
                    elevation: 0.0,
                    color: Color(0xFFF2F2F2),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      child: CustomFutureBuilder<MyPartnerResponseOperationResult>(
                        initFuture: () => CustomerPortalApiRepo()
                            .clientProfileAppointmentClient
                            .getMyPartnerById(id: widget.clientProfileId),
                        onSuccess: (context, snapshot) {
                          final partnerResponse = snapshot.data!.result!;
                          return Column(
                            children: [
                              Center(
                                child: Text(
                                  partnerResponse.fullName ?? "N/A",
                                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                              if (partnerResponse.lastAppointment != null) SizedBox(height: 8.0),
                              if (partnerResponse.lastAppointment != null)
                                Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Mood: ",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Image.asset(
                                            partnerResponse.lastAppointment!.mood?.asset ?? ResourcesUtils.faceNone,
                                            fit: BoxFit.contain,
                                            width: 24.0,
                                            height: 24.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (partnerResponse.lastAppointment != null &&
                                  partnerResponse.lastAppointment!.scheduledDate != null)
                                Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Scheduled: ",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          DateFormat("dd MMMM yyyy")
                                              .format(partnerResponse.lastAppointment!.scheduledDate!.toLocal()),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (partnerResponse.lastAppointment != null &&
                                  partnerResponse.lastAppointment!.loggedOnDate != null)
                                Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Logged on: ",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          DateFormat("dd MMMM yyyy")
                                              .format(partnerResponse.lastAppointment!.loggedOnDate!.toLocal()),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        "Touchpoint's Date: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: DateTimePicker(
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2050),
                            selectedDate: widget.scheduledDate?.toLocal() ?? DateTime.now(),
                            selectDate: null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  InputDecorator(
                    child: Row(
                      children: [
                        Text(
                          "Call's Mood: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50.0,
                            child: Row(
                              children: [
                                for (final value in ClientProfileMood.availableOptions)
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 60.0,
                                        height: 60.0,
                                        child: Card(
                                          elevation: 0.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                            side: BorderSide(
                                              width: 1.0,
                                              color: selectedMood == value ? Color(0xFF707070) : Color(0xFFE2E2E2),
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                selectedMood = value;
                                              });
                                            },
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  value.asset,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      errorText: selectedMood == null ? selectedMoodError : null,
                    ),
                  ),
                  Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Issues Raised: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      for (final newIssueController in newIssueControllers)
                        TextFormField(
                          controller: newIssueController,
                          decoration: InputDecoration(
                            hintText: "Write your text here...",
                            hintStyle: TextStyle(color: Colors.grey),
                            counterStyle: TextStyle(color: Colors.grey),
                          ),
                          minLines: 1,
                          maxLines: 10,
                          maxLength: 500,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FloatingActionButton(
                          mini: true,
                          heroTag: null,
                          backgroundColor: Color(0xFF73BFC7),
                          onPressed: () {
                            setState(() {
                              var c = TextEditingController();
                              newIssueControllers.add(c);
                            });
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Opportunities: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      for (final newOpportunityController in newOpportunityControllers)
                        TextFormField(
                          controller: newOpportunityController,
                          decoration: InputDecoration(
                            hintText: "Write your text here...",
                              hintStyle: TextStyle(color: Colors.grey),
                            counterStyle: TextStyle(color: Colors.grey),
                          ),
                          minLines: 1,
                          maxLines: 10,
                          maxLength: 500,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FloatingActionButton(
                          mini: true,
                          heroTag: null,
                          backgroundColor: Color(0xFF73BFC7),
                          onPressed: () {
                            setState(() {
                              final c = TextEditingController();
                              newOpportunityControllers.add(c);
                            });
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notes: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: notesController,
                        decoration: InputDecoration(
                          hintText: "Write your text here...",
                            hintStyle: TextStyle(color: Colors.grey)
                        ),
                        minLines: 1,
                        maxLines: 10,
                        maxLength: 500,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          color: Color(0xFF363636),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Cancel".toUpperCase()),
                          onPressed: () async {},
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: MaterialButton(
                          color: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Save".toUpperCase()),
                          onPressed: () async {
                            if (selectedMood == null) {
                              setState(() {
                                selectedMoodError = "Required field";
                              });
                              return;
                            }
                            selectedMoodError = null;

                            final issuesRaised =
                                newIssueControllers.map((e) => e.text).where((e) => e?.isNotEmpty ?? false).toList();
                            final opportunities = newOpportunityControllers
                                .map((e) => e.text)
                                .where((e) => e?.isNotEmpty ?? false)
                                .toList();

                            final result = await (showFutureProgressDialog(
                              context: context,
                              initFuture: () => CustomerPortalApiRepo().clientProfileAppointmentClient.logAppointment(
                                    clientProfileId: widget.clientProfileId,
                                    clientProfileAppointmentId: widget.clientProfileAppointmentId,
                                    mood: selectedMood!,
                                    issues: issuesRaised,
                                    opportunities: opportunities,
                                    notes: notesController.text,
                                  ),
                            ));
                            if (result!.status!=null && result.status! && result.result != null) {
                              await showAdaptiveAlertDialog(
                                context: context,
                                content: Text("Touchpoint logged successfully"),
                              );
                              Navigator.of(context).pop(true);
                            } else {
                              await showErrorDialog(context, result);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
