import 'package:flairstechsuite_mobile/widgets/form_fields/date_form_field.dart';
import 'package:flutter/material.dart';

class DateRange {
  DateTime? startDate, endDate;

  DateRange.fromStartEnd(this.startDate, this.endDate);

  DateRange.newEntry() {
    startDate = DateTime.now().subtract(
      const Duration(days: 1),
    );
    endDate = DateTime.now();
  }
}

class DateRangeFormField extends FormField<DateRange> {
  DateRangeFormField({
    DateRange? initialValue,
    FormFieldValidator<DateRange>? validator,
    required ValueChanged<DateRange> onValueChanged,
    DateTime? firstDate,
    DateTime? lastDate,
  }) : super(
            initialValue: initialValue ?? DateRange.newEntry(),
            autovalidateMode: AutovalidateMode.disabled,
            validator: validator,
            builder: (field) {
              final state = field as _DateFormFieldState;
              return DateFormFieldWidget(
                (value) {
                  state.didChange(value);
                  onValueChanged(value!);
                },
                state.value,
                validator,
                firstDate: firstDate,
                lastDate: lastDate,
              );
            });

  @override
  _DateFormFieldState createState() => _DateFormFieldState();
}

class _DateFormFieldState extends FormFieldState<DateRange> {}

class DateFormFieldWidget extends StatelessWidget {
  final DateRange? selectedDateRange;
  final ValueChanged<DateRange?> onValueChanged;
  final FormFieldValidator<DateRange>? validator;

  final DateTime? firstDate;
  final DateTime? lastDate;

  const DateFormFieldWidget(
    this.onValueChanged,
    this.selectedDateRange,
    this.validator, {
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        errorText: validator != null ? validator!(selectedDateRange) : null,
        border: InputBorder.none,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: DateFormField(
              labelText: "From *",
              initialValue: selectedDateRange!.startDate,
              onValueChanged: (s) {
                selectedDateRange!.startDate = s;
                onValueChanged(selectedDateRange);
              },
              firstDate: firstDate,
              lastDate: lastDate,
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: DateFormField(
              labelText: "To *",
              initialValue: selectedDateRange!.endDate,
              onValueChanged: (s) {
                selectedDateRange!.endDate = s;
                onValueChanged(selectedDateRange);
              },
              validator: (s) {
                return s!.isAfter(selectedDateRange!.startDate!) || s.isAtSameMomentAs(selectedDateRange!.startDate!)
                    ? null
                    : "End date must be after 'Start Date'.";
              },
              firstDate: firstDate,
              lastDate: lastDate,
            ),
          ),
        ],
      ),
    );
  }
}
