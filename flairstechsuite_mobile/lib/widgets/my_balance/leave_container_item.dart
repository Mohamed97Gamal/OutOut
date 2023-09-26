import 'package:flairstechsuite_mobile/utils/all_text_utils.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LeaveContainerItem extends StatelessWidget {
  final String title;
  final num? numberOfLeaves;
  final num? totalNumberOfLeaves;
  final String imagePath;
  final DateTime? validTill;

  const LeaveContainerItem({
    Key? key,
    required this.title,
    required this.numberOfLeaves,
    required this.imagePath,
    required this.totalNumberOfLeaves,
    required this.validTill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num barPercentage(num numberOfLeaves, num totalNumberOfLeaves) {
      if (numberOfLeaves > totalNumberOfLeaves) {
        return 1.0;
      } else if (numberOfLeaves <= 0) {
        return 0.0;
      } else {
        return numberOfLeaves / totalNumberOfLeaves;
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
          border: Border.all(color: MyColors.grayColor),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.only(right: 16.0), child: BoldLightGrayColorText(text: title)),
                Row(
                  children: [
                    Text(
                      "${numberOfLeaves} ",
                      style: TextStyle(color: Theme.of(context).hintColor, fontSize: 40.0),
                    ),
                    Text(
                      "/ ${totalNumberOfLeaves}",
                      style: TextStyle(color: MyColors.lightGrayColor, fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "Valid till ${DateFormat("dd-MM-yyyy").format(validTill!.toLocal())}",
                  style: TextStyle(fontSize: 13.0),
                ),
                const SizedBox(height: 8.0),
                LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  animation: false,
                  lineHeight: 15.0,
                  percent: barPercentage(numberOfLeaves!, totalNumberOfLeaves!) as double,
                  linearStrokeCap: LinearStrokeCap.butt,
                  progressColor: Theme.of(context).hintColor,
                  backgroundColor: MyColors.lightGrayColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
