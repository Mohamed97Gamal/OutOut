import 'package:flutter/material.dart';

class GenderField extends StatefulWidget {
  final ValueGetter<bool> isMale;
  final ValueChanged<bool?> onChanged;

  const GenderField({
    required this.isMale,
    required this.onChanged,
  });

  @override
  _GenderFieldState createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(labelText: "Gender"),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Radio<bool>(
                  groupValue: widget.isMale(),
                  value: true,
                  onChanged: (value) {
                    setState(() {
                      widget.onChanged(value);
                    });
                  },
                ),
                const Text("Male")
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Radio<bool>(
                  groupValue: widget.isMale(),
                  value: false,
                  onChanged: (value) {
                    setState(() {
                      widget.onChanged(value);
                    });
                  },
                ),
                const Text("Female")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
