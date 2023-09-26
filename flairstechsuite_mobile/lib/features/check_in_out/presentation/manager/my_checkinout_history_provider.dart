import 'package:flairstechsuite_mobile/features/check_in_out/data/model/check_in_out_dto.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flutter/cupertino.dart';

class MyCheckInOutHistoryProvider with ChangeNotifier {
  final refreshableKey = GlobalKey<RefreshableState>();
  int? _month = DateTime.now().month;
  int? _year = DateTime.now().year;
  Future<CheckInOutHistoryDTOResponse> Function()? getCheckInOutHistory;
  get month => this._month;

  set month(value) {
    this._month = value;
    refreshableKey.currentState!.refresh();
    notifyListeners();
  }

  get year => this._year;

  set year(value) {
    this._year = value;
    refreshableKey.currentState!.refresh();
    notifyListeners();
  }

  Future<CheckInOutHistoryDTOResponse> getCheckInOutHistoryCheck(
      bool isMyCheckInOut, String? employeeId) async {
    if (isMyCheckInOut) {
      return Repository().getMyCheckInOutHistory(
        DateTime(year, month, 1),
        DateTime(year, month + 1, 1),
      );
    } else {
      return Repository().getEmployeeCheckInOutHistory(
        employeeId,
        DateTime(year, month, 1),
        DateTime(year, month + 1, 1),
      );
    }
  }

  void refresh() {
    refreshableKey.currentState!.refresh();
  }
}
