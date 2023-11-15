import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/assets/logo_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/fields/custom_email_form_field.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

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
              TitleText("Forget Password"),
              const SizedBox(height: 16.0),
              CustomEmailFormField(
                name: "email",
                labelText: "Email",
                hintText: "Enter Email",
                isRequired: true,
              ),
              const SizedBox(height: 64.0),
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
                    final email = formState.value["email"];
                    var forgetPasswordResult = await showFutureProgressDialog<BooleanOperationResult>(
                      context: context,
                      initFuture: () async {
                        return await ApiRepo().authClient.forgetPassword(email);
                      },
                    );
                    if (forgetPasswordResult != null && forgetPasswordResult.status) {
                      await showAdaptiveAlertDialog(
                        context: context,
                        icon: UniversalImage(IconAssets.done),
                        title: "Forget Password",
                        content: "Reset Password mail was sent to your email.",
                        showCloseButton: false,
                      );
                      Navigation().navToVerifyResetPasswordScreen(context, email: email);
                    } else {
                      await showAdaptiveErrorDialog(
                        context: context,
                        title: "Error",
                        content: forgetPasswordResult?.errorMessage ?? "Unknown Error",
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
