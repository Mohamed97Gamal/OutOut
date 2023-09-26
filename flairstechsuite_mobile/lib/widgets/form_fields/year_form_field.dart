import 'package:flairstechsuite_mobile/widgets/basic/custom_picker.dart';
import 'package:flutter/material.dart';

class YearFormField extends FormField<int> {
  YearFormField({
    required int initialValue,
    FormFieldValidator<int>? validator,
    required ValueChanged<int> onValueChanged,
    String? labelText,
    required int firstYear,
    required int lastYear,
  }) : super(
            autovalidateMode: AutovalidateMode.disabled,
            validator: validator,
            initialValue: initialValue,
            builder: (field) {
              final state = field as _YearFormFieldState;
              return YearFormFieldWidget(
                (value) {
                  state.didChange(value);
                  onValueChanged(value!);
                },
                state.value,
                validator,
                labelText: labelText,
                firstYear: firstYear,
                lastYear: lastYear,
              );
            });

  @override
  _YearFormFieldState createState() => _YearFormFieldState();
}

class _YearFormFieldState extends FormFieldState<int> {}

class YearFormFieldWidget extends StatelessWidget {
  final int? selectedYear;
  final ValueChanged<int?> onValueChanged;
  final FormFieldValidator<int>? validator;
  final String? labelText;
  final int? firstYear;
  final int? lastYear;

  const YearFormFieldWidget(
    this.onValueChanged,
    this.selectedYear,
    this.validator, {
    this.labelText,
    this.firstYear,
    this.lastYear,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        errorText: validator != null ? validator!(selectedYear) : null,
      ),
      child: AdaptivePicker<int?>(
        withUnderline: false,
        //decorationLabelText: "Year : ",
        items: <DropdownMenuItem<int>>[
          for (final year in List.generate((lastYear! - firstYear!) + 1, (index) => firstYear! + index))
            DropdownMenuItem<int>(
              value: year,
              child: Text("$year"),
            ),
        ],
        onChanged: (organization) {
          onValueChanged(organization);
        },
        value: selectedYear,
      ),
    );
  }
}
