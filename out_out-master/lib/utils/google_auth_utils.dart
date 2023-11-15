import 'package:google_sign_in/google_sign_in.dart';

Future<String?> loginWithGoogle() async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      "email",
      "profile",
    ],
  );

  try {
    await _googleSignIn.signOut();
  } catch (ex) {}

  await _googleSignIn.signIn();
  var currentUser = _googleSignIn.currentUser;
  if (currentUser != null) {
    var authentication = await currentUser.authentication;
    return authentication.idToken;
  }
  return null;
}
