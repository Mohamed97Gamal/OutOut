import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/widgets/fields/common/custom_form_field_wrapper.dart';
import 'package:out_out/widgets/universal_image.dart';

class CustomDateRangeFormField extends StatelessWidget {
  final String name;
  final String? labelText;
  final DateTime firstDate, lastDate;
  final String? hintText;

  final DateTimeRange? initialValue;

  const CustomDateRangeFormField({
    Key? key,
    required this.name,
    this.labelText,
    required this.firstDate,
    required this.lastDate,
    this.initialValue,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFormFieldWrapper(
      labelText: labelText,
      child: FormBuilderDateRangePicker(
        decoration: InputDecoration(
          hintText: hintText,
          suffixIconConstraints: BoxConstraints.tight(
            Size(35.0, 35.0),
          ),
          suffixIcon: Center(
            child: UniversalImage(
              IconAssets.calendar,
            ),
          ),
          errorMaxLines: 10,
        ),
        name: name,
        initialValue: initialValue,
        firstDate: firstDate,
        lastDate: lastDate,
      ),
    );
  }
}
