import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_appointment_response.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/my_partner_response.dart';
import 'package:flairstechsuite_mobile/repo/api/customer_portal/customer_portal_api_repo.dart';
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
import 'package:flairstechsuite_mobile/widgets/loading/custom_paged_list_view.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class PartnersManagementPage extends StatelessWidget {
  final _refreshableKey = GlobalKey<RefreshableState>();

  @override
  Widget build(BuildContext context) {
    return menu.DrawerScaffold(
      builder: (context) {
        return DefaultTabController(
          length: 2,
          child: NotificationScaffold(
            bottomNavigationBar: const MyBottomNavigationBar(),
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(ResourcesUtils.menu),
                ),
                onPressed: () {
                  return Provider.of<menu.MenuController>(context, listen: false).toggle();
                },
              ),
              title: Text("Partners Management".toUpperCase()),
              bottom: TabBar(
                tabs: [
                  Tab(text: "My Partners".toUpperCase()),
                  Tab(text: "This Week".toUpperCase()),
                ],
              ),
            ),
            body: Refreshable(
              key: _refreshableKey,
              child: RefreshIndicator(
                onRefresh: () async => _refreshableKey.currentState!.refresh(),
                child: TabBarView(
                  children: [
                    MyPartnersPage(refreshableKey: _refreshableKey),
                    ThisWeekPage(refreshableKey: _refreshableKey),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyPartnersPage extends StatelessWidget {
  const MyPartnersPage({
    Key? key,
    required GlobalKey<RefreshableState> refreshableKey,
  })  : _refreshableKey = refreshableKey,
        super(key: key);

  final GlobalKey<RefreshableState> _refreshableKey;

  @override
  Widget build(BuildContext context) {
    return CustomPagedListView<MyPartnerResponse>(
      padding: EdgeInsets.all(10.0),
      initPageFuture: (pageIndex) async {
        final res = await CustomerPortalApiRepo().clientProfileAppointmentClient.getMyPartners(
              pageIndex: pageIndex,
              pageSize: 10,
            );
        return res.result!.toPagedList();
      },
      emptyBuilder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Image.asset(ResourcesUtils.noResult),
                ),
                Text(
                  "You don’t have any assigned partners/Accounts yet.",
                  style: TextStyle(color: Color(0xFF909090)),
                ),
              ],
            ),
          ),
        );
      },
      itemBuilder: (context, item, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 2.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              side: BorderSide(color: Colors.grey, width: 0.7),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.fullName!,
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Color(0xff131315),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          if (item.lastAppointment != null)
                            CircleAvatar(
                              backgroundImage: AssetImage(item.lastAppointment!.mood?.asset ?? ResourcesUtils.faceNone),
                              radius: 12.0,
                              backgroundColor: Colors.transparent,
                            ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      if (item.lastAppointment == null && item.nextAppointment == null) SizedBox(height: 8.0),
                      Row(
                        children: [
                          if (item.lastAppointment != null)
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "Last call",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    DateFormat("dd MMM").format(
                                      (item.lastAppointment!.loggedOnDate?.toLocal() ??
                                          item.lastAppointment!.scheduledDate?.toLocal())!,
                                    ),
                                    style: TextStyle(color: Color(0xFF4E4E4E)),
                                  ),
                                ],
                              ),
                            ),
                          if (item.nextAppointment != null)
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Next call",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    DateFormat("dd MMM").format(item.nextAppointment!.scheduledDate!.toLocal()),
                                    style: TextStyle(color: Color(0xFF4E4E4E)),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      if (item.lastAppointment != null || item.nextAppointment != null) SizedBox(height: 12.0),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(12.0)),
                          color: Color(0xFFFCCD2F),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(12.0)),
                          onTap: () => Navigation.navToAppointmentHistory(context, clientProfileId: item.id),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(Icons.history, color: Colors.white),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      "Touchpoints History",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 24.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0)),
                          color: Color(0xFF73BFC7),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0)),
                          onTap: () async {
                            final change = await Navigation.navToLogUnscheduledAppointment(
                              context,
                              clientProfileId: item.id,
                            );
                            if (change) {
                              _refreshableKey.currentState!.refresh();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(Icons.call, color: Colors.white),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      "Log Touchpoint",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ThisWeekPage extends StatelessWidget {
  const ThisWeekPage({
    Key? key,
    required GlobalKey<RefreshableState> refreshableKey,
  })  : _refreshableKey = refreshableKey,
        super(key: key);

  final GlobalKey<RefreshableState> _refreshableKey;

  @override
  Widget build(BuildContext context) {
    return CustomPagedListView<ClientProfileAppointmentResponse>(
      padding: EdgeInsets.all(16.0),
      initPageFuture: (pageIndex) async {
        final res = await CustomerPortalApiRepo().clientProfileAppointmentClient.getMyFutureAppointmentsThisWeek(
              pageIndex: pageIndex,
              pageSize: 10,
            );
        return res.result!.toPagedList();
      },
      emptyBuilder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Image.asset(ResourcesUtils.noResult),
                ),
                Text(
                  "You don’t have any appointments/touchpoints this week.",
                  style: TextStyle(color: Color(0xFF909090)),
                ),
              ],
            ),
          ),
        );
      },
      itemBuilder: (context, item, index) {
        final loggedIn = item.loggedOnDate != null;
        final isPast = item.scheduledDate!.isBefore(DateTime.now());
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(color: Colors.grey, width: 0.7),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.clientProfile!.fullName!,
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Color(0xff131315),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text(
                              "Date",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              item.scheduledDate == null
                                  ? "N/A"
                                  : DateFormat("dd MMM").format(item.scheduledDate!.toLocal()),
                              style: TextStyle(color: Color(0xFF4E4E4E)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (loggedIn)
                    SizedBox(
                      width: 70.0,
                      height: 70.0,
                    ),
                  if (!loggedIn)
                    Container(
                      width: 70.0,
                      height: 70.0,
                      padding: EdgeInsets.all(8.0),
                      color: isPast ? Color(0xFF73BFC7) : Color(0xFFBCBCBC),
                      child: InkWell(
                        onTap: isPast
                            ? () async {
                                final change = await Navigation.navToLogScheduledAppointment(
                                  context,
                                  clientProfileId: item.clientProfile!.id,
                                  clientProfileAppointmentId: item.id,
                                  scheduledDate: item.scheduledDate,
                                );
                                if (change) {
                                  _refreshableKey.currentState!.refresh();
                                }
                              }
                            : null,
                        child: Column(
                          children: [
                            Expanded(
                              child: Icon(Icons.call, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
