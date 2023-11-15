import 'package:flutter/material.dart';
import 'package:out_out/views/common/tab_view_item.dart';

class TabHistoryItemHeader extends StatelessWidget {
  final int isSelected;
  final TabViewItem item;
  final Function onPressed;
  final int index;

  const TabHistoryItemHeader({
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
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.title,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
                color: isSelected != index ? Colors.grey : Colors.black,
              ),
            ),
            const SizedBox(height: 5.0),
            if (isSelected == index)
              Container(
                width: 30.0,
                height: 1.0,
                color: Theme.of(context).primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
