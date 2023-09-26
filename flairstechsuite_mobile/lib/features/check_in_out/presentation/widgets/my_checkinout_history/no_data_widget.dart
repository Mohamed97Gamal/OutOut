import 'package:flutter/material.dart';
import 'package:flairstechsuite_mobile/utils/date_utils.dart' as date_utils;

class NoDataWidget extends StatelessWidget {
  final DateTime? date;
  const NoDataWidget({Key? key, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 50,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                "${date_utils.DateUtils.dateFormat.format(date!)}",
                textAlign: TextAlign.center,
              ),
            ),
            VerticalDivider(color: Colors.black, indent: 4, endIndent: 4),
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  Spacer(),
                  Text("No Data"),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
