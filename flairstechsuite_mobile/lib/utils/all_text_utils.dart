import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class SmallLightRedColorText extends StatelessWidget {
  final String? text;

  const SmallLightRedColorText({Key? key, this.text}) : super(key: key);

//todo : add FontFamily
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(fontSize: 15.0, color: MyColors.lightRedColor, fontWeight: FontWeight.w700),
    );
  }
}

class BoldLightGrayColorText extends StatelessWidget {
  final String? text;

  const BoldLightGrayColorText({Key? key, this.text}) : super(key: key);

//todo : add FontFamily
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: MyColors.lightGrayColor),
    );
  }
}

class SmallText extends StatelessWidget {
  final String? text;
  final Color? color;

  const SmallText({Key? key, this.text, this.color}) : super(key: key);

//todo : add FontFamily
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(fontSize: 13.0, color: color),
    );
  }
}

class BoldSmallText extends StatelessWidget {
  final String? text;
  final Color? color;

  const BoldSmallText({Key? key, this.text, this.color}) : super(key: key);

//todo : add FontFamily
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}

class RedBoldTitleText extends StatelessWidget {
  final String? text;
  final double size;

  const RedBoldTitleText({Key? key, this.text, this.size=24}) : super(key: key);

//todo : add FontFamily
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
