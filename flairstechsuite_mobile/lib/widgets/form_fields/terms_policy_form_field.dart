import 'package:flairstechsuite_mobile/repo/api/api_helper.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/utils/url_launcher_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_dialog.dart' as dia;
import 'package:flutter/material.dart';

class TermsPolicyFormField extends FormField<bool> {
  TermsPolicyFormField({
    bool initialValue = false,
    FormFieldValidator<bool>? validator,
    ValueChanged<bool>? onValueChanged,
  }) : super(
            initialValue: initialValue,
            autovalidateMode: AutovalidateMode.disabled,
            validator: validator ?? ((b) => b ? null : "Please accept the terms & policy.") as String? Function(bool?)?,
            builder: (field) {
              final state = field as _TermsPolicyFormFieldState;
              return TermsPolicyFormFieldWidget(
                (value) {
                  state.didChange(value);
                  if (onValueChanged != null) onValueChanged(value!);
                },
                state.value,
                validator ?? (b) => b! ? null : "Please accept the terms & policy.",
              );
            });

  @override
  _TermsPolicyFormFieldState createState() => _TermsPolicyFormFieldState();
}

class _TermsPolicyFormFieldState extends FormFieldState<bool> {}

class TermsPolicyFormFieldWidget extends StatelessWidget {
  final bool? agreedToTerms;
  final ValueChanged<bool?> onValueChanged;
  final FormFieldValidator<bool> validator;

  const TermsPolicyFormFieldWidget(this.onValueChanged, this.agreedToTerms, this.validator);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(2.0),
        errorText: validator(agreedToTerms),
      ),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: agreedToTerms,
        onChanged: (value) {
          onValueChanged(value);
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text("I Agree to "),
            InkWell(
              onTap: () {
                dia.showAdaptiveDialog(
                  context: context,
                  builder: (context) => AdaptiveAlertDialog(
                    title: const Text("Terms"),
                    content: const SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: Text(ResourcesUtils.placeHolderText),
                    ),
                    actions: [
                      AdaptiveAlertDialogAction(
                        isPrimary: true,
                        title: "Ok",
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      AdaptiveAlertDialogAction(
                        title: "Open",
                        onPressed: () => launchURL("${ApiHelper.getNormalLink("terms")}"),
                      ),
                    ],
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8.0),
                child: Text(
                  "Terms",
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.5,
                  ),
                ),
              ),
            ),
            const Text(" & "),
            InkWell(
              onTap: () {
                dia.showAdaptiveDialog(
                  context: context,
                  builder: (context) => AdaptiveAlertDialog(
                    title: const Text("Policy"),
                    content: const SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: Text(ResourcesUtils.placeHolderText),
                    ),
                    actions: [
                      AdaptiveAlertDialogAction(
                        isPrimary: true,
                        title: "Ok",
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      AdaptiveAlertDialogAction(
                        title: "Open",
                        onPressed: () => launchURL("${ApiHelper.getNormalLink("terms")}"),
                      ),
                    ],
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8.0),
                child: Text(
                  "Policy",
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.5,
                  ),
                ),
              ),
            ),
            const Text("."),
          ],
        ),
      ),
    );
  }
}
