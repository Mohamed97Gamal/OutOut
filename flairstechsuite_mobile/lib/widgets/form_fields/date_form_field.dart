import 'package:flairstechsuite_mobile/widgets/basic/edit_fields.dart';
import 'package:flutter/material.dart';

class DateFormField extends FormField<DateTime> {
  DateFormField({
    String labelText = "Date",
    DateTime? initialValue,
    FormFieldValidator<DateTime>? validator,
    required ValueChanged<DateTime> onValueChanged,
    DateTime? firstDate,
    DateTime? lastDate,
  }) : super(
            initialValue: initialValue ?? DateTime.now(),
            autovalidateMode: AutovalidateMode.disabled,
            validator: validator,
            builder: (field) {
              final state = field as _DateFormFieldState;
              return DateFormFieldWidget(
                (value) {
                  state.didChange(value);
                  onValueChanged(value);
                },
                state.value,
                validator,
                labelText: labelText,
                firstDate: firstDate,
                lastDate: lastDate,
              );
            });

  @override
  _DateFormFieldState createState() => _DateFormFieldState();
}

class _DateFormFieldState extends FormFieldState<DateTime> {}

class DateFormFieldWidget extends StatelessWidget {
  final DateTime? selectedDateTime;
  final ValueChanged<DateTime> onValueChanged;
  final FormFieldValidator<DateTime>? validator;
  final String? labelText;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DateFormFieldWidget(
    this.onValueChanged,
    this.selectedDateTime,
    this.validator, {
    this.labelText,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        errorText: validator != null ? validator!(selectedDateTime) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DateTimePicker(
          selectedDate: selectedDateTime,
          selectDate: (date) {
            onValueChanged(date);
          },
          firstDate: firstDate,
          lastDate: lastDate,
        ),
      ),
    );
  }
}
