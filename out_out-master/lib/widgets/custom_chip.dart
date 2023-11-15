import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final Widget label;
  final Widget avatar;
  final Function(bool)? onSelected;
  final bool selected;

  const CustomChip({
    Key? key,
    required this.label,
    required this.avatar,
    required this.selected,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      pressElevation: 1.0,
      selected: selected,
      onSelected: onSelected,
      backgroundColor:
          selected == true ? Theme.of(context).primaryColor : Colors.white70,
      label: label,
      labelStyle: Theme.of(context).chipTheme.labelStyle?.copyWith(
            color: selected == true
                ? Colors.white
                : Theme.of(context).primaryColor,
            fontWeight: FontWeight.w800,
          ),
      avatar: IconTheme(
        data: Theme.of(context).iconTheme.copyWith(
              color: selected == true
                  ? Colors.white
                  : Theme.of(context).primaryColor,
            ),
        child: avatar,
      ),
    );
  }
}
