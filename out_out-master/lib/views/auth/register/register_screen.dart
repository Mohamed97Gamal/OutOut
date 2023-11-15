import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/assets/logo_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/view_models/auth/application_user_response_operation_result.dart';
import 'package:out_out/data/view_models/auth/customer_registration_request.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/utils/validators.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/external_auth_buttons/apple_login_button.dart';
import 'package:out_out/widgets/external_auth_buttons/facebook_login_button.dart';
import 'package:out_out/widgets/external_auth_buttons/google_login_button.dart';
import 'package:out_out/widgets/fields/custom_email_form_field.dart';
import 'package:out_out/widgets/fields/custom_password_form_field.dart';
import 'package:out_out/widgets/fields/custom_phone_number_form_field.dart';
import 'package:out_out/widgets/fields/custom_repeat_password_form_field.dart';
import 'package:out_out/widgets/fields/custom_terms_form_field.dart';
import 'package:out_out/widgets/fields/custom_text_form_field.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              TitleText("Create an Account"),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                name: "full_name",
                labelText: "Full Name",
                hintText: "Full Name",
                isRequired: true,
                validators: [Validators.fullName],
              ),
              const SizedBox(height: 16.0),
              CustomEmailFormField(
                name: "email",
                labelText: "Email",
                hintText: "Enter Email",
                isRequired: true,
              ),
              const SizedBox(height: 16.0),
              CustomPasswordFormField(
                name: "password",
                labelText: "Password",
                controller: _passwordController,
                hintText: "********",
                isRequired: true,
              ),
              const SizedBox(height: 16.0),
              CustomRepeatPasswordFormField(
                name: "repeat_password",
                labelText: "Confirm Password",
                hintText: "********",
                isRequired: true,
                passwordController: _passwordController,
              ),
              const SizedBox(height: 16.0),
              CustomPhoneNumberFormField(
                codeName: "phone_number_code",
                numberName: "phone_number_number",
                labelText: "Phone Number",
                keyboardType: TextInputType.phone,
                isRequired: true,
              ),
              const SizedBox(height: 16.0),
              CustomTermsFormField(
                name: "terms",
              ),
              const SizedBox(height: 16.0),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  child: Text("Sign Up"),
                  onPressed: () async {
                    var formState = _formKey.currentState;
                    if (formState == null) return;
                    if (!formState.saveAndValidate()) {
                      return;
                    }
                    var registerResult = await showFutureProgressDialog<ApplicationUserResponseOperationResult>(
                      context: context,
                      initFuture: () async {
                        final request = new CustomerRegistrationRequest()
                          ..fullName = formState.value["full_name"]
                          ..email = formState.value["email"]
                          ..password = formState.value["password"]
                          ..phoneNumber = formState.value["phone_number_number"] != null &&
                                  formState.value["phone_number_number"] != ""
                              ? formState.value["phone_number_code"] + formState.value["phone_number_number"]
                              : ""
                          ..firebaseMessagingToken = await FirebaseMessaging.instance.getToken();
                        return await ApiRepo().tokenClient.register(request);
                      },
                    );
                    if (registerResult != null && registerResult.status) {
                      Navigation().navToLoginScreen(
                        context,
                        initialEmail: formState.value["email"],
                        initialPassword: formState.value["password"],
                      );
                    } else {
                      await showAdaptiveErrorDialog(
                        context: context,
                        title: "Error",
                        content: registerResult?.errorMessage ?? "Unknown Error",
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Or",
                  style: TextStyle(
                    color: Color(0xFFCBCBCB),
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: FacebookLoginButton(),
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GoogleLoginButton(),
              ),
              if (Platform.isIOS)
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AppleLoginButton(),
                ),
              const SizedBox(height: 16.0),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(width: 2.0),
                      Text("Log in"),
                      const SizedBox(width: 4.0),
                      UniversalImage(IconAssets.right_arrow_long, width: 20.0),
                    ],
                  ),
                  onPressed: () => Navigation().navToLoginScreen(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
