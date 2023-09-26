import 'package:flairstechsuite_mobile/enums/leave_request_type.dart';
import 'package:flairstechsuite_mobile/models/leave_request_dto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeLeaveStatusContainer extends StatelessWidget {
  final Color? color;
  final LeaveRequestDTO? leaveRequestDTO;
  const EmployeeLeaveStatusContainer({Key? key, this.color,this.leaveRequestDTO}) : super(key: key);

  String getFromDateFormat(String? dateTime) {
    if (dateTime != null) {
      final dateTimeConverted = DateTime.parse(dateTime).toLocal();
      final formatter = DateFormat('dd-MM-yyyy');
      final formatted = formatter.format(dateTimeConverted);
      return formatted;
    } else {
      return "N/A";
    }
  }

  String getToDateFormat(String? dateTime) {
    if (dateTime != null) {
      var dateTimeConverted = DateTime.parse(dateTime).toLocal();
      dateTimeConverted = DateTime(dateTimeConverted.year, dateTimeConverted.month, dateTimeConverted.day - 1);
      final formatter = DateFormat('dd-MM-yyyy');
      final formatted = formatter.format(dateTimeConverted);
      return formatted;
    } else {
      return "N/A";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 24),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          color: color,
        ),
        child: Column(
          children: [
            labelAndData(label: "Name", data: leaveRequestDTO!.targetEmployeeName!),
            Divider(color: Colors.white, height: 3.0, thickness: 0.5),
            labelAndData(label: "Type", data: LeaveRequestType.fromJson(leaveRequestDTO!.type).name??""),
            Divider(color: Colors.white, height: 3.0, thickness: 0.5),
            labelAndData(label: "Leave Date", data: "${getFromDateFormat(leaveRequestDTO!.from)} ${"To"} ${getToDateFormat(leaveRequestDTO!.to)}"??""),
          ],
        ),
      ),
    );
  }

  Widget labelAndData({required String label, required String data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              data,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
