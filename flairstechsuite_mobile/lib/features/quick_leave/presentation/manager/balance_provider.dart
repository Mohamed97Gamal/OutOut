import '../../../../enums/quick_leaves.dart';
import '../../../../models/employee_balance_dto.dart';
import '../../../../widgets/basic/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BalanceProvider with ChangeNotifier {
  num? takenBalance = -50;
  num? totalBalance = -50;
  int? numberOfSelectedDays = -50;
  num? annualLeaveBalance = -50;
  num? sickLeaveBalance = -50;
  num? emergencyLeaveBalance = -50;
  num? totalAnnualLeaveBalance = -50;
  num? totalSickLeaveBalance = -50;
  num? totalEmergencyLeaveBalance = -50;
  bool isCalendarLoaded = false;

  EmployeeBalanceDTO? employeeBalanceDTO;

  setSelectedQuickLeaveBalance(EmployeeBalanceDTO? employeeBalance) {
    employeeBalanceDTO = employeeBalance;
    _initBalances();

    isCalendarLoaded = true;
    notifyListeners();
  }

  void setNumberOfSelectedDays(int? numberOfSelectedDays) {
    this.numberOfSelectedDays = numberOfSelectedDays;
    notifyListeners();
  }

  void _initBalances() {
    annualLeaveBalance = employeeBalanceDTO!.annualLeave;
    totalAnnualLeaveBalance = employeeBalanceDTO!.totalAnnualLeave;

    takenBalance = annualLeaveBalance;
    totalBalance = totalAnnualLeaveBalance;

    sickLeaveBalance = employeeBalanceDTO!.sickLeave;
    totalSickLeaveBalance = employeeBalanceDTO!.totalSickLeave;

    emergencyLeaveBalance = employeeBalanceDTO!.emergencyLeave;
    totalEmergencyLeaveBalance = employeeBalanceDTO!.totalEmergencyLeave;

    notifyListeners();
  }

  void setBalances(QuickLeave selectedQuickLeave) {
    switch (selectedQuickLeave) {
      case QuickLeave.AnnualLeave:
        takenBalance = annualLeaveBalance;
        totalBalance = totalAnnualLeaveBalance;
        break;
      case QuickLeave.SickLeave:
        takenBalance = sickLeaveBalance;
        totalBalance = totalSickLeaveBalance;
        break;
      case QuickLeave.EmergencyLeave:
        takenBalance = emergencyLeaveBalance;
        totalBalance = totalEmergencyLeaveBalance;
        break;
      case QuickLeave.HalfDayLeave:
        if (annualLeaveBalance! < .5) {
          takenBalance = emergencyLeaveBalance;
          totalBalance = totalEmergencyLeaveBalance;
        } else {
          takenBalance = annualLeaveBalance;
          totalBalance = totalAnnualLeaveBalance;
        }

        break;
      default:
    }
    notifyListeners();
  }

  checkNumberOfSelectedDays(BuildContext context) async {
    if (numberOfSelectedDays! > takenBalance!) {
      await showConfirmationDialog(
          context: context,
          actionText: "Insufficient Leave Balance",
          icon: FontAwesomeIcons.download,
          showFalseAction: false,
          showTitle: false,
          title: "",
          trueTitle: "OK");
      return;
    }
  }
}
