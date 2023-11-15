import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:out_out/utils/validators.dart';
import 'package:out_out/widgets/fields/common/custom_form_field_wrapper.dart';

class CustomLoginPasswordFormField extends StatefulWidget {
  final String? initialValue;
  final String name;
  final String labelText;
  final String? hintText;
  final bool isRequired;
  final List<String? Function(String?, String?)> validators;

  const CustomLoginPasswordFormField({
    Key? key,
    this.initialValue,
    required this.name,
    required this.labelText,
    this.hintText,
    this.isRequired = false,
    this.validators = const [],
  }) : super(key: key);

  @override
  _CustomLoginPasswordFormFieldState createState() => _CustomLoginPasswordFormFieldState();
}

class _CustomLoginPasswordFormFieldState extends State<CustomLoginPasswordFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomFormFieldWrapper(
      labelText: widget.isRequired ? "${widget.labelText}*" : widget.labelText,
      child: FormBuilderTextField(
        initialValue: widget.initialValue,
        name: widget.name,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() => obscureText = !obscureText);
            },
          ),
          errorMaxLines: 10,
          hintText: widget.hintText,
        ),
        obscureText: obscureText,
        obscuringCharacter: "*",
        validator: FormBuilderValidators.compose(
          <String? Function(String?)>[
            if (widget.isRequired) (value) => Validators.isNotNullNorEmpty(value, widget.labelText),
            (value) => Validators.loginPassword(value, widget.labelText),
            for (final validator in widget.validators) (value) => validator(value, widget.labelText),
          ],
        ),
      ),
    );
  }
}
