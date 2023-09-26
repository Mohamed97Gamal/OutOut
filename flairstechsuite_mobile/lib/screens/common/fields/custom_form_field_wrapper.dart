import 'package:flutter/material.dart';

class CustomFormFieldWrapper extends StatelessWidget {
  final String? labelText;
  final Widget child;

  CustomFormFieldWrapper({
    Key? key,
    this.labelText,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (labelText != null && labelText!.isNotEmpty)
          Text(
            labelText!,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        if (labelText != null && labelText!.isNotEmpty)
          const SizedBox(height: 2.0),
        child,
      ],
    );
  }
}
