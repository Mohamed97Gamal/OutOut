import 'package:flairstechsuite_mobile/features/check_in_out/domain/entity/check_in_out_history_entity.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/presentation/employee_checkinout_history_details_screen.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/presentation/widgets/checkinout_history_details_scaffold.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/presentation/widgets/my_checkinout_history_details_screen/completed_text.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/utils/date_utils.dart' as date_utils;
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCheckInOutHistoryDetailsScreen extends StatelessWidget {
  final CheckInOutHistoryEntity? checkInOutHistory;

  MyCheckInOutHistoryDetailsScreen(this.checkInOutHistory);

  @override
  Widget build(BuildContext context) {
    return CheckInOutHistoryDetailsScaffold(checkInOutHistory);
  }
}
