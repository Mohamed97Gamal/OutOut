import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/views/employee_tile.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
import 'package:flairstechsuite_mobile/widgets/basic/confirmation_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class ViewAdminsPage extends StatefulWidget {
  ViewAdminsPage();

  @override
  _ViewAdminsScreenState createState() => _ViewAdminsScreenState();
}

class _ViewAdminsScreenState extends State<ViewAdminsPage> {
  final _refreshableKey = GlobalKey<RefreshableState>();
  final _searchController = TextEditingController();

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
              onPressed: () =>
                  Provider.of<menu.MenuController>(context, listen: false).toggle(),
            ),
            title: Text("Admins".toUpperCase()),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48 + 4.0 + 12),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                    top: 4, bottom: 12, start: 12, end: 12),
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
                                setState(() => {});
                              },
                              style: Theme.of(context).textTheme.subtitle1,
                              decoration: InputDecoration.collapsed(
                                hintText: "Admin Name",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          InkResponse(
                            child: Icon(
                              _searchController.text.isEmpty
                                  ? Icons.search
                                  : Icons.clear,
                            ),
                            onTap: _searchController.text.isEmpty
                                ? null
                                : () {
                                    setState(() {
                                      _searchController.clear();
                                    });
                                    FocusScope.of(context).unfocus();
                                  },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _onAddAdmin,
              )
            ],
          ),
          body: Refreshable(
            key: _refreshableKey,
            child: RefreshIndicator(
              onRefresh: () async => _refreshableKey.currentState!.refresh(),
              child: CustomFutureBuilder<MyOrgAdminListResponse>(
                initFuture: () => Repository().getMyOrgAdminList(),
                onSuccess: (context, snapshot) {
                  final query = _searchController.text.trim().toLowerCase();
                  final filteredAdmins = snapshot.data!.result!
                      .where((e) => e.fullName!.toLowerCase().contains(query))
                      .toList(growable: false);
                  return filteredAdmins.isEmpty
                      ? Center(child: Text("No admins found"))
                      : ListView.builder(
                          key: PageStorageKey("view_admins_list"),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          itemCount: filteredAdmins.length,
                          itemExtent: 88.0,
                          itemBuilder: (context, index) {
                            final employee = filteredAdmins[index];
                            return EmployeeTile(
                              margin:
                                  const EdgeInsetsDirectional.only(bottom: 16),
                              employee: employee,
                              backgroundColor: index.isEven
                                  ? null
                                  : Colors.black.withOpacity(0.05),
                              trailing: Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: MaterialButton(
                                  color: Theme.of(context).primaryColor,
                                  child: const Text("REMOVE"),
                                  onPressed: () async {
                                    final confirm =
                                        await showConfirmationDialog(
                                      context: context,
                                      title: "Delete admin",
                                      actionText:
                                          "Delete admin (${employee.fullName})?",
                                      icon: FontAwesomeIcons.solidTrashAlt,
                                    );
                                    if (confirm != true) return;

                                    final response =
                                        await showFutureProgressDialog(
                                      context: context,
                                      initFuture: () => Repository()
                                          .deleteMyOrgAdmin(employee.id),
                                    );
                                    if (response?.status ?? false) {
                                      await showAdaptiveAlertDialog(
                                        context: context,
                                        content: const Text(
                                            "You have successfully deleted admin."),
                                      );
                                      _refreshableKey.currentState!.refresh();
                                    } else {
                                      await showErrorDialog(context, response);
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  _onAddAdmin() {
    final textTheme = Theme.of(context).textTheme.subtitle1;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("Add Existing", style: textTheme),
                onTap: () async {
                  Navigator.of(context).pop();
                  final assigned = await Navigation.navToAssignAdmin(context);
                  if (assigned == true) _refreshableKey.currentState!.refresh();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
