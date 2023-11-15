import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/utils/validators.dart';
import 'package:out_out/widgets/fields/common/custom_form_field_wrapper.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  final bool enabled;
  final String name;
  final String labelText;
  final String? hintText;
  final bool isRequired;
  final List<String? Function(T?, String?)> validators;
  final TextStyle? hintStyle;
  final T? initialValue;
  final Color? fillColor;
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final ValueChanged<T?>? onChanged;

  CustomDropdownFormField({
    Key? key,
    this.enabled = true,
    required this.name,
    required this.labelText,
    this.hintText,
    this.isRequired = false,
    this.initialValue,
    required this.items,
    required this.itemBuilder,
    this.onChanged,
    this.validators = const [],
    this.hintStyle,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFormFieldWrapper(
      labelText: isRequired ? "$labelText*" : labelText,
      child: FormBuilderDropdown<T>(
        name: name,
        enabled: enabled,
        decoration: InputDecoration(
          fillColor:fillColor,
          errorMaxLines: 10,
          hintText: hintText,
          hintStyle: hintStyle,
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
