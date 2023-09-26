import 'package:flairstechsuite_mobile/enums/day_of_week.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/views/ft_banner.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
import 'package:flairstechsuite_mobile/widgets/basic/confirmation_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class ManageShiftsPage extends StatelessWidget {
  final _refreshableKey = GlobalKey<RefreshableState>();

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
            title: Text("Manage Shifts".toUpperCase()),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                tooltip: "Add new shift",
                onPressed: () async {
                  final changed = await Navigation.navToCreateShift(context);
                  if (changed != true) return;
                  _refreshableKey.currentState!.refresh();
                },
              ),
            ],
          ),
          body: Refreshable(
            key: _refreshableKey,
            child: RefreshIndicator(
              onRefresh: () async => _refreshableKey.currentState!.refresh(),
              child: CustomFutureBuilder<ShiftDTOListResponse>(
                initFuture: () => Repository().getAllShifts(),
                onSuccess: (context, snapshot) {
                  final shifts = snapshot.data!.result!;
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    itemCount: shifts.length,
                    itemBuilder: (context, index) => _buildShiftItem(
                      context: context,
                      shift: shifts[index],
                    ),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildShiftItem({required BuildContext context, required ShiftDTO shift}) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        side: BorderSide(color: Colors.grey, width: 0.7),
      ),
      child: FTBanner(
        enabled: shift.isDefault,
        textStyle: TextStyle(fontSize: 12),
        location: BannerLocation.topEnd,
        color: Theme.of(context).primaryColor,
        message: "Default",
        child: _itemWithoutBanner(context: context, shift: shift),
      ),
    );
  }

  Widget _itemWithoutBanner({required BuildContext context, required ShiftDTO shift}) {
    final shiftStartingTime = TimeOfDay(hour: shift.fromHour!, minute: shift.fromMinutes!);
    final shiftEndingTime = TimeOfDay(hour: shift.toHour!, minute: shift.toMinutes!);
    final workingHoursTime = TimeOfDay(
      hour: (shift.workingHoursInMinutes! / 60).floor(),
      minute: shift.workingHoursInMinutes! % 60,
    );
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      height: 156,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsetsDirectional.only(end: shift.isDefault! ? 28 : 0),
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        shift.name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColors.darkGrayColor),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "From",
                        style: TextStyle(fontSize: 12, color: theme.primaryColor, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        shiftStartingTime.format(context),
                        style: TextStyle(color: MyColors.lightGrayColor),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "To",
                        style: TextStyle(fontSize: 12, color: theme.primaryColor, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        shiftEndingTime.format(context),
                        style: TextStyle(color: MyColors.lightGrayColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        "Working Hours",
                        style: TextStyle(fontSize: 12, color: theme.primaryColor, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        MaterialLocalizations.of(context).formatTimeOfDay(
                          workingHoursTime,
                          alwaysUse24HourFormat: true,
                        ),
                        style: TextStyle(color: MyColors.lightGrayColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Working Days",
                        style: TextStyle(fontSize: 12, color: theme.primaryColor, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 10),
                      _workingDays(shift.weekDays!),
                    ],
                  ),
                  const SizedBox(height: 2),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          shift.isDefault!
              ? Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text(
                        "Assign".toUpperCase(),
                        style: theme.textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () => _onAssignShift(context, shift),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: FaIcon(
                          FontAwesomeIcons.solidTrashAlt,
                          size: 16,
                          color: MyColors.darkGrayColor,
                        ),
                      ),
                      onTap: () async {
                        final result = await showConfirmationDialog(
                          context: context,
                          icon: Icons.warning,
                          title: "Delete Shift",
                          actionText: "\"${shift.name}\" will be deleted, please note"
                              " that all employees assigned to this shift"
                              " will be automatically assigned to the default"
                              " shift, are you sure you want to continue?",
                        );
                        if (result) {
                          _deleteShift(context, shift);
                        }
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text(
                          "Make Default".toUpperCase(),
                          style: theme.textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                      onTap: () async {
                        final result = await showConfirmationDialog(
                          context: context,
                          icon: Icons.warning,
                          title: "Change Default Shift",
                          actionText:
                              "Are you sure you want to change the default shift for all new employees to \"${shift.name}\"",
                        );
                        if (result) {
                          _setAsDefaultShift(context, shift);
                        }
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text(
                          "Assign".toUpperCase(),
                          style: theme.textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () => _onAssignShift(context, shift),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _workingDays(List<DayOfWeek?> days) {
    final workingDays = <String?>[];
    for (var d in days) workingDays.add(d.name);
    return Expanded(
      child: Text(
        workingDays.join(", "),
        maxLines: 2,
        style: TextStyle(color: MyColors.lightGrayColor),
      ),
    );
  }

  void _setAsDefaultShift(BuildContext context, ShiftDTO shift) async {
    final response = await Repository().setAsDefaultShift(shift.id);
    if (response?.status ?? false) {
      await showAdaptiveAlertDialog(
        context: context,
        content: Text(
          "(${shift.name}) was successfully set as the default shift",
        ),
      );
      _refreshableKey.currentState!.refresh();
    } else {
      await showErrorDialog(context, response);
    }
  }

  void _deleteShift(BuildContext context, ShiftDTO shift) async {
    final response = await Repository().deleteShift(shift.id);
    if (response?.status ?? false) {
      await showAdaptiveAlertDialog(
        context: context,
        content: Text(
          "(${shift.name}) was deleted successfully.",
        ),
      );
      _refreshableKey.currentState!.refresh();
    } else {
      await showErrorDialog(context, response);
    }
  }

  _onAssignShift(BuildContext context, ShiftDTO shift) async {
    Navigation.navToAssignShift(context, shift);
  }
}
