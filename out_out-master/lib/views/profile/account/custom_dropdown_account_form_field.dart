import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/utils/validators.dart';

class CustomDropdownAccountFormField<T> extends StatelessWidget {
  final bool enabled;
  final String name;
  final String labelText;
  final String? hintText;
  final bool isRequired;
  final List<String? Function(T?, String?)> validators;
  final Widget? icon;
  final T? initialValue;
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final ValueChanged<T?>? onChanged;

  CustomDropdownAccountFormField({
    Key? key,
    this.enabled = true,
    required this.name,
    required this.labelText,
    this.hintText,
    this.icon,
    this.isRequired = false,
    this.initialValue,
    required this.items,
    required this.itemBuilder,
    this.onChanged,
    this.validators = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FormBuilderDropdown<T>(
        name: name,
        decoration: InputDecoration(
          errorMaxLines: 10,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          filled: false,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIconConstraints: BoxConstraints(minWidth: 40.0),
          prefixIcon: icon,
        ),
        items: <DropdownMenuItem<T>>[
          for (var item in items)
            DropdownMenuItem(
              value: item,
              child: itemBuilder(context, item),
            ),
        ],
        initialValue: initialValue,
        onChanged: enabled ? onChanged : null,
        autovalidateMode: AutovalidateMode.disabled,
        validator: (T? value) {
          var validatorsList = <String? Function(T?)>[
            if (isRequired) (value) => Validators.required(value, labelText),
            for (final validator in validators) (value) => validator(value, labelText),
          ];
          for (var validator in validatorsList) {
            var validationResult = validator(value);
            if (validationResult != null) {
              return validationResult;
            }
          }
          return null;
        },
      ),
    );
  }
}
