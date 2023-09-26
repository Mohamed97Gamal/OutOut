import 'package:flairstechsuite_mobile/enums/day_of_week.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class WorkingDaysWidget extends StatelessWidget {
  final List<DayOfWeek?>? days;
  const WorkingDaysWidget({Key? key, this.days}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workingDays = <String?>[];
    for (var d in days!) workingDays.add(d.name);
    return Expanded(
      child: Text(workingDays.join(", "),
          maxLines: 2, style: Theme.of(context).textTheme.bodyText1),
    );
  }
}
