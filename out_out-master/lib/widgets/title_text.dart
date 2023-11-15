import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;

  const TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontWeight: FontWeight.w900, fontSize: 19),
    );
  }
}

class HorizontallyPaddedTitleText extends StatelessWidget {
  final String text;

  const HorizontallyPaddedTitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class HeaderTitleText extends StatelessWidget {
  final String text;

  const HeaderTitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
