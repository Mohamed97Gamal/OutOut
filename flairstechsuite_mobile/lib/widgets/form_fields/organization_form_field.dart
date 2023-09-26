import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/models/organization_dto.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/widgets/basic/custom_picker.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flutter/material.dart';

class OrganizationFormField extends FormField<OrganizationDTO> {
  OrganizationFormField({
    FormFieldValidator<OrganizationDTO>? validator,
    ValueChanged<OrganizationDTO>? onValueChanged,
  }) : super(
            autovalidateMode: AutovalidateMode.disabled,
            validator: validator,
            builder: (field) {
              final state = field as _OrganizationFormFieldState;
              return OrganizationFormFieldWidget(
                (value) {
                  state.didChange(value);
                  onValueChanged!(value!);
                },
                state.value,
                validator,
              );
            });

  @override
  _OrganizationFormFieldState createState() => _OrganizationFormFieldState();
}

class _OrganizationFormFieldState extends FormFieldState<OrganizationDTO> {}

class OrganizationFormFieldWidget extends StatelessWidget {
  final OrganizationDTO? selectedOrganization;
  final ValueChanged<OrganizationDTO?> onValueChanged;
  final FormFieldValidator<OrganizationDTO>? validator;

  const OrganizationFormFieldWidget(this.onValueChanged, this.selectedOrganization, this.validator);

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<OrganizationDTOListResponse>(
      initFuture: () async {
        final response = await Repository().getOrganizationsDetails();
        onValueChanged(response.result!.first);
        return response;
      },
      onSuccess: (context, snapshot) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: "Organization *",
            errorText: validator != null ? validator!(selectedOrganization) : null,
          ),
          child: AdaptivePicker<OrganizationDTO?>(
            withUnderline: false,
            //decorationLabelText: "Organization : ",
            items: <DropdownMenuItem<OrganizationDTO>>[
              for (final org in snapshot.data!.result!)
                DropdownMenuItem<OrganizationDTO>(
                  value: org,
                  child: Text("${org.name}"),
                ),
            ],
            onChanged: (organization) {
              onValueChanged(organization);
            },
            value: selectedOrganization,
          ),
        );
      },
    );
  }
}
