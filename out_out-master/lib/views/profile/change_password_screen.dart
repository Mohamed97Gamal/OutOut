import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/assets/logo_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/data/view_models/profile/change_password_request.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/fields/custom_password_form_field.dart';
import 'package:out_out/widgets/fields/custom_repeat_password_form_field.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showChangeLocation: false,
      headerHeight: 190.0,
      header: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Center(
          child: UniversalImage(LogoAssets.outout_blue_logo),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText("Change Password"),
              const SizedBox(height: 16.0),
              CustomPasswordFormField(
                name: "old_password",
                labelText: "Old Password",
                hintText: "********",
                isRequired: true,
              ),
              const SizedBox(height: 16.0),
              CustomPasswordFormField(
                name: "new_password",
                labelText: "New Password",
                controller: _passwordController,
                hintText: "********",
                isRequired: true,
              ),
              const SizedBox(height: 16.0),
              CustomRepeatPasswordFormField(
                name: "repeat_password",
                labelText: "Confirm New Password",
                hintText: "********",
                passwordController: _passwordController,
                isRequired: true,
              ),
              const SizedBox(height: 16.0),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  child: Text("Save"),
                  onPressed: () async {
                    var formState = _formKey.currentState;
                    if (formState == null) return;
                    if (!formState.saveAndValidate()) {
                      return;
                    }

                    var changePasswordResult = await showFutureProgressDialog<BooleanOperationResult>(
                      context: context,
                      initFuture: () async {
                        final request = new ChangePasswordRequest()
                          ..oldPassword = formState.value["old_password"]
                          ..newPassword = formState.value["new_password"];
                        return await ApiRepo().authClient.changePassword(request);
                      },
                    );
                    if (changePasswordResult != null && changePasswordResult.status) {
                      await showAdaptiveAlertDialog(
                        context: context,
                        icon: UniversalImage(IconAssets.done),
                        content: "Your password was changed successfully.",
                        showCloseButton: false,
                      );
                      Navigator.of(context).pop();
                    } else {
                      await showAdaptiveErrorDialog(
                        context: context,
                        title: "Error",
                        content: changePasswordResult?.errorMessage ?? "Unknown Error",
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
