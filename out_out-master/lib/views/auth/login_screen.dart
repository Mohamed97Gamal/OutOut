import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/assets/logo_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/disk/disk_repo.dart';
import 'package:out_out/data/memory/memory_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/models/tokens_data.dart';
import 'package:out_out/data/view_models/auth/login_request.dart';
import 'package:out_out/data/view_models/auth/login_response_operation_result.dart';
import 'package:out_out/data/view_models/base/error_codes.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/external_auth_buttons/apple_login_button.dart';
import 'package:out_out/widgets/external_auth_buttons/facebook_login_button.dart';
import 'package:out_out/widgets/external_auth_buttons/google_login_button.dart';
import 'package:out_out/widgets/fields/custom_email_form_field.dart';
import 'package:out_out/widgets/fields/custom_login_password_form_field.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final String? initialEmail, initialPassword;

  LoginScreen({
    this.initialEmail,
    this.initialPassword,
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    if (widget.initialEmail != null && widget.initialPassword != null) {
      scheduleMicrotask(
        () => _handleLogin(
          context,
          overriddenEmail: widget.initialEmail,
          overriddenPassword: widget.initialPassword,
        ),
      );
    } else {
      //TODO: fix ? or ignore
      //scheduleMicrotask(() => context.read<MyAccountProvider>().reset());
    }
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
              TitleText("Welcome Back"),
              const SizedBox(height: 16.0),
              CustomEmailFormField(
                name: "email",
                labelText: "Email",
                hintText: "Enter Email",
                isRequired: true,
              ),
              const SizedBox(height: 16.0),
              CustomLoginPasswordFormField(
                name: "password",
                labelText: "Password",
                hintText: "********",
                isRequired: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text("Forgot Password?"),
                  onPressed: () => Navigation().navToForgetPasswordScreen(context),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  child: Text("Log In"),
                  onPressed: () => _handleLogin(context),
                ),
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: Text("Sign Up"),
                  onPressed: () => Navigation().navToRegisterScreen(context),
                ),
              ),
              const SizedBox(height: 8.0),
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
            ],
          ),
        ),
      ),
    );
  }

  _handleLogin(BuildContext context, {String? overriddenEmail, String? overriddenPassword}) async {
    var formState = _formKey.currentState;
    if (formState == null) return;

    if (overriddenEmail == null || overriddenPassword == null) {
      if (!formState.saveAndValidate()) {
        return;
      }
    }

    MemoryRepo().deleteTokensData();

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    } else {}

    final email = overriddenEmail ?? formState.value["email"];
    final password = overriddenPassword ?? formState.value["password"];
    var loginResult = await showFutureProgressDialog<LoginResponseOperationResult>(
      context: context,
      initFuture: () async {
        final loginRequest = new LoginRequest()
          ..email = email
          ..password = password
          ..firebaseMessagingToken = await FirebaseMessaging.instance.getToken();
        return await ApiRepo().tokenClient.login(loginRequest);
      },
    );
    if (loginResult != null && loginResult.status) {
      final tokensData = TokensData.fromLoginResponse(loginResult.result);
      MemoryRepo().updateTokensData(tokensData);
      await DiskRepo().updateTokensData(tokensData);
      context.read<MyAccountProvider>().update(loginResult.result.user);
      Navigation().navToHomeScreen(context);
    } else {
      if (loginResult?.errorCode == ErrorCodes.unverifiedEmail) {
        await showAdaptiveAlertDialog(
          context: context,
          icon: UniversalImage(IconAssets.done),
          title: "One more step",
          content: "Your account has been created, you need to verify your Email.",
          showCloseButton: false,
        );
        Navigation().navToVerifyScreen(context, email: email);
        return;
      }
      await showAdaptiveErrorDialog(
        context: context,
        title: "Error",
        content: loginResult?.errorMessage ?? "Unknown Error",
      );
    }
  }
}
