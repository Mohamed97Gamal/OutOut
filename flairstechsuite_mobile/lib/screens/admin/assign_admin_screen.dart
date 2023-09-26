import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/views/employee_tile.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';

class AssignAdminScreen extends StatefulWidget {
  @override
  _AssignAdminScreenState createState() => _AssignAdminScreenState();
}

class _AssignAdminScreenState extends State<AssignAdminScreen> {
  final _refreshableKey = GlobalKey<RefreshableState>();
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return NotificationScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Admin Selection".toUpperCase()),
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
                            setState(() => {});
                          },
                          style: Theme.of(context).textTheme.subtitle1,
                          decoration: InputDecoration.collapsed(
                            hintText: "Employee Name",
                            hintStyle:
                                Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black.withOpacity(0.6)),
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
                                setState(() => _searchController.clear());
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
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Refreshable(
      key: _refreshableKey,
      child: RefreshIndicator(
        onRefresh: () async => _refreshableKey.currentState!.refresh(),
        child: CustomFutureBuilder<AllEmployeesListResponse>(
          initFuture: () => Repository().getAllEmployees(),
          onSuccess: (context, snapshot) {
            final query = _searchController.text.trim().toLowerCase();
            const tileHeight = 88.0;
            const listVerticalPadding = 16.0;
            final filteredEmployees =
                snapshot.data!.result!.where((e) => e.fullName!.toLowerCase().contains(query)).toList(growable: false);
            return DraggableScrollbar.semicircle(
              controller: _scrollController,
              alwaysVisibleScrollThumb: false,
              labelConstraints: BoxConstraints.tightFor(width: 36, height: 36),
              labelTextBuilder: (offset) {
                final currentItem = (offset - listVerticalPadding) ~/ tileHeight;
                final letter = currentItem <= filteredEmployees.length - 1
                    ? filteredEmployees[currentItem].fullName!.substring(0, 1)
                    : filteredEmployees.last.fullName!.substring(0, 1);
                return Text(
                  letter.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1,
                );
              },
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: listVerticalPadding),
                itemCount: filteredEmployees.length,
                itemExtent: tileHeight,
                itemBuilder: (context, index) {
                  final employee = filteredEmployees[index];
                  return EmployeeTile(
                    employee: employee,
                    margin: const EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 16),
                    backgroundColor: index.isEven ? null : Colors.black.withOpacity(0.05),
                    trailing: employee.isAdmin == false
                        ? Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: MaterialButton(
                              color: Theme.of(context).primaryColor,
                              child: const Text("ADD"),
                              onPressed: () async {
                                final response = await showFutureProgressDialog(
                                  context: context,
                                  initFuture: () => Repository().assignMyOrgAdmin(employee.id),
                                );
                                if (response?.status ?? false) {
                                  await showAdaptiveAlertDialog(
                                    context: context,
                                    content: const Text("You have successfully assigned admin."),
                                  );
                                  Navigator.of(context).pop(true);
                                } else {
                                  await showErrorDialog(context, response);
                                }
                              },
                            ),
                          )
                        : null,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
