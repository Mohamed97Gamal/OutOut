import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:out_out/utils/validators.dart';
import 'package:out_out/utils/value_transformers.dart';

class CustomPhoneNumberAccountFormField extends StatefulWidget {
  final Widget icon;
  final String? initialValue;
  final bool enabled;
  final String codeName;
  final String numberName;
  final String labelText;
  final String? hintText;
  final String? prefixText;
  final bool isRequired;
  final List<String? Function(String?, String?)> validators;
  final ValueChanged<String?>? onChanged;
  final int maxLines;

  const CustomPhoneNumberAccountFormField({
    Key? key,
    this.initialValue,
    this.enabled = true,
    required this.icon,
    required this.codeName,
    required this.numberName,
    required this.labelText,
    this.hintText,
    this.prefixText,
    this.validators = const [],
    this.isRequired = false,
    this.onChanged,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  _CustomPhoneNumberAccountFormFieldState createState() => _CustomPhoneNumberAccountFormFieldState();
}

class _CustomPhoneNumberAccountFormFieldState extends State<CustomPhoneNumberAccountFormField> {
  TextEditingController _codeController = TextEditingController(text: "+971");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: FormBuilderTextField(
              controller: _codeController,
              name: widget.codeName,
              enabled: false,
              style: TextStyle(color: Colors.black),
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
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.grey),
                prefixIconConstraints: BoxConstraints(minWidth: 40.0),
                prefixIcon: widget.icon,
              ),
            ),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: FormBuilderTextField(
              initialValue: widget.initialValue?.replaceAll("+971", ""),
              enabled: widget.enabled,
              name: widget.numberName,
              maxLines: widget.maxLines,
              style: TextStyle(
                color: widget.enabled ? Colors.black : Colors.grey,
              ),
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
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.phone,
              // valueTransformer: (text) => num.tryParse(text),
              validator: FormBuilderValidators.compose(
                <String? Function(String?)>[
                  if (widget.isRequired) (value) => Validators.isNotNullNorEmpty(value, widget.labelText),
                  (value) => (value != null && value != "")
                      ? Validators.phoneNumber("${_codeController.text}${value}", widget.labelText)
                      : Validators.phoneNumber(null, widget.labelText),
                  for (final validator in widget.validators) (value) => validator(value, widget.labelText),
                ],
              ),
              onChanged: widget.onChanged,
              valueTransformer: ValueTransformers.trim,
            ),
          ),
        ],
      ),
    );
  }
}
