import 'package:flairstechsuite_mobile/features/cycles/data/model/cycle/cycle_dto.dart';
import 'package:flairstechsuite_mobile/features/cycles/data/repository/cycle_repository_impl.dart';
import 'package:flairstechsuite_mobile/widgets/basic/custom_picker.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CycleCountryFormField extends FormField<CycleCountryDTO> {
  CycleCountryFormField({
    FormFieldValidator<CycleCountryDTO>? validator,
    ValueChanged<CycleCountryDTO>? onValueChanged,
  }) : super(
            autovalidateMode: AutovalidateMode.disabled,
            validator: validator,
            builder: (field) {
              final state = field as _CycleCountryFormFieldState;
              return CycleCountryFormFieldWidget(
                (value) {
                  state.didChange(value);
                 if(value!=null) onValueChanged!(value);
                },
                state.value,
                validator,
              );
            });

  @override
  _CycleCountryFormFieldState createState() => _CycleCountryFormFieldState();
}

class _CycleCountryFormFieldState extends FormFieldState<CycleCountryDTO> {}

class CycleCountryFormFieldWidget extends StatelessWidget {
  final CycleCountryDTO? selectedCycleCountry;
  final ValueChanged<CycleCountryDTO?> onValueChanged;
  final FormFieldValidator<CycleCountryDTO>? validator;

  const CycleCountryFormFieldWidget(
      this.onValueChanged, this.selectedCycleCountry, this.validator);

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<CycleCountryDTOListResponse>(
      initFuture: () async {
        final response = await CycleRepositoryImpl().getAllCycleCountries();
        onValueChanged(response.result!.first);
        return response;
      },
      onSuccess: (context, snapshot) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: "Country *",
              labelStyle: TextStyle(
          color: Colors.grey,
          ),hintStyle: TextStyle(color: Colors.grey),
            errorText:
                validator != null ? validator!(selectedCycleCountry) : null,
          ),
          child: AdaptivePicker<CycleCountryDTO?>(
            withUnderline: false,
            //decorationLabelText: "CycleCountry : ",
            items: <DropdownMenuItem<CycleCountryDTO>>[
              for (final org in snapshot.data!.result!)
                DropdownMenuItem<CycleCountryDTO>(
                  value: org,
                  child: Text("${org.name}"),
                ),
            ],
            onChanged: (cycleCountry) {
              onValueChanged(cycleCountry);
            },
            value: selectedCycleCountry,
          ),
        );
      },
    );
  }
}
