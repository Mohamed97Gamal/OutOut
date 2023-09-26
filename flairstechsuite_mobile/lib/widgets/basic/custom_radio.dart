import 'package:flutter/material.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  const CustomRadioListTile({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff707070)),
                    shape: BoxShape.circle,
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: Color(0x33000029),
                          offset: Offset(0.0, 3.0),
                          blurRadius: 6.0,
                        ),
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 15.0,
                    height: 15.0,
                    margin: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 8.0),
            Expanded(child: title)
          ],
        ),
      ),
    );
  }
}
