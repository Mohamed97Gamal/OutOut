import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../enums/quick_leaves.dart';
import '../../../../models/employee_balance_dto.dart';
import '../../../../repo/repository.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/basic/custom_radio.dart';
import '../../../../widgets/basic/future_builder.dart';
import '../manager/balance_provider.dart';
import '../manager/calendar_dates_provider.dart';
import '../manager/quick_leave_provider.dart';

class QuickLeaveOptions extends StatelessWidget {
  final TextEditingController? textEditingController;

  const QuickLeaveOptions({Key? key, this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quickLeaveProvider = Provider.of<QuickLeaveProvider>(context);
    final balanceProvider = Provider.of<BalanceProvider>(context);

    return CustomFutureBuilder<EmployeeBalancesDTOOperationResult>(
      initFuture: () => Repository().getMyBalances(),
      onSuccess: (context, snapshot) {
        final employeeBalanceDTO = snapshot.data!.result;

        if (!balanceProvider.isCalendarLoaded) {
          Future.delayed(Duration.zero, () {
            Provider.of<CalendarDatesProvider>(context, listen: false)
                .viewChanged(employeeBalanceDTO!.leaveRequests, employeeBalanceDTO.holidays, employeeBalanceDTO.weekendDays);
            balanceProvider.setSelectedQuickLeaveBalance(employeeBalanceDTO);
            quickLeaveProvider.onQuickLeaveSelect(context,value: QuickLeave.AnnualLeave);
          });
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            balanceProvider.takenBalance == -50
                ? CircularProgressIndicator()
                : Text(
                    "Remaining Balance ${balanceProvider.takenBalance} out of ${balanceProvider.totalBalance}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 16,
                      color: MyColors.lightRedColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            CustomRadioListTile<QuickLeave>(
              value: QuickLeave.AnnualLeave,
              groupValue: quickLeaveProvider.selectedQuickLeave,
              onChanged: (value) {
                quickLeaveProvider.onQuickLeaveSelect(context, value: value);
              },
              title: Text(QuickLeave.AnnualLeave.name!),
            ),
            CustomRadioListTile<QuickLeave>(
              value: QuickLeave.EmergencyLeave,
              groupValue: quickLeaveProvider.selectedQuickLeave,
              onChanged: (value) {
                quickLeaveProvider.onQuickLeaveSelect(context, value: value);
                textEditingController!.text = quickLeaveProvider.textFieldTextValue;
              },
              title: Text(QuickLeave.EmergencyLeave.name!),
            ),
            CustomRadioListTile<QuickLeave>(
              value: QuickLeave.SickLeave,
              groupValue: quickLeaveProvider.selectedQuickLeave,
              onChanged: (value) {
                quickLeaveProvider.onQuickLeaveSelect(context, value: value);
              },
              title: Text(QuickLeave.SickLeave.name!),
            ),
            CustomRadioListTile<QuickLeave>(
              value: QuickLeave.HalfDayLeave,
              groupValue: quickLeaveProvider.selectedQuickLeave,
              onChanged: (value) {
                quickLeaveProvider.onQuickLeaveSelect(context, value: value);
              },
              title: Text(QuickLeave.HalfDayLeave.name!),
            ),
          ],
        );
      },
    );
  }
}
