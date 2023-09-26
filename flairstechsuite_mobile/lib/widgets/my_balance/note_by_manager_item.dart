import 'package:flairstechsuite_mobile/utils/all_text_utils.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class NoteByManagerItem extends StatelessWidget {
  final String? title;
  final String? value;

  const NoteByManagerItem({Key? key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RedBoldTitleText(text: title, size: 22.0),
        const SizedBox(height: 24.0),
        Text(
          value!,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 22.0,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          color: MyColors.grayColor,
          height: 0.5,
          width: double.infinity,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
