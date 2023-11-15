import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<String?> loginWithFacebook() async {
  try {
    await FacebookAuth.instance.logOut();
  } catch (ex) {}

  final LoginResult result = await FacebookAuth.instance.login(
    loginBehavior: LoginBehavior.nativeWithFallback,
  );
  if (result.status == LoginStatus.success) {
    final AccessToken accessToken = result.accessToken!;
    return accessToken.token;
  }
  return null;
}
