import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_appointment_response.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final ClientProfileAppointmentResponse clientProfileAppointmentResponse;

  AppointmentDetailsScreen({
    required this.clientProfileAppointmentResponse,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Touchpoint Details".toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomFutureBuilder(
            initFuture: () => Future.value(true),
            onSuccess: (context, snapshot) {
              return Column(
                children: [
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Partner: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(clientProfileAppointmentResponse.clientProfile!.fullName!),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Divider(),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Mood: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            radius: 12.0,
                            backgroundImage: AssetImage(clientProfileAppointmentResponse.mood!.asset),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Divider(),
                  SizedBox(height: 4.0),
                  if (clientProfileAppointmentResponse.scheduledDate != null)
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Touchpoint's date: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            DateFormat("dd MMMM yyyy").format(clientProfileAppointmentResponse.scheduledDate!.toLocal()),
                          ),
                        ),
                      ],
                    ),
                  if (clientProfileAppointmentResponse.scheduledDate != null) SizedBox(height: 4.0),
                  if (clientProfileAppointmentResponse.scheduledDate != null) Divider(),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Logged on: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          DateFormat("dd MMMM yyyy").format(clientProfileAppointmentResponse.loggedOnDate!.toLocal()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Divider(),
                  if (clientProfileAppointmentResponse.issues.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.0),
                        Text(
                          "Issues Raised: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        for (final issue in clientProfileAppointmentResponse.issues)
                          Column(
                            children: [
                              Text(
                                "•  " + issue.description!,
                              ),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        SizedBox(height: 4.0),
                        Divider(),
                      ],
                    ),
                  if (clientProfileAppointmentResponse.opportunities.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.0),
                        Text(
                          "Opportunities: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        for (final opportunity in clientProfileAppointmentResponse.opportunities)
                          Column(
                            children: [
                              Text(
                                "•  " + opportunity.description!,
                              ),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        SizedBox(height: 4.0),
                        Divider(),
                      ],
                    ),
                  if (clientProfileAppointmentResponse.notes?.isNotEmpty ?? false)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 4.0),
                        Text(
                          "Notes: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          clientProfileAppointmentResponse.notes!,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
