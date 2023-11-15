import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:out_out/utils/validators.dart';
import 'package:out_out/widgets/fields/common/custom_form_field_wrapper.dart';

class CustomDateFormField extends StatelessWidget {
  final bool enabled;
  final String name;
  final String labelText;
  final String? hintText;
  final bool isRequired;

  final DateTime? firstDate, lastDate;
  final bool Function(DateTime)? selectableDayPredicate;
  final DateTime? initialValue;
  final List<String? Function(DateTime?, String?)> validators;
  final ValueChanged<DateTime?>? onChanged;

  const CustomDateFormField({
    Key? key,
    this.enabled = true,
    required this.name,
    required this.labelText,
    this.hintText,
    this.firstDate,
    this.lastDate,
    this.selectableDayPredicate,
    this.initialValue,
    this.validators = const [],
    this.isRequired = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFormFieldWrapper(
      labelText: isRequired ? "$labelText*" : labelText,
      child: FormBuilderDateTimePicker(
        enabled: enabled,
        name: name,
        decoration: InputDecoration(
          errorMaxLines: 10,
          hintText: hintText,
          suffixIcon: Icon(Icons.calendar_today_outlined),
        ),
        format: DateFormat("${DateFormat.WEEKDAY} ${DateFormat.DAY} ${DateFormat.ABBR_MONTH}"),
        inputType: InputType.date,
        firstDate: firstDate,
        lastDate: lastDate,
        selectableDayPredicate: selectableDayPredicate,
        initialValue: initialValue,
        validator: FormBuilderValidators.compose(
          <String? Function(DateTime?)>[
            if (isRequired) (value) => Validators.required(value, labelText),
            for (final validator in validators) (value) => validator(value, labelText),
          ],
        ),
        onChanged: onChanged,
      ),
    );
  }
}
