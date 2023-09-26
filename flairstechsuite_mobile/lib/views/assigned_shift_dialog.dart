import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/views/ft_banner.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_dialog.dart'as dia;
import 'package:flairstechsuite_mobile/widgets/basic/custom_radio.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/shifts/working_days_widget.dart';
import 'package:flutter/material.dart';

Future<bool> showUpdateEmployeeAssignedShiftDialog(
  BuildContext context,
  String employeeId,
  String? oldShiftId,
) async {
  final selectedShift = ValueNotifier<String?>(oldShiftId);
  final selected = await dia.showAdaptiveDialog<String>(
    context: context,
    builder: (context) {
      return AdaptiveAlertDialog(
        title: Text("Change Assigned Shift"),
        content: ValueListenableBuilder(
          valueListenable: selectedShift,
          builder: (context, dynamic value, child) {
            return CustomFutureBuilder<ShiftDTOListResponse>(
              initFuture: () async {
                final result = await Repository().getAllShifts();
                selectedShift.value ??= result.result!.first.id;
                return result;
              },
              onSuccess: (context, snapshot) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (final shiftDTO in snapshot.data!.result!)
                      ShiftRadioTile(
                        shiftDTO: shiftDTO,
                        selectedShift: selectedShift,
                      ),
                  ],
                );
              },
            );
          },
        ),
        actions: <AdaptiveAlertDialogAction>[
          AdaptiveAlertDialogAction(
            isPrimary: true,
            title: "Change",
            onPressed: () => Navigator.of(context).pop(selectedShift.value),
          ),
          AdaptiveAlertDialogAction(
            title: "Cancel",
            onPressed: () => Navigator.of(context).pop(null),
          ),
        ],
      );
    },
  );
  if (selected != null) {
    final response = await showFutureProgressDialog<BoolResponse>(
      context: context,
      initFuture: () => Repository().updateEmployeeAssignedShift(employeeId, selected),
    );
    if (response?.status ?? false) {
      await showAdaptiveAlertDialog(
        context: context,
        content: const Text("You have successfully updated assigned shift."),
      );
      return true;
    } else {
      await showErrorDialog(context, response);
    }
  }

  return false;
}

class ShiftRadioTile extends StatelessWidget {
  const ShiftRadioTile({
    Key? key,
    required this.shiftDTO,
    required this.selectedShift,
  }) : super(key: key);

  final ShiftDTO shiftDTO;
  final ValueNotifier<String?> selectedShift;

  @override
  Widget build(BuildContext context) {
    final fromTime = TimeOfDay(hour: shiftDTO.fromHour!, minute: shiftDTO.fromMinutes!);
    final toTime = TimeOfDay(hour: shiftDTO.toHour!, minute: shiftDTO.toMinutes!);
    final workingHoursTime = TimeOfDay(
      hour: (shiftDTO.workingHoursInMinutes! / 60).floor(),
      minute: shiftDTO.workingHoursInMinutes! % 60,
    );
    return ClipRRect(
      child: FTBanner(
        enabled: shiftDTO.isDefault,
        textStyle: TextStyle(fontSize: 12),
        location: BannerLocation.topEnd,
        color: Theme.of(context).primaryColor,
        message: "Default",
        child: CustomRadioListTile<String?>(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(end: shiftDTO.isDefault! ? 28 : 0),
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  shiftDTO.name!,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "From",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        fromTime.format(context),
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                  const SizedBox(width: 8.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "To",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        toTime.format(context),
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Required: ",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    MaterialLocalizations.of(context).formatTimeOfDay(
                      workingHoursTime,
                      alwaysUse24HourFormat: true,
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              const SizedBox(width: 16.0),
              SizedBox(
                height: 35,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Working Days: ",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    WorkingDaysWidget(
                      days: shiftDTO.weekDays,
                    ),
                  ],
                ),
              ),
            ],
          ),
          value: shiftDTO.id,
          groupValue: selectedShift.value,
          onChanged: (value) => selectedShift.value = value,
        ),
      ),
    );
  }
}
