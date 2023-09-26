import 'package:flutter/material.dart';

class CompletedText extends StatelessWidget {
  final bool isCompleted;
  const CompletedText(
    this.isCompleted, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      isCompleted ? "Completed" : "UnCompleted",
      style: TextStyle(
        color: isCompleted ? Color(0xff73bfc7) : Color(0xffFFD800),
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    );
  }
}
