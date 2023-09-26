import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/views/employee_tile.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/confirmation_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssignShiftScreen extends StatefulWidget {
  final ShiftDTO shift;

  AssignShiftScreen({required this.shift}) : assert(shift != null);

  @override
  _AssignShiftScreenState createState() => _AssignShiftScreenState();
}

class _AssignShiftScreenState extends State<AssignShiftScreen> {
  final _refreshableKey = GlobalKey<RefreshableState>();
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  final _selectedEmployees = Set<String?>();
  bool? checkBoxValue = true;

  @override
  Widget build(BuildContext context) {
    return NotificationScaffold(
      appBar: AppBar(
        // To make sure title is centered
        actions: [IconButton(onPressed: null, icon: Icon(null))],
        centerTitle: true,
        title: Column(
          children: [
            Text(widget?.shift?.name?.toUpperCase() ?? "", textAlign: TextAlign.center),
            Text(
              () {
                final fromTime = TimeOfDay(hour: widget.shift.fromHour!, minute: widget.shift.fromMinutes!);
                final toTime = TimeOfDay(hour: widget.shift.toHour!, minute: widget.shift.toMinutes!);
                return "From ${fromTime.format(context)} to ${toTime.format(context)}";
              }(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white),
            )
          ],
        ),
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
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          onChanged: (value) {
                            setState(() {});
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: _selectedEmployees.isNotEmpty,
        child: FloatingActionButton.extended(
          label: Text("Assign".toUpperCase()),
          onPressed: _onAssignButtonTapped,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Refreshable(
      key: _refreshableKey,
      child: RefreshIndicator(
        onRefresh: () async => _refreshableKey.currentState!.refresh(),
        child: Column(
          children: [
            CheckboxListTile(
              value: checkBoxValue,
              onChanged: (value) {
                setState(() {
                  checkBoxValue = value;
                });
                _refreshableKey.currentState!.refresh();
              },
              title: Text("Show Assignees only"),
            ),
            Expanded(
              child: CustomFutureBuilder<AllEmployeesListResponse>(
                initFuture: () {
                  _selectedEmployees.clear();
                  if (checkBoxValue!) {
                    return Repository().getEmployeesAssignedToShift(shiftId: widget.shift.id);
                  } else {
                    return Repository().getAllEmployees();
                  }
                },
                onSuccess: (context, snapshot) {
                  final query = _searchController.text.trim().toLowerCase();
                  const tileHeight = 88.0;
                  const listTopPadding = 16.0;
                  final filteredEmployees = snapshot.data!.result!.where((e) => e.fullName!.toLowerCase().contains(query)).toList(growable: false);
                  return DraggableScrollbar.semicircle(
                    controller: _scrollController,
                    alwaysVisibleScrollThumb: false,
                    labelConstraints: BoxConstraints.tightFor(width: 36, height: 36),
                    labelTextBuilder: (offset) {
                      final currentItem = (offset - listTopPadding) ~/ tileHeight;
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
                      padding: const EdgeInsets.fromLTRB(16, listTopPadding, 16, 64),
                      itemCount: filteredEmployees.length,
                      itemExtent: tileHeight,
                      itemBuilder: (context, index) {
                        final employee = filteredEmployees[index];
                        return EmployeeTile(
                          leading: Checkbox(
                            value: employee?.assignedShift?.shiftId == widget.shift.id || _selectedEmployees.contains(employee.id),
                            onChanged: employee?.assignedShift?.shiftId == widget.shift.id
                                ? null
                                : (value) {
                                    setState(() {
                                      if (value!)
                                        _selectedEmployees.add(employee.id);
                                      else
                                        _selectedEmployees.remove(employee.id);
                                    });
                                  },
                          ),
                          employee: employee,
                          margin: const EdgeInsetsDirectional.only(bottom: 16),
                          backgroundColor: index.isEven ? null : Colors.black.withOpacity(0.05),
                          trailing: employee?.assignedShift?.shiftId == widget.shift.id
                              ? Text(
                                  "Assigned".toUpperCase(),
                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Color(0xff73bfc7)),
                                )
                              : null,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAssignButtonTapped() async {
    if (_selectedEmployees == null || _selectedEmployees.isEmpty) return;

    final confirm = await showConfirmationDialog(
        context: context,
        icon: FontAwesomeIcons.businessTime,
        title: "Assign Shift",
        actionText: "Do you want to assign (${widget.shift?.name ?? ""}) to the selected employee(s)?");

    if (confirm != true) return;

    var response;
    if (_selectedEmployees.length == 1) {
      response = await showFutureProgressDialog<BoolResponse>(
        context: context,
        initFuture: () => Repository().assignShift(widget.shift.id, _selectedEmployees),
      );
    } else {
      response = await showFutureProgressDialog<AssignShiftMultipleResponse>(
        context: context,
        initFuture: () => Repository().assignShiftToMultipleEmployees(widget.shift.id, _selectedEmployees),
      );
    }

    if (response?.status ?? false) {
      if (response is AssignShiftMultipleResponse && response.result != null && response.result!.isNotEmpty) {
        await showAdaptiveAlertDialog(
          context: context,
          content: SingleChildScrollView(
            child: Text(response.result!.isEmpty
                ? "${widget.shift?.name ?? ""}Successfully assigned to [${_selectedEmployees.length}] employee(s)."
                : "${widget.shift?.name ?? ""} Successfully assigned to [${_selectedEmployees.length}] employee(s).\n" +
                    "AS for ${response.result!.join("\n")} their shift will be assigned within the next 24 hours."),
          ),
        );
      } else {
        await showAdaptiveAlertDialog(
          context: context,
          content: Text(
            "${widget.shift?.name ?? ""}Successfully assigned to [1] employee(s).",
          ),
        );
      }
      _selectedEmployees.clear();
      _refreshableKey.currentState!.refresh();
    } else {
      await showErrorDialog(context, response);
    }
    setState(() {});
  }
}
