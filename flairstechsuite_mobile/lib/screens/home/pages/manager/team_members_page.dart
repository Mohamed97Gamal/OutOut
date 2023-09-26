import 'dart:async';

import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/providers/manger_team.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/views/employee_tile.dart';
import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/loading/custom_paged_list_view.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TeamMembersPage extends StatefulWidget {
  @override
  _TeamMembersPageState createState() => _TeamMembersPageState();
}

class _TeamMembersPageState extends State<TeamMembersPage> {
  final _refreshableKey = GlobalKey<RefreshableState>();
  final _searchController = TextEditingController();
  int counter = 0;
  Timer? _debounce;
  bool? checkBoxValue=true;

  @override
  void didChangeDependencies() {
    Future.delayed(Duration.zero, () async {
      Provider.of<Manager>(context, listen: false).setMyTeam = true;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return menu.DrawerScaffold(
      builder: (context) {
        return NotificationScaffold(
          bottomNavigationBar: const MyBottomNavigationBar(),
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(ResourcesUtils.menu),
              ),
              onPressed: () => Provider.of<menu.MenuController>(context, listen: false).toggle(),
            ),
            title: Text("Team Members".toUpperCase()),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48 + 4.0 + 12),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 4, bottom: 12, start: 12, end: 12),
                child: SizedBox(
                  height: 48,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {
                                  counter = 0;
                                });
                                if (_debounce?.isActive ?? false) _debounce?.cancel();
                                _debounce = Timer(const Duration(milliseconds: 500), () {
                                  _refreshableKey.currentState!.refresh();
                                });
                              },
                              style: Theme.of(context).textTheme.subtitle1,
                              decoration: InputDecoration.collapsed(
                                hintText: "Employee Name",
                                hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          InkResponse(
                            child: Icon(
                              _searchController.text.isEmpty ? Icons.search : Icons.clear,
                            ),
                            onTap: _searchController.text.isEmpty
                                ? null
                                : () {
                                    setState(() {
                                      counter = 0;
                                      _searchController.clear();
                                    });
                                    FocusScope.of(context).unfocus();
                                    _refreshableKey.currentState!.refresh();
                                  },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: _buildBody(context),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Refreshable(
      key: _refreshableKey,
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            counter = 0;
          });
          _refreshableKey.currentState!.refresh();
        },
        child: Column(
          children: [
            CheckboxListTile(
              value: checkBoxValue,
              onChanged: (value) {
                setState((){
                  checkBoxValue = value;
                  counter = 0;
                });
                _refreshableKey.currentState!.refresh();
              },
              title: Text("Show Direct Reportees only"),
            ),
            Expanded(
              child: CustomPagedListView<EmployeeProfileDTO>(
                padding: const EdgeInsets.only(top: 16.0),
                initPageFuture: (pageKey) async {
                  final myTeamMembersResult =
                      await Repository().getMyTeamMembersPaginated(pageNumber: counter, pageSize: 5, searchValue: _searchController.text.trim(),directReporteesOnly: checkBoxValue);
                  counter++;
                  return myTeamMembersResult.result!.toPagedList();
                },
                itemBuilder: (context, item, index) {
                  return EmployeeTile(
                    employee: item,
                    margin: const EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 16),
                    backgroundColor: index.isEven ? null : Colors.black.withOpacity(0.05),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
