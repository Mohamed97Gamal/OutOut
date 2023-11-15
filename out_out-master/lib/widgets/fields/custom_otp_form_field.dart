import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:out_out/utils/validators.dart';
import 'package:out_out/widgets/fields/common/custom_form_field_wrapper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomOTPFormField extends StatelessWidget {
  final int length;

  final bool enabled;
  final String name;
  final String? labelText;
  final String? hintText;
  final bool isRequired;

  final EdgeInsets padding;
  final TextEditingController? controller;
  final String? initialValue;
  final List<String? Function(String?, String?)> validators;
  final ValueChanged<String?>? onChanged;

  const CustomOTPFormField({
    Key? key,
    this.length = 6,
    this.enabled = true,
    required this.name,
    this.labelText,
    this.hintText,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.initialValue,
    this.validators = const [],
    this.isRequired = false,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFormFieldWrapper(
      labelText: labelText,
      child: FormBuilderField<String>(
        enabled: enabled,
        name: name,
        initialValue: initialValue,
        validator: FormBuilderValidators.compose(
          <String? Function(String?)>[
            if (isRequired)
              (value) => Validators.isNotNullNorEmpty(value, labelText),
            for (final validator in validators)
              (value) => validator(value, labelText),
          ],
        ),
        onChanged: onChanged,
        builder: (field) {
          var fieldWidth = (MediaQuery.of(context).size.width -
                  (padding.left + padding.right)) /
              (length * 1.3);
          return Padding(
            padding: padding,
            child: InputDecorator(
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                errorMaxLines: 10,
                hintText: hintText,
                suffixIcon: Icon(Icons.calendar_today_outlined),
                errorText: field.errorText,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              child: PinCodeTextField(
                pinTheme: PinTheme(
                  fieldWidth: fieldWidth,
                  fieldHeight: fieldWidth,
                  borderWidth: 2.0,
                  activeColor: Colors.transparent,
                  activeFillColor: Color(0xFFF9F9F9),
                  selectedColor: Colors.transparent,
                  selectedFillColor: Color(0xFFF9F9F9),
                  inactiveColor: Colors.transparent,
                  inactiveFillColor: Color(0xFFF9F9F9),
                ),
                controller: controller,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                backgroundColor: Colors.transparent,
                keyboardType: TextInputType.number,
                enableActiveFill: true,
                enablePinAutofill: false,
                textStyle: TextStyle(
                  color: Color(0xFFB1B1B1),
                ),
                length: length,
                appContext: context,
                onChanged: (value) => field.didChange(value),
              ),
            ),
          );
        },
      ),
    );
  }
}
