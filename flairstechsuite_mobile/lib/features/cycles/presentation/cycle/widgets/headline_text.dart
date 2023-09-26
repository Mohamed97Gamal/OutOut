import 'package:flutter/material.dart';

class HeadlineText extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color color;
  const HeadlineText(
      {Key? key, this.title, this.subtitle, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: Color(0xffD13827),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '   ',
          ),
          TextSpan(
            text: subtitle,
            style: TextStyle(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
