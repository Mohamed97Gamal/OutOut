import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  const TitleText(this.text, {this.backgroundColor, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor ?? Theme.of(context).primaryColor,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(3.0),
        child: Text(
          text ?? "",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
