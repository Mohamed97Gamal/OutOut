import 'package:flairstechsuite_mobile/utils/all_text_utils.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class TitleValuePairItem extends StatelessWidget {
  final String title;
  final String? value;
  final Color valueColor;
  final bool showUnderLine;
  const TitleValuePairItem({Key? key,required this.title,required this.value, this.valueColor=MyColors.blackColor, this.showUnderLine =true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: RedBoldTitleText(text: title, size: 22.0)),
            Expanded(
              child: Text(
                value!,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 22.0,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16.0),
        showUnderLine?Column(
          children: [
            Container(
              color: MyColors.grayColor,
              height: 0.5,
              width: double.infinity,
            ),
            const SizedBox(height: 16.0),
          ],
        ):Container(),
      ],
    );
  }
}
