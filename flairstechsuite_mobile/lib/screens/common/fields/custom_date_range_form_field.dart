import 'package:flairstechsuite_mobile/screens/common/fields/custom_form_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class CustomDateRangeFormField extends StatelessWidget {
  final String name;
  final String? labelText;
  final DateTime? firstDate, lastDate;
  final String? hintText;
  final bool enabled;
  final TextAlign textAlign;
  final DateTimeRange? initialValue;
final TextEditingController? controller;
final void Function(DateTimeRange?)? onChanged;
final String? Function(DateTimeRange?)? validator;
  final Color iconColor;
  const CustomDateRangeFormField({
    Key? key,
    required this.name,
    this.labelText,
    this.enabled = true,
     this.firstDate,
    this.lastDate,
    this.initialValue,
    this.hintText,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.controller,
    this.validator,
    this.iconColor = Colors.black45,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFormFieldWrapper(
      labelText: labelText,
      child: FormBuilderDateRangePicker(
        format: DateFormat("dd/MM/yyyy"),
        enabled: enabled,
        controller: controller,
        textAlign: textAlign,
        decoration: InputDecoration(
        labelStyle: TextStyle(
        color: Colors.grey,
        ),hintStyle: TextStyle(color: Colors.grey),
          hintText: hintText,
          suffixIconConstraints: BoxConstraints.tight(
            Size(35.0, 35.0),
          ),
          suffixIcon: Icon(
            Icons.date_range_rounded,
            color: iconColor,
          ),
        ),
        name: name,
        initialValue: initialValue,
        firstDate: firstDate??DateTime.now(),
        onChanged: onChanged,
        lastDate: lastDate??DateTime.now(),
        validator: validator,
      ),
    );
  }
}
