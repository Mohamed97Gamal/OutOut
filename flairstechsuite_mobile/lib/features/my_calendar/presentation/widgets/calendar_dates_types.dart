import 'package:flairstechsuite_mobile/features/my_calendar/presentation/widgets/date_type_widget.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class CalendarDateTypes extends StatelessWidget {
  const CalendarDateTypes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return SizedBox(
        height: 120,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DateTypeWidget(
                color: MyColors.lightRedColor.withAlpha(100), text: "Weekends"),
            DateTypeWidget(color: MyColors.yellow, text: "Public Holidays"),
            DateTypeWidget(color: MyColors.lightGreen, text: "Personal Leaves"),
            DateTypeWidget(color: MyColors.lightGrey, text: "Today"),
          ],
        ));
  }
}
