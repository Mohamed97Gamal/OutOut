import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flairstechsuite_mobile/widgets/shifts/working_days_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileShiftTile extends StatelessWidget {
  const ProfileShiftTile({
    Key? key,
    required this.shift,
    this.trailing,
  }) : super(key: key);

  final AssignedShiftDTO? shift;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final fromTime = TimeOfDay(hour: shift!.shiftFromHour!, minute: shift!.shiftFromMinutes!);
    final toTime = TimeOfDay(hour: shift!.shiftToHour!, minute: shift!.shiftToMinutes!);
    final workingHoursTime = TimeOfDay(
      hour: (shift!.shiftWorkingHoursInMinutes! / 60).floor(),
      minute: shift!.shiftWorkingHoursInMinutes! % 60,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       const SizedBox(
            width: 20.0,
            height: 20.0,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Icon(FontAwesomeIcons.businessTime),
            ),
          ),
         const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  children: [
                    Text(
                      "Assigned Shift: ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(shift!.shiftName!),
                  ],
                ),
               const SizedBox(height: 8),
                Wrap(
                  children: [
                    Text(
                      "From",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                 const SizedBox(width: 8.0),
                    Text(
                      fromTime.format(context),
                      style: TextStyle(color: MyColors.lightGrayColor),
                    ),
                const SizedBox(width: 20.0),
                    Text(
                      "To",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                 const SizedBox(width: 8.0),
                    Text(
                      toTime.format(context),
                      style: TextStyle(color: MyColors.lightGrayColor),
                    ),
                  ],
                ),
               const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "Required: ",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      MaterialLocalizations.of(context).formatTimeOfDay(
                        workingHoursTime,
                        alwaysUse24HourFormat: true,
                      ),
                      style: const TextStyle(color: MyColors.lightGrayColor),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Working Days: ",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    WorkingDaysWidget(days: shift!.weekDays),
                  ],
                ),
              ],
            ),
          ),
          if (trailing != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: trailing,
            ),
        ],
      ),
    );
  }
}
