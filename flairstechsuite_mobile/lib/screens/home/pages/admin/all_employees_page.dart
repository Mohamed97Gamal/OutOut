import 'dart:async';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/models/employees_filteration_request_dto.dart';
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


class AllEmployeesPage extends StatefulWidget {
  @override
  _AllEmployeesPageState createState() => _AllEmployeesPageState();
}

class _AllEmployeesPageState extends State<AllEmployeesPage> {
  final _refreshableKey = GlobalKey<RefreshableState>();
  final _searchController = TextEditingController();
  int counter = 0;
  Timer? _debounce;
@override
  void didChangeDependencies() {
    Future.delayed(Duration.zero, () async {
      Provider.of<Manager>(context, listen: false).setMyTeam = false;
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
            title: Text("All Employees".toUpperCase()),
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
        child: CustomPagedListView<EmployeeProfileDTO>(
          padding: const EdgeInsets.only(top: 16.0),
          initPageFuture: (pageKey) async {
            final employeesFilterationRequestDTO =
                EmployeesFilterationRequestDTO(searchQueries: [_searchController.text.trim()]);
            final myTeamMembersResult = await Repository().getAllEmployeesPaginated(
              pageNumber: counter,
              pageSize: 5,
              employeesFilterationRequest: employeesFilterationRequestDTO,
            );
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
    );
  }
}
