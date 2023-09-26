import 'package:flairstechsuite_mobile/features/check_in_out/data/model/check_in_out_dto.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/presentation/manager/my_checkinout_history_provider.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/presentation/widgets/my_checkinout_history/dates_dropdown_row.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/presentation/widgets/my_checkinout_history_body.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckInOutHistoryScaffold extends StatelessWidget {
  final bool? isMyCheckInOut;
  final String? employeeId;
  const CheckInOutHistoryScaffold(
      {Key? key, this.isMyCheckInOut, this.employeeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkInOutProvider =
        Provider.of<MyCheckInOutHistoryProvider>(context);
    return NotificationScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ATTENDANCE HISTORY"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(48 + 4.0 + 12),
          child: Padding(
            padding: EdgeInsets.only(top: 4, bottom: 12),
            child: const SizedBox(height: 48, child: DateDropdownRow()),
          ),
        ),
      ),
      body: MyCheckInOutHistoryBody(
          getCheckInOutHistory: () => checkInOutProvider
              .getCheckInOutHistoryCheck(isMyCheckInOut!, employeeId)),
    );
  }
}
