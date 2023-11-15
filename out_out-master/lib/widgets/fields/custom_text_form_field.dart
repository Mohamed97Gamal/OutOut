import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:out_out/utils/validators.dart';
import 'package:out_out/utils/value_transformers.dart';
import 'package:out_out/widgets/fields/common/custom_form_field_wrapper.dart';

class CustomTextFormField extends StatelessWidget {
  final String? initialValue;
  final bool enabled;
  final String name;
  final String labelText;
  final String? hintText;
  final bool isRequired;
  final List<String? Function(String?, String?)> validators;
  final ValueChanged<String?>? onChanged;
  final int maxLines;
  final TextInputType keyboardType;

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFormFieldWrapper(
      labelText: isRequired ? "$labelText*" : labelText,
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
          errorMaxLines: 10,
          hintText: hintText,
        ),
        // valueTransformer: (text) => num.tryParse(text),
        validator: FormBuilderValidators.compose(
          <String? Function(String?)>[
            if (isRequired) (value) => Validators.isNotNullNorEmpty(value, labelText),
            for (final validator in validators) (value) => validator(value, labelText),
          ],
        ),
        onChanged: onChanged,
        valueTransformer: ValueTransformers.trim,
      ),
    );
  }
}
