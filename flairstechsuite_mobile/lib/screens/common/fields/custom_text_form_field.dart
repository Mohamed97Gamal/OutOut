import 'package:flairstechsuite_mobile/screens/common/fields/custom_form_field_wrapper.dart';
import 'package:flairstechsuite_mobile/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

  class CustomTextFormField extends StatelessWidget {
  final String? initialValue;
  final bool enabled;
  final String name;
  final String labelText;
  final String? hintText;
  final bool isRequired;
  final List<String Function(String, String)> validators;
  final ValueChanged<String?>? onChanged;
  final int maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    Key? key,
    this.initialValue,
    this.enabled = true,
    required this.name,
    required this.labelText,
    this.hintText,
    this.validators = const [],
    this.isRequired = false,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFormFieldWrapper(
      child: FormBuilderTextField(
        initialValue: initialValue,
        enabled: enabled,
        name: name,
        maxLines: maxLines,
        style: TextStyle(
          color: enabled ? Colors.black : Colors.grey,
        ),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: isRequired ? "$labelText*" : labelText,
          errorMaxLines: 1,
          labelStyle: TextStyle(color: Colors.grey),
          hintText: hintText,
        ),
        // valueTransformer: (text) => num.tryParse(text),
        validator: (isRequired)
            ? (value) => isNotNullNorEmpty(value, labelText)
            : validator,
        onChanged: onChanged,
        // valueTransformer: ValueTransformers.trim,
      ),
    );
  }
}
