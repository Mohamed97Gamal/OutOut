import 'package:flairstechsuite_mobile/features/check_in_out/presentation/manager/my_checkinout_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateDropdownRow extends StatelessWidget {
  const DateDropdownRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monthWidth = MediaQuery.of(context).size.width / 2.1;
    final yearWidth = monthWidth / 1.5;
    final now = DateTime.now();
    final checkInOutProvider =
        Provider.of<MyCheckInOutHistoryProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
         SizedBox(
          width: monthWidth,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DropdownButton<int>(
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down),
                underline: Container(),
                style: TextStyle(color: Colors.black),
                value: checkInOutProvider.month,
                items: <DropdownMenuItem<int>>[
                  for (var index in List.generate(12, (index) => index + 1))
                    DropdownMenuItem<int>(
                      value: index,
                      child: Center(
                        child: Text(
                          DateFormat.MMMM()
                              .format(DateTime(now.year, index))
                              .toUpperCase(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                ],
                onChanged: (value) {
                  checkInOutProvider.month = value;
                },
              ),
            ),
          ),
        ),
         SizedBox(
          width: yearWidth,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DropdownButton<int>(
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down),
                underline: Container(),
                value: checkInOutProvider.year,
                items: <DropdownMenuItem<int>>[
                  for (var index in List.generate(
                      now.year - 2009, (index) => 2010 + index))
                    DropdownMenuItem<int>(
                      value: index,
                      child: Center(
                        child: Text(
                          "$index",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                ],
                onChanged: (value) {
                  checkInOutProvider.year = value;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
