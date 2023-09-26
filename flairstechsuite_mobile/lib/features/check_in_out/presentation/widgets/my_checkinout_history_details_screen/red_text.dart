import 'package:flutter/material.dart';

class RedText extends StatelessWidget {
  final String text;

  const RedText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xffD13827),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
