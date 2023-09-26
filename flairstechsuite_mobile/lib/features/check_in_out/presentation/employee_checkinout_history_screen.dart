import 'manager/my_checkinout_history_provider.dart';
import 'widgets/my_checkinout_history_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeCheckInOutHistoryScreen extends StatelessWidget {
  final String employeeId;

  EmployeeCheckInOutHistoryScreen(this.employeeId) : assert(employeeId != null);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MyCheckInOutHistoryProvider()),
        ],
        child: CheckInOutHistoryScaffold(
          employeeId: employeeId,
          isMyCheckInOut: false,
        ));
  }
}
