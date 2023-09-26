import 'package:flairstechsuite_mobile/enums/employee_leaves_type.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/models/leave_request_dto.dart';
import 'package:flairstechsuite_mobile/models/my_team_leave_request.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/screens/common/fields/custom_date_range_form_field.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/loading/custom_paged_list_view.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flairstechsuite_mobile/widgets/quick_leave/employee_leave_status_conatiner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class TeamStatusPage extends StatefulWidget {
  @override
  State<TeamStatusPage> createState() => _TeamStatusPageState();
}

class _TeamStatusPageState extends State<TeamStatusPage> with SingleTickerProviderStateMixin {
  final _refreshableKey = GlobalKey<RefreshableState>();
  final _wholePageRefreshableKey = GlobalKey<RefreshableState>();
  bool? checkBoxValue = true;
  EmployeeLeavesType? dropDownValue=EmployeeLeavesType.all;

  DateTime from = DateTime(DateTime.now().year, 1, 1);
  DateTime to = DateTime(DateTime.now().year, 12, 31);
  int counter = 0;
  List<String?> emails = [];
  List<String?> cc = [];
  bool showFilters = false;
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Refreshable(
      key: _wholePageRefreshableKey,
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            counter = 0;
            from = DateTime(DateTime.now().year, 1, 1);
            to = DateTime(DateTime.now().year, 12, 31);
            cc.clear();
            _emailController.clear();
            dropDownValue = dropDownValue=EmployeeLeavesType.all;
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
                          child: CustomDateRangeFormField(
                            textAlign: TextAlign.center,
                            name: "date",
                            labelText: "",
                            initialValue: DateTimeRange(start: from, end: to),
                            onChanged: (dateRange) {
                              setState(() {
                                counter = 0;
                                from = dateRange!.start;
                                to = dateRange.end;
                              });
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
                  title: Text("My Team Leaves".toUpperCase()),
                ),
                body: buildBody(
                  child: Refreshable(
                    key: _refreshableKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                      child: CustomFutureBuilder<MyTeamMembersListResponse>(
                        initFuture: () => Repository().getMyTeamMembers(directReporteesOnly: checkBoxValue),
                        onSuccess: (context, snapshot) {
                          for (var i = 0; i < snapshot.data!.result!.length; i++) {
                            emails.add(snapshot.data!.result![i].organizationEmail);
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CheckboxListTile(
                                      value: checkBoxValue,
                                      onChanged: (value) {
                                        setState(() {
                                          checkBoxValue = value;
                                          counter = 0;
                                          _emailController.clear();
                                          cc.clear();
                                          emails.clear();
                                        });
                                        _refreshableKey.currentState!.refresh();
                                      },
                                      title: Text("Show Direct Reportees only"),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        showFilters = !showFilters;
                                      });
                                    },
                                    child: Card(
                                      elevation: 4.0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                        child: Text("Filters"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              if (showFilters) ...[
                                Text("Email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                                textFialdSuggest(),
                                const SizedBox(height: 16.0),
                                Text("Type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                                Card(
                                  elevation: 4.0,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                    child: DropdownButton(
                                      value: dropDownValue,
                                      items: [
                                        DropdownMenuItem<EmployeeLeavesType>(
                                          child: Text("All"),
                                          value: EmployeeLeavesType.all,
                                        ),
                                        DropdownMenuItem<EmployeeLeavesType>(
                                          child: Text("Leaves"),
                                          value: EmployeeLeavesType.leaves,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("No Show"),
                                          value: EmployeeLeavesType.noShow,
                                        ),
                                      ],
                                      onChanged: (dynamic value) {
                                        setState(() {
                                          dropDownValue = value;
                                          counter = 0;
                                        });
                                        _refreshableKey.currentState!.refresh();
                                      },
                                      isExpanded: true,
                                      underline: Container(),
                                      style: TextStyle(fontSize: 18, color: Colors.black),
                                      iconEnabledColor: Colors.black, //Icon color
                                    ),
                                  ),
                                ),
                              ],
                              Expanded(
                                child: CustomPagedListView<LeaveRequestDTO>(
                                  padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                                  initPageFuture: (pageKey) async {
                                    final fromDate = DateTime.tryParse(DateFormat("yyyy-MM-dd").format(from));
                                    final toDate = DateTime.tryParse(DateFormat("yyyy-MM-dd").format(to));
                                    final filter = MyTeamLeaveRequest(
                                      from: fromDate,
                                      to: toDate,
                                      directReporteesOnly: checkBoxValue,
                                      leaveRequest: dropDownValue!.value != 2 ? dropDownValue!.value : null,
                                      employeesOrganizationEmails: cc,
                                    );
                                    final leaveResult = await Repository().getMyTeamLeaveRequests(
                                      pageNumber: counter,
                                      pageSize: 5,
                                      filter: filter,
                                    );
                                    counter++;
                                    return leaveResult.result!.toPagedList();
                                  },
                                  itemBuilder: (context, item, index) {
                                    return EmployeeLeaveStatusContainer(leaveRequestDTO: item, color: index.isEven ? MyColors.lightGrey : MyColors.lightGreen);
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }

  Widget buildBody({Widget? child}) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return SingleChildScrollView(
          child: SizedBox(
              height: MediaQuery.of(context).size.height, child: child));
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

  static List<String?> getSuggestions(String query, List<String?> emails) {
    final matches = <String?>[];
    matches.addAll(emails);
    matches.retainWhere((s) => s!.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  Widget textFialdSuggest() {
    return Card(
      elevation: 4.0,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: false,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: 'Search by Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        cc.clear();
                        _emailController.clear();
                      });
                      _refreshableKey.currentState!.refresh();
                    },
                    child: Icon(Icons.clear)),
                border: InputBorder.none,
              ),
              controller: _emailController,
            ),
            validator: _checkEmail,
            hideOnEmpty: true,
            hideOnLoading: true,
            hideOnError: true,
            suggestionsCallback: (pattern) async {
              setState(() {
                if (pattern.contains(' ')) {
                  pattern = pattern.replaceAll(' ', '');
                }
              });
              var allEmails = await getSuggestions(pattern, emails);
              if (allEmails.length >= 3) allEmails = allEmails.sublist(0, 3);
              if (allEmails.length < 3) allEmails = allEmails.sublist(0);
              if (_checkEmail(pattern) == null) {
                allEmails.add(pattern);
              }
              allEmails = allEmails.toSet().toList();
              return allEmails;
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            itemBuilder: (context, dynamic suggestion) {
              return Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    suggestion,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              );
            },
            onSuggestionSelected: (dynamic suggestion) {
              setState(() {
                _emailController.text = suggestion;
                String? mailWithOutSpaces;
                setState(() {
                  counter = 0;
                  if (suggestion.contains(' ')) {
                    mailWithOutSpaces = suggestion.replaceAll(' ', '');
                    suggestion = mailWithOutSpaces;
                  }
                });
                if (!cc.contains(suggestion)) {
                  setState(() {
                    cc.add(suggestion);
                  });
                }
                _refreshableKey.currentState!.refresh();
              });
              // _emailController.text = suggestion;
            },
          ),
        ),
      ),
    );
  }

  String? _checkEmail(String? value) {
    value = value!.trim();
    if (value?.isNotEmpty == true) {
      final emailValid = RegExp(
              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)\b")
          .hasMatch(value);
      final dotInMail = value.endsWith('.');
      if (emailValid && !dotInMail)
        return null;
      else
        return "Email is not valid";
    } else {
      return null;
    }
  }
}
