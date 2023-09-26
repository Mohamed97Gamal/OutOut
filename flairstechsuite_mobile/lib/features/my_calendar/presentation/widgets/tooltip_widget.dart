import 'package:flutter/material.dart';

class TooltipWidget extends StatelessWidget {
  final String? tooltipStartDate;
  final String? tooltipEndDate;
  final Color? toolTipColor;
  final String? toolTipText;

  const TooltipWidget(
      {Key? key,
      this.tooltipStartDate,
      this.tooltipEndDate,
      this.toolTipColor,
      this.toolTipText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: toolTipColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "$toolTipText",
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            Text(
              "${tooltipStartDate}  |  ${tooltipEndDate}",
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
