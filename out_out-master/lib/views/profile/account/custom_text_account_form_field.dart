import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:out_out/utils/validators.dart';
import 'package:out_out/utils/value_transformers.dart';

class CustomTextAccountFormField extends StatelessWidget {
  final Widget icon;
  final String? hintText;
  final TextInputType? textInputType;
  final List<String? Function(String?, String?)> validators;
  final ValueChanged<String?>? onChanged;
  final String name;
  final String labelText;
  final String? initialValue;
  final bool isRequired;
  final bool isEnabled;

  const CustomTextAccountFormField({
    Key? key,
    this.isEnabled = true,
    required this.name,
    required this.labelText,
    this.initialValue,
    required this.icon,
    this.hintText,
    this.textInputType,
    this.onChanged,
    this.validators = const [],
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FormBuilderTextField(
        style: !isEnabled?TextStyle(color: Color(0xffc3c3c3)):TextStyle(color: Colors.black),
        enabled: isEnabled,
        name: name,
        initialValue: initialValue,
        onChanged: onChanged,
        cursorColor: Colors.black,
        keyboardType: textInputType,
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
        validator: FormBuilderValidators.compose(
          <String? Function(String?)>[
            if (isRequired) (value) => Validators.isNotNullNorEmpty(value, labelText),
            for (final validator in validators) (value) => validator(value, labelText),
          ],
        ),
        valueTransformer: ValueTransformers.trim,
      ),
    );
  }
}