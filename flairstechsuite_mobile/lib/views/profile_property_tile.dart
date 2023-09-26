import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class ProfilePropertyTile extends StatelessWidget {
  const ProfilePropertyTile({
    Key? key,
    required this.name,
    required this.icon,
    required this.value,
    this.secondValue,
    this.hyperlinked = false,
    this.trailing,
    this.onPressed,
  }) : super(key: key);

  final String name;
  final String? value;
  final bool hyperlinked;
  final String? secondValue;
  final Widget icon;
  final Widget? trailing;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed as void Function()?,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
        child: Row(
          children: [
             SizedBox(
              width: 20.0,
              height: 20.0,
              child: FittedBox(
                fit: BoxFit.contain,
                child: icon,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text(
                    name ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    value ?? "",
                    style: TextStyle(
                      color: hyperlinked
                          ? Theme.of(context).primaryColor
                          : MyColors.lightGrayColor,
                      decoration: hyperlinked ? TextDecoration.underline : null,
                    ),
                  ),
                  Text(secondValue ?? ""),
                ],
              ),
            ),
            if (trailing != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: trailing,
              ),
          ],
        ),
      ),
    );
  }
}
