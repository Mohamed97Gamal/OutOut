import 'package:flutter/material.dart';

class DateTypeWidget extends StatelessWidget {
  final Color? color;
  final String? text;
  const DateTypeWidget({Key? key, this.color, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text!,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
