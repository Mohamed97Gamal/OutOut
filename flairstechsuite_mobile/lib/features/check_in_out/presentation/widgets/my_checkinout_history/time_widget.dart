import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/colors.dart';

class TimeWidget extends StatelessWidget {
  final DateTime? checkInDateTime;
  final bool isFrom;

  const TimeWidget({Key? key, this.checkInDateTime, this.isFrom = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO(kirolous): remove offset compensation for daylightsavings egypt
    //final diffInHours = DateTime.now().timeZoneOffset.inHours;
    const compensation = 2;
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            isFrom ? "From  " : "To  ",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            checkInDateTime != null
                ? "${DateFormat('h:mm a').format(checkInDateTime!.toUtc().add(Duration(hours: compensation)))}"
                : "-",
            style: TextStyle(color: MyColors.lightGrayColor),
          ),
        ],
      ),
    );
  }
}
