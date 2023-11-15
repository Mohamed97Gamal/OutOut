import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/assets/logo_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/view_models/auth/reset_password_request.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/fields/custom_password_form_field.dart';
import 'package:out_out/widgets/fields/custom_repeat_password_form_field.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/universal_image.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String hashedOtp;

  ResetPasswordScreen({
    required this.email,
    required this.hashedOtp,
    Key? key,
  }) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();

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
              CustomPasswordFormField(
                name: "new_password",
                labelText: "New Password",
                hintText: "********",
                controller: _passwordController,
                isRequired: true,
              ),
              const SizedBox(height: 16.0),
              CustomRepeatPasswordFormField(
                name: "repeat_password",
                labelText: "Repeat Password",
                hintText: "********",
                passwordController: _passwordController,
                isRequired: true,
              ),
              const SizedBox(height: 16.0),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  child: Text("Next"),
                  onPressed: () async {
                    var formState = _formKey.currentState;
                    if (formState == null) return;
                    if (!formState.saveAndValidate()) {
                      return;
                    }

                    var resetPasswordResult = await showFutureProgressDialog<BooleanOperationResult>(
                      context: context,
                      initFuture: () async {
                        final request = new ResetPasswordRequest()
                          ..email = widget.email
                          ..hashedOtp = widget.hashedOtp
                          ..newPassword = formState.value["new_password"];
                        return await ApiRepo().authClient.resetPassword(request);
                      },
                    );
                    if (resetPasswordResult != null && resetPasswordResult.status) {
                      await showAdaptiveAlertDialog(
                        context: context,
                        icon: UniversalImage(IconAssets.done),
                        title: "Reset Password",
                        content: "You have changed your password successfully",
                        showCloseButton: false,
                      );
                      Navigation().navToLoginScreen(context);
                    } else {
                      _otpController.clear();
                      await showAdaptiveErrorDialog(
                        context: context,
                        title: "Error",
                        content: resetPasswordResult?.errorMessage ?? "Unknown Error",
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
