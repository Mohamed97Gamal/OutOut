import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/models/enums/issue_types.dart';
import 'package:out_out/data/view_models/profile/customer_support_request.dart';
import 'package:out_out/data/view_models/profile/customer_support_response_operation_result.dart';
import 'package:out_out/utils/validators.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/fields/custom_dropdown_form_field.dart';
import 'package:out_out/widgets/fields/custom_phone_number_form_field.dart';
import 'package:out_out/widgets/fields/custom_text_form_field.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class CustomerServiceScreen extends StatefulWidget {
  CustomerServiceScreen({Key? key}) : super(key: key);

  @override
  _CustomerServiceScreenState createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showChangeLocation: true,
      headerHeight: 150.0,
      header: HeaderTitleText("Customer Service"),
      body: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Suggestions, questions, constructive criticism or even just to say hello - get in touch, we're listening.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                name: "full_name",
                labelText: "Full Name",
                initialValue: context.read<MyAccountProvider>().applicationUserResponse.fullName,
                isRequired: true,
                validators: [Validators.fullName],
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                name: "email",
                labelText: "Email",
                initialValue: context.read<MyAccountProvider>().applicationUserResponse.email,
                enabled: false,
                validators: [Validators.email],
              ),
              const SizedBox(height: 16.0),
              CustomPhoneNumberFormField(
                codeName: "phone_number_code",
                numberName: "phone_number_number",
                labelText: "Phone Number",
                initialValue: context.read<MyAccountProvider>().applicationUserResponse.phoneNumber ?? "",
                isRequired: false,
              ),
              const SizedBox(height: 16.0),
              CustomDropdownFormField<IssueTypes>(
                name: "issue_type",
                labelText: "Issue type",
                hintText: "Select Issue type",
                isRequired: true,
                items: IssueTypes.availableValues,
                itemBuilder: (context, item) => Text(item.name),
                validators: [],
                onChanged: (value) {},
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                name: "description",
                labelText: "Description",
                hintText: "Message",
                isRequired: true,
                maxLines: 10,
                validators: [Validators.description],
              ),
              const SizedBox(height: 40.0),
              Container(
                width: double.maxFinite,
                height: 40.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shadowColor: Theme.of(context).primaryColor),
                  child: Text(
                    "Send",
                    style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                  ),
                  onPressed: () async {
                    var formState = _formKey.currentState;
                    if (formState == null) return;
                    if (!formState.saveAndValidate()) {
                      return;
                    }

                    var newCustomerSupportResult =
                        await showFutureProgressDialog<CustomerSupportResponseOperationResult>(
                      context: context,
                      initFuture: () async {
                        final request = new CustomerSupportRequest()
                          ..fullName = formState.value["full_name"]
                          ..description = formState.value["description"]
                          ..issueType = formState.value["issue_type"] as IssueTypes
                          ..phoneNumber = formState.value["phone_number_number"] != null &&
                                  formState.value["phone_number_number"] != ""
                              ? formState.value["phone_number_code"] + formState.value["phone_number_number"]
                              : null;
                        return await ApiRepo().customerSupportClient.postNewRequest(request);
                      },
                    );
                    if (newCustomerSupportResult != null && newCustomerSupportResult.status) {
                      await showAdaptiveAlertDialog(
                        context: context,
                        icon: UniversalImage(IconAssets.done),
                        title: "Message delivered",
                        content: "Thank you, your message was delivered to the customer service.",
                        showCloseButton: false,
                      );
                      Navigator.of(context).maybePop();
                    } else {
                      await showAdaptiveErrorDialog(
                        context: context,
                        title: "Error",
                        content: newCustomerSupportResult?.errorMessage ?? "Unknown Error",
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
