import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/models/user_credentials.dart';
import 'package:flairstechsuite_mobile/navigation/my_router.dart';
import 'package:flairstechsuite_mobile/repo/auth_repository.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/screens/auth/select_organization_screen.dart';
import 'package:flairstechsuite_mobile/utils/common.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              ResourcesUtils.sandClockBg,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
            ),
          ),
          Refreshable(
            child: CustomFutureBuilder<BoolResponse>(
              initFuture: () => _checkVersion(context),
              onSuccess: (_, __) => _buildLogoProgress(context),
              onLoading: (_) => _buildLogoProgress(context),
              onError: (context, __) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(64.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          ResourcesUtils.appLogo,
                          fit: BoxFit.contain,
                          width: 220,
                          height: 220,
                        ),
                        const SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: InkWell(
                            onTap: () => Refreshable.of(context)!.refresh(),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Text(
                                    "Something went wrong",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text("Tap to try again", textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoProgress(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(64.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              ResourcesUtils.appLogo,
              fit: BoxFit.contain,
              width: 220,
              height: 220,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 45.0,
              height: 45.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Theme(
                  data: Theme.of(context).copyWith(hintColor: Colors.white),
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: missing_return
  Future<BoolResponse> _checkVersion(BuildContext context) async {
    //await Future.delayed(Duration(milliseconds: 1500), () => true);
    final thisRoute = ModalRoute.of(context);
    if (!thisRoute!.isCurrent) {
      printIfDebug("removing splash");
      Navigator.of(context).removeRoute(thisRoute);
      return BoolResponse(status: true);
    }

    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;

    final responseVersions = await showFutureProgressDialog<AssignShiftMultipleResponse>(
      context: context,
      initFuture: () async {
        try {
          return await Repository().getAllowedVersions();
        } catch (ex) {
          return Repository.getErrorResponse(ex) as FutureOr<AssignShiftMultipleResponse>;
        }
      },
    );

    if (responseVersions?.status != true) {
      await FirebaseCrashlytics.instance.recordError(
        "Couldn't connect to apiattendance.flairstech.com",
        null,
        reason: 'a non-fatal network error',
      );
      await showAdaptiveAlertDialogDissmisable(
        context: context,
        title: Row(
          children: [
            Icon(Icons.error),
            const SizedBox(width: 8.0),
            Text("Error"),
          ],
        ),
        content: Text("Couldn't connect to Flairstech Hub, please try switching to a different network."),
      );
    } else {
      if (!responseVersions!.result!.contains(version)) {
        await showAdaptiveAlertDialogDissmisable(
          context: context,
          title: Row(
            children: [
              CircleAvatar(
                radius: 13,
                child: Icon(Icons.upgrade),
              ),
              const SizedBox(width: 8.0),
              Text("Update"),
            ],
          ),
          storeButton: MaterialButton(
            onPressed: () async => await launch(Platform.isIOS
                ? "https://apps.apple.com/eg/app/flairstracker/id1503420575"
                : "https://play.google.com/store/apps/details?id=com.flairstech.tenroxtimesheet"),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Platform.isIOS ? "App Store" : "Play Store",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          content: Text("This version is no longer supported, please update to latest version."),
        );
      } else {
        return _initialize(context);
      }
    }

    return BoolResponse(status: false);
  }

  // ignore: missing_return
  Future<BoolResponse> _initialize(BuildContext context) async {
    final credentials = await UserCredentials.fromSecureStorage();

    try {
      if (credentials?.accessToken == null ||
          credentials?.accessToken?.isEmpty == true ||
          credentials.organizationKey == null ||
          credentials?.organizationKey?.toString()?.isEmpty == true) {
        await _signIn();
        return BoolResponse(status: true);
      } else {
        _navigateToHome(context);
        return BoolResponse(status: true);
      }
    } on SocketException catch (e) {
      //d2('SocketException-> $e');

      return BoolResponse(status: false);
    } catch (e) {
      print("error $e");

      return BoolResponse(status: false);
    }
  }

  Future _signIn() async {
    final response = await showFutureProgressDialog<BoolResponse>(
      context: context,
      initFuture: () async {
        final loggedInResult = await AuthRepository().login("flairstech");
        if (loggedInResult != null) {
          return BoolResponse(
            status: false,
            result: false,
            errorMessage: "Couldn't login to the app!",
            errors: [],
          );
        }

        final response = await Repository().addMyFCMToken();
        return response;
      },
    );

    if (response?.status != true) {
      await UserCredentials.removeFromSecureStorage();
      if (response?.errorMessage?.isNotEmpty == true) {
        await showErrorDialog(
          context,
          response,
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(MyRouter.splash, (_) => false),
        );
      } else {
        await showAdaptiveAlertDialog(
          context: context,
          title: Row(
            children: [
              Icon(Icons.error),
              const SizedBox(width: 8.0),
              Text("Error"),
            ],
          ),
          content: Text("Login process is failed"),
        );
      }

      return;
    } else {
      _navigateToHome(context);
    }
  }

  _navigateToSelectOrganization(BuildContext context, String organizationKey) async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => SelectOrganizationScreen(
            organizationKey: organizationKey,
          ),
        ),
        (route) => false);
  }

  _navigateToHome(BuildContext context) async {
    Navigator.of(context).pushNamedAndRemoveUntil(MyRouter.checkInOut, (_) => false);
  }
}
