import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_appointment_response.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/my_appointments_history_summary_response_operation_result.dart';
import 'package:flairstechsuite_mobile/repo/api/customer_portal/customer_portal_api_repo.dart';
import 'package:flairstechsuite_mobile/screens/common/fields/custom_date_range_form_field.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/loading/custom_paged_sliver_list_view.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentHistoryScreen extends StatefulWidget {
  final String? clientProfileId;

  AppointmentHistoryScreen({
    required this.clientProfileId,
  });

  @override
  State<AppointmentHistoryScreen> createState() => _AppointmentHistoryScreenState();
}

class _AppointmentHistoryScreenState extends State<AppointmentHistoryScreen> {
  final _refreshableKey = GlobalKey<RefreshableState>();
  DateTimeRange selectedRange = DateTimeRange(
    start: DateTime.now().add(Duration(days: -30 * 3)),
    end: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  );

  @override
  Widget build(BuildContext context) {
    return NotificationScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("History of touchpoints".toUpperCase()),
        bottom: PreferredSize(
            child: Container(
              padding: EdgeInsets.only(bottom: 10, right: 16.0, left: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: CustomDateRangeFormField(
                    textAlign: TextAlign.center,
                    name: "date",
                    labelText: "",
                    initialValue: selectedRange,
                    onChanged: (dateRange) {
                      setState(() {
                        selectedRange = dateRange!;
                      });
                      _refreshableKey.currentState!.refresh();
                    },
                    hintText: "Date",
                    firstDate: DateTime(1999, 1, 1),
                    lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                  ),
                ),
              ),
            ),
            preferredSize: const Size.fromHeight(48 + 4.0 + 12)),
      ),
      body: Refreshable(
        key: _refreshableKey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomFutureBuilder<MyAppointmentsHistorySummaryResponseOperationResult>(
                initFuture: () =>
                    CustomerPortalApiRepo().clientProfileAppointmentClient.getMyAppointmentsHistorySummary(
                          clientProfileId: widget.clientProfileId,
                          from: selectedRange.start,
                          to: selectedRange.end.add(Duration(days: 1, seconds: -1)).toUtc(),
                        ),
                onSuccess: (context, snapshot) {
                  final summary = snapshot.data!.result!;
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 90.0,
                        padding: EdgeInsets.all(16.0),
                        child: Card(
                          elevation: 0.0,
                          color: Color(0xFFF2F2F2),
                          child: Center(
                            child: Text(
                              summary.clientProfile?.fullName ?? "N/A",
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 120.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Positioned(
                                    bottom: 5,
                                    right: 10,
                                    child: Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: AssetImage(ResourcesUtils.issuesRaised),
                                          alignment: Alignment.centerRight,
                                        ),
                                      ),
                                    ),
                                  ),
                                  AspectRatio(
                                    aspectRatio: 1.1,
                                    child: Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: MyColors.grayColor),
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                      ),
                                      child: IntrinsicWidth(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 16.0),
                                                    child: Text(
                                                      "Issues Raised",
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Text(
                                                    summary.totalIssues.toString(),
                                                    style: TextStyle(
                                                      fontSize: 40.0,
                                                    ),
                                                  ),
                                                  SizedBox(height: 18.0),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 11.0,
                                              color: Color(0xFFFF0000),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20.0),
                              Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    right: 2,
                                    child: Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: AssetImage(ResourcesUtils.opportunities),
                                          alignment: Alignment.centerRight,
                                        ),
                                      ),
                                    ),
                                  ),
                                  AspectRatio(
                                    aspectRatio: 1.1,
                                    child: Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: MyColors.grayColor),
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                      ),
                                      child: IntrinsicWidth(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 16.0),
                                                    child: Text(
                                                      "Opportunities",
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Text(
                                                    summary.totalOpportunities.toString(),
                                                    style: TextStyle(
                                                      fontSize: 40.0,
                                                    ),
                                                  ),
                                                  SizedBox(height: 18.0),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 11.0,
                                              color: Color(0xFF19A500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                    child: Text(
                      "Feedbacks:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            CustomPagedSliverListView<ClientProfileAppointmentResponse>(
              initPageFuture: (i) async {
                final r = await CustomerPortalApiRepo().clientProfileAppointmentClient.getMyAppointmentsHistory(
                      pageIndex: i,
                      pageSize: 10,
                      clientProfileId: widget.clientProfileId,
                      from: selectedRange.start,
                      to: selectedRange.end.add(Duration(days: 1, seconds: -1)).toUtc(),
                    );
                return r.result!.toPagedList();
              },
              emptyBuilder: (context) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Image.asset(ResourcesUtils.noResult),
                        ),
                        Text(
                          "You don’t have any touchpoints done with this partner within the duration specified.",
                          style: TextStyle(color: Color(0xFF909090)),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemBuilder: (context, item, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        DateFormat("dd MMMM yyyy").format((item.loggedOnDate ?? item.scheduledDate)!.toLocal()),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: item.loggedOnDate == null ? Colors.red : null,
                        ),
                      ),
                      subtitle: item.issues?.isEmpty ?? true ? null : Text("${item.issues.length} Issues"),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                item.mood?.asset ?? ResourcesUtils.faceNone,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text(
                            item.loggedOnDate == null ? "Missed call" : "Done",
                            style: TextStyle(
                              color: item.loggedOnDate == null ? Colors.red : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      onTap: item.loggedOnDate == null
                          ? null
                          : () {
                              Navigation.navToAppointmentDetails(context, clientProfileAppointmentResponse: item);
                            },
                    ),
                    Divider(height: 3.0),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
