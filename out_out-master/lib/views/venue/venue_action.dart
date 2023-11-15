import 'package:flutter/material.dart';

class VenueAction extends StatelessWidget {
  final Widget icon;
  final List<Widget> content;
  final void Function()? onPressed;

  const VenueAction({
    Key? key,
    required this.icon,
    required this.content,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, top: 3.0, bottom: 3.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: onPressed == null ? 0.0 : 4.0,
              child: IconButton(
                onPressed: onPressed,
                icon: icon,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyText2!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
