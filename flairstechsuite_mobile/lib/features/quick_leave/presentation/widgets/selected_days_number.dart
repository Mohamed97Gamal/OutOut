import 'package:flairstechsuite_mobile/enums/quick_leaves.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../repo/repository.dart';
import '../../../../widgets/basic/future_builder.dart';
import '../../../../widgets/basic/refreshable.dart';
import '../manager/balance_provider.dart';
import '../manager/quick_leave_provider.dart';

class NumberOfSelectedDaysWidget extends StatelessWidget {
  const NumberOfSelectedDaysWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quickLeaveProvider = Provider.of<QuickLeaveProvider>(context);
    final balanceProvider = Provider.of<BalanceProvider>(context);
    return Refreshable(
      key: quickLeaveProvider.selectedDaysRefreshableKey,
      child: CustomFutureBuilder<IntResponse>(
        //TODO: revert (UTC) after OCTOBER
        initFuture: () => Repository().calculateLeaveDays(
            from: DateTime.parse(
                "${DateFormat('yyyy-MM-dd').format(quickLeaveProvider.startDate.subtract(Duration(days: 1)))}T22:00:00.000Z"),
            to: DateTime.parse(
                "${DateFormat('yyyy-MM-dd').format(quickLeaveProvider.endDate.subtract(Duration(days: 1)))}T22:00:00.000Z")),
        onSuccess: (context, snapshot) {
          Provider.of<BalanceProvider>(context, listen: false)
              .setNumberOfSelectedDays(snapshot.data?.result);
          return RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Number of Selected days: ",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                quickLeaveProvider.selectedQuickLeave == QuickLeave.HalfDayLeave
                    ? TextSpan(
                        text: "½",
                        // textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          // fontWeight: FontWeight.w400,
                        ),
                      )
                    : TextSpan(
                        text: "${balanceProvider.numberOfSelectedDays}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
