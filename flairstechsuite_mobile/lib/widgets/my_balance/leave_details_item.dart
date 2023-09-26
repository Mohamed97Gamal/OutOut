import 'package:flairstechsuite_mobile/enums/leave_request_status.dart';
import 'package:flairstechsuite_mobile/enums/leave_request_type.dart';
import 'package:flairstechsuite_mobile/models/leave_request_dto.dart';
import 'package:flairstechsuite_mobile/utils/all_text_utils.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveDetailsItem extends StatelessWidget {
  final LeaveRequestDTO leaveRequestDTO;

  const LeaveDetailsItem({Key? key, required this.leaveRequestDTO}) : super(key: key);

  String getFromDateFormat(String? dateTime) {
    if (dateTime != null) {
      final dateTimeConverted = DateTime.parse(dateTime);
      final formatter = DateFormat('dd-MM-yyyy');
      final formatted = formatter.format(dateTimeConverted.add(Duration(hours: 2)));
      return formatted;
    } else {
      return "N/A";
    }
  }

  String getToDateFormat(String? dateTime) {
    if (dateTime != null) {
      var dateTimeConverted = DateTime.parse(dateTime);
      dateTimeConverted = DateTime(dateTimeConverted.year, dateTimeConverted.month, dateTimeConverted.day);
      final formatter = DateFormat('dd-MM-yyyy');
      final formatted = formatter.format(dateTimeConverted);
      return formatted;
    } else {
      return "N/A";
    }
  }

  @override
  Widget build(BuildContext context) {
    print("${leaveRequestDTO.recoveredDays}    ${leaveRequestDTO.requestedDays}     ssssssssssss");
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () async {
          await Navigation.navToLeaveDetails(context, leaveRequestDTO: leaveRequestDTO);
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoldLightGrayColorText(text: LeaveRequestType.fromJson(leaveRequestDTO.type).name),
                BoldSmallText(
                  text: LeaveRequestStatus.fromJson(leaveRequestDTO.status).name,
                  color: LeaveRequestStatus.fromJson(leaveRequestDTO.status).color,
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leaveRequestDTO.from == null && leaveRequestDTO.to == null
                    ? SmallLightRedColorText(text: "N/A")
                    : Row(
                        children: [
                          SmallLightRedColorText(text: getFromDateFormat(leaveRequestDTO.from)),
                          const SizedBox(width: 5.0),
                          Container(
                            color: MyColors.lightGrayColor,
                            width: 2.0,
                            height: 15.0,
                          ),
                          const SizedBox(width: 5.0),
                          SmallLightRedColorText(text: getToDateFormat(leaveRequestDTO.to)),
                        ],
                      ),
                SmallText(
                    text: "${leaveRequestDTO.addedBalance ?? leaveRequestDTO.recoveredDays ?? leaveRequestDTO.requestedDays ?? "N/A"} Days",
                    color: MyColors.lightGrayColor),
              ],
            ),
            const SizedBox(height: 16.0),
            Container(
              color: MyColors.grayColor,
              height: 0.5,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
