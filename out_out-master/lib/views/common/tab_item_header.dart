import 'package:flutter/material.dart';
import 'package:out_out/views/common/tab_view_item.dart';

class TabItemHeader extends StatelessWidget {
  final int isSelected;
  final TabViewItem item;
  final Function onPressed;
  final int index;

  const TabItemHeader({
    Key? key,
    required this.isSelected,
    required this.item,
    required this.onPressed,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isSelected == index ? Colors.white : Theme.of(context).primaryColor,
      ),
      onPressed: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(
          item.title,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
            color: isSelected != index ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
