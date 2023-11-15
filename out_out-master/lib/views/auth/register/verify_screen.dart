import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/assets/logo_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/disk/disk_repo.dart';
import 'package:out_out/data/memory/memory_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/models/tokens_data.dart';
import 'package:out_out/data/view_models/auth/login_response_operation_result.dart';
import 'package:out_out/data/view_models/auth/verify_account_request.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/fields/custom_otp_form_field.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class VerifyScreen extends StatefulWidget {
  final String email;

  VerifyScreen({
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> with RouteAware {
  final _formKey = GlobalKey<FormBuilderState>();
  final _otpController = TextEditingController();


  @override
  void didPop() {
    super.didPop();
    Navigation().navToLoginScreen(context);
  }

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
              TitleText("Enter 6-digit Verification Code"),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: Text("The verification code was sent to your email, Please enter the code."),
              ),
              const SizedBox(height: 24.0),
              CustomOTPFormField(
                name: "otp_code",
                isRequired: true,
                controller: _otpController,
              ),
              const SizedBox(height: 16.0),
              ResendOTP(email: widget.email),
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

                    var verifyResult = await showFutureProgressDialog<LoginResponseOperationResult>(
                      context: context,
                      initFuture: () async {
                        final request = new VerifyAccountRequest()
                          ..email = widget.email
                          ..otp = formState.value["otp_code"];
                        return await ApiRepo().tokenClient.verifyAccount(request);
                      },
                    );
                    if (verifyResult != null && verifyResult.status) {
                      await showAdaptiveAlertDialog(
                        context: context,
                        icon: UniversalImage(IconAssets.done),
                        title: "Congratulations",
                        content: "Your account has been successfully verified.",
                        showCloseButton: false,
                      );
                      final tokensData = TokensData.fromLoginResponse(verifyResult.result);
                      MemoryRepo().updateTokensData(tokensData);
                      await DiskRepo().updateTokensData(tokensData);
                      context.read<MyAccountProvider>().update(verifyResult.result.user, firstTime: true);
                      Navigation().navToHomeScreen(context);
                    } else {
                      _otpController.clear();
                      await showAdaptiveErrorDialog(
                        context: context,
                        title: "Error",
                        content: verifyResult?.errorMessage ?? "Unknown Error",
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

class ResendOTP extends StatelessWidget {
  final String email;

  const ResendOTP({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Didn't receive the code? ",
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: 'Resend',
              style: TextStyle(color: Colors.blue),
              recognizer: new TapGestureRecognizer()
                ..onTap = () async {
                  var verifyResult = await showFutureProgressDialog<BooleanOperationResult>(
                    context: context,
                    initFuture: () async {
                      return await ApiRepo().authClient.resendVerificationEmail(email);
                    },
                  );
                  if (verifyResult != null && verifyResult.status) {
                    await showAdaptiveAlertDialog(
                      context: context,
                      icon: UniversalImage(IconAssets.done),
                      title: "Resent Verification Code",
                      content: "Your verification code has been resent to your email.",
                      showCloseButton: false,
                    );
                  } else {
                    await showAdaptiveErrorDialog(
                      context: context,
                      title: "Error",
                      content: verifyResult?.errorMessage ?? "Unknown Error",
                    );
                  }
                },
            ),
          ],
        ),
      ),
    );
  }
}
