import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/models/employee_balance_dto.dart';
import 'package:flairstechsuite_mobile/models/leave_request_dto.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/screens/common/fields/custom_date_range_form_field.dart';
import 'package:flairstechsuite_mobile/utils/all_text_utils.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/loading/custom_paged_list_view.dart';
import 'package:flairstechsuite_mobile/widgets/my_balance/leave_container_item.dart';
import 'package:flairstechsuite_mobile/widgets/my_balance/leave_details_item.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class MyBalancePage extends StatefulWidget {
  @override
  State<MyBalancePage> createState() => _MyBalancePageState();
}

class _MyBalancePageState extends State<MyBalancePage> with SingleTickerProviderStateMixin {
  final _refreshableKey = GlobalKey<RefreshableState>();
  final _wholePageRefreshableKey = GlobalKey<RefreshableState>();

  DateTime? from;
  DateTime? to;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    getCycle();
  }

  @override
  Widget build(BuildContext context) {
    return Refreshable(
      key: _wholePageRefreshableKey,
      child: RefreshIndicator(
        onRefresh: () async {
          final response = await Repository().getMyBalances();
          setState(() {
            counter = 0;
            from = response.result!.cycle!.from!.toLocal();
            to = response.result!.cycle!.to!.toLocal();
          });
          _wholePageRefreshableKey.currentState!.refresh();
          _refreshableKey.currentState!.refresh();
        },
        child: menu.DrawerScaffold(
          builder: (context) {
            return NotificationScaffold(
              bottomNavigationBar: const MyBottomNavigationBar(),
              appBar: AppBar(
                centerTitle: true,
                bottom: PreferredSize(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      width: 300,
                      child: Card(
                        child: from == null && to == null
                            ? Container()
                            : CustomDateRangeFormField(
                                textAlign: TextAlign.center,
                                name: "date",
                                labelText: "",
                                initialValue: DateTimeRange(start: from!, end: to!),
                                onChanged: (dateRange) {
                                  setState(() {
                                    counter = 0;
                                  });
                                  from = dateRange!.start;
                                  to = dateRange.end;
                                  _refreshableKey.currentState!.refresh();
                                },
                                hintText: "Date",
                                firstDate: DateTime(1999, 1, 1),
                                lastDate: DateTime.now().add(Duration(days: 365)),
                              ),
                      ),
                    ),
                    preferredSize: const Size.fromHeight(48 + 4.0 + 12)),
                leading: IconButton(
                  icon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(ResourcesUtils.menu),
                  ),
                  onPressed: () {
                    return Provider.of<menu.MenuController>(context, listen: false).toggle();
                  },
                ),
                title: Text("My Balance".toUpperCase()),
              ),
              body: buildBody(Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Container(
                            height: 150,
                            color: MyColors.heavyWhiteColor,
                          ),
                        ),
                        Column(
                          children: [
                            CustomFutureBuilder<EmployeeBalancesDTOOperationResult>(
                              initFuture: () => Repository().getMyBalances(),
                              onSuccess: (context, snapshot) {
                                final employeeBalanceDTO = snapshot.data!.result as EmployeeBalanceDTO;
                               return SizedBox(
                                  height: 175.0,
                                  width: double.infinity,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(8.0),
                                    physics: const ScrollPhysics(),
                                    children: [
                                      LeaveContainerItem(
                                        validTill: employeeBalanceDTO.cycle!.to,
                                        numberOfLeaves: employeeBalanceDTO.annualLeave,
                                        totalNumberOfLeaves: employeeBalanceDTO.totalAnnualLeave,
                                        title: "Annual Leave",
                                        imagePath: ResourcesUtils.annualLeave,
                                      ),
                                      LeaveContainerItem(
                                        validTill: employeeBalanceDTO.cycle!.to,
                                        numberOfLeaves: employeeBalanceDTO.sickLeave,
                                        totalNumberOfLeaves: employeeBalanceDTO.totalSickLeave,
                                        title: "Sick Leave",
                                        imagePath: ResourcesUtils.sickLeave,
                                      ),
                                      LeaveContainerItem(
                                        validTill: employeeBalanceDTO.cycle!.to,
                                        numberOfLeaves: employeeBalanceDTO.emergencyLeave,
                                        totalNumberOfLeaves: employeeBalanceDTO.totalEmergencyLeave,
                                        title: "Emergency Leave",
                                        imagePath: ResourcesUtils.emergencyLeave,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            from == null && to == null
                                ? Container()
                                : Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(padding: const EdgeInsets.only(left: 8.0), child: RedBoldTitleText(text: "Leaves")),
                                        Container(
                                          color: Theme.of(context).primaryColor,
                                          height: 3,
                                          width: 100,
                                        ),
                                        Refreshable(
                                          key: _refreshableKey,
                                          child: Expanded(
                                            child: CustomPagedListView<LeaveRequestDTO>(
                                              padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                                              initPageFuture: (pageKey) async {
                                                final fromDate = DateTime.tryParse(DateFormat("yyyy-MM-dd").format(from!))!;
                                                final toDate = DateTime.tryParse(DateFormat("yyyy-MM-dd").format(to!))!;
                                                final leaveResult = await Repository().getMyLeaveRequests(
                                                  pageNumber: counter,
                                                  pageSize: 5,
                                                  from: fromDate,
                                                  to: toDate,
                                                );
                                                counter++;
                                                return leaveResult.result!.toPagedList();
                                              },
                                              itemBuilder: (context, item, index) {
                                                return LeaveDetailsItem(leaveRequestDTO: item);
                                              },
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
                ],
              )),
            );
          },
        ),
      ),
    );
  }

  Widget buildBody(Widget child) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return child;
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: child,
          ),
        ),
      );
    }
  }

  getCycle() async {
    final response = await Repository().getMyBalances();
    setState(() {
      from = response.result?.cycle?.from?.toLocal();
      to = response.result?.cycle?.to?.toLocal();
    });
  }
}
