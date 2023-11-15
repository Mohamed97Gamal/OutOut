import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/disk/disk_repo.dart';
import 'package:out_out/data/memory/memory_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/models/tokens_data.dart';
import 'package:out_out/data/view_models/auth/external_authentication_request.dart';
import 'package:out_out/data/view_models/auth/external_provider.dart';
import 'package:out_out/data/view_models/auth/login_response_operation_result.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginButton extends StatelessWidget {
  const AppleLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInWithAppleButton(
      onPressed: () async {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        if (credential.identityToken == null) {
          return;
        }
        var loginResult = await showFutureProgressDialog<LoginResponseOperationResult>(
          context: context,
          initFuture: () async {
            final request = new ExternalAuthenticationRequest(
              externalLoginProvider: ExternalProvider.apple,
              accessToken: credential.identityToken!,
              fullName: "${credential.givenName} ${credential.familyName}",
              firebaseMessagingToken: await FirebaseMessaging.instance.getToken(),
            );
            return await ApiRepo().tokenClient.externalAuthentication(request);
          },
        );
        if (loginResult != null && loginResult.status) {
          final tokensData = TokensData.fromLoginResponse(loginResult.result);
          MemoryRepo().updateTokensData(tokensData);
          context.read<MyAccountProvider>().update(loginResult.result.user);
          if (loginResult.result.user.isPasswordSet) {
            await DiskRepo().updateTokensData(tokensData);
            Navigation().navToHomeScreen(context);
          } else {
            Navigation().navToSetPasswordScreen(context);
          }
        } else {
          await showAdaptiveErrorDialog(
            context: context,
            title: "Error",
            content: loginResult?.errorMessage ?? "Unknown Error",
          );
        }
      },
    );
  }
}
