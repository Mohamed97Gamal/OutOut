import 'package:flairstechsuite_mobile/features/check_in_out/domain/entity/check_in_out_history_entity.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/presentation/widgets/my_checkinout_history_details_screen/completed_text.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/presentation/widgets/my_checkinout_history_details_screen/red_text.dart';
import 'package:flairstechsuite_mobile/utils/date_utils.dart' as date_utils;
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckInOutHistoryDetailsScaffold extends StatelessWidget {
  final CheckInOutHistoryEntity? checkInOutHistory;

  CheckInOutHistoryDetailsScaffold(this.checkInOutHistory);

  @override
  Widget build(BuildContext context) {
    final from = checkInOutHistory!.startShiftDate;
    final to = checkInOutHistory!.endShiftDate;
    return NotificationScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          to != null && from!.day != to.day
              ? "${date_utils.DateUtils.dateFormat.format(from)} - ${date_utils.DateUtils.dateFormat.format(to)}"
              .toUpperCase()
              : "${date_utils.DateUtils.dateFormat.format(from!)}".toUpperCase(),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: checkInOutHistory!.checkInOutDurations!.length + 1,
        separatorBuilder: (context, index) {
          return SizedBox(height: 0);
        },
        itemBuilder: (context, index) {
          if (index == checkInOutHistory!.checkInOutDurations!.length) {
            return Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  checkInOutHistory!.totalWorkingMinutes! >=
                      checkInOutHistory!.requiredMinutes!
                      ? CompletedText(true)
                      : CompletedText(false),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Total Hours:  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${date_utils.DateUtils.durationToText(Duration(minutes: checkInOutHistory!.totalWorkingMinutes!))}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          final duration = checkInOutHistory!.checkInOutDurations![index];
          return Container(
            color: index.isEven ? Colors.white : Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RedText(text: "From:  "),
                        const SizedBox(height: 8.0),
                        RedText(text: "Location:  "),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        duration.checkInDTO == null
                            ? Text("-")
                            : Text(
                            "${DateFormat('h:mm a').format(duration.checkInDTO!.creationDate!.toUtc().add(Duration(hours: 2)))}"),
                        const SizedBox(height: 8.0),
                        Text(duration.checkInDTO!.placeName!),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.black12,
                          width: 2,
                          height: 40.0,
                        ),
                        const SizedBox(width: 24.0),
                        RedText(text: "To:  "),
                        duration.checkOutDTO == null
                            ? Text("-")
                            : Text(
                            "${DateFormat('h:mm a').format(duration.checkOutDTO!.creationDate!.toUtc().add(Duration(hours: 2)))}")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
