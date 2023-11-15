import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/assets/logo_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/view_models/auth/verify_reset_password_request.dart';
import 'package:out_out/data/view_models/basic/string_operation_result.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/fields/custom_otp_form_field.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';

class VerifyResetPasswordScreen extends StatefulWidget {
  final String email;

  VerifyResetPasswordScreen({
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  _VerifyResetPasswordScreenState createState() => _VerifyResetPasswordScreenState();
}

class _VerifyResetPasswordScreenState extends State<VerifyResetPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
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
              TitleText("Enter 6-digit Recovery Code"),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: Text("The recovery code was sent to your email, Please enter the code."),
              ),
              const SizedBox(height: 24.0),
              CustomOTPFormField(
                name: "otp_code",
                isRequired: true,
                controller: _otpController,
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

                    var verifyResetPasswordResult = await showFutureProgressDialog<StringOperationResult>(
                      context: context,
                      initFuture: () async {
                        final request = new VerifyResetPasswordRequest()
                          ..email = widget.email
                          ..otp = formState.value["otp_code"];
                        return await ApiRepo().authClient.verifyResetPassword(request);
                      },
                    );
                    if (verifyResetPasswordResult != null && verifyResetPasswordResult.status) {
                      Navigation().navToResetPasswordScreen(
                        context,
                        email: widget.email,
                        hashedOtp: verifyResetPasswordResult.result!,
                      );
                    } else {
                      _otpController.clear();
                      await showAdaptiveErrorDialog(
                        context: context,
                        title: "Error",
                        content: verifyResetPasswordResult?.errorMessage ?? "Unknown Error",
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
