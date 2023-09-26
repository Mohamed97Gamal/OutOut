import 'package:flutter/material.dart';

class ReadOnlyStringField extends StatelessWidget {
  final String? label, value;

  const ReadOnlyStringField({Key? key, this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
      ),
      child: Text(
        value!,
        style: const TextStyle(fontSize: 17.0),
      ),
    );
  }
}
