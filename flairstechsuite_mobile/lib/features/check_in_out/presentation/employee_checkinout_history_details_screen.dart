import 'package:flairstechsuite_mobile/features/check_in_out/domain/entity/check_in_out_history_entity.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/presentation/widgets/checkinout_history_details_scaffold.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/presentation/widgets/my_checkinout_history_details_screen/completed_text.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/utils/date_utils.dart' as date_utils;
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeCheckInOutHistoryDetailsScreen extends StatelessWidget {
  final CheckInOutHistoryEntity? checkInOutHistory;

  EmployeeCheckInOutHistoryDetailsScreen(this.checkInOutHistory);

  @override
  Widget build(BuildContext context) {
    return CheckInOutHistoryDetailsScaffold(checkInOutHistory);
  }
}
