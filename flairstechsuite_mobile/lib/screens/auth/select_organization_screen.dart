import 'dart:ui';

import 'package:flairstechsuite_mobile/main.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/models/user_credentials.dart';
import 'package:flairstechsuite_mobile/navigation/my_router.dart';
import 'package:flairstechsuite_mobile/repo/auth_repository.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flutter/material.dart';

class SelectOrganizationScreen extends StatefulWidget {
  final String? organizationKey;

  SelectOrganizationScreen({this.organizationKey});

  @override
  State<StatefulWidget> createState() => SelectOrganizationScreenState();
}

class SelectOrganizationScreenState extends State<SelectOrganizationScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var isLoading = false;
  String? errorMessage;
  String? organization;
  String? organizationValue;

  final border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
  );

  @override
  void initState() {
    super.initState();
    if (showInvalidAuthData) {
      showInvalidAuthData = false;
      Future.microtask(() => showAdaptiveAlertDialog(context: context, content: Text("Session expired. Please sign in again.")));
    }
    organization = widget?.organizationKey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
          Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Center(
                child: SingleChildScrollView(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      hintColor: Colors.white,
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                            brightness: Brightness.dark,
                          ),
                      brightness: Brightness.dark,
                     // primaryColorBrightness: Brightness.dark,
                      textTheme: TextTheme(
                        button: TextStyle(color: Colors.white),
                      ),
                      inputDecorationTheme: InputDecorationTheme(
                        contentPadding: const EdgeInsets.all(16.0),
                        border: border,
                        errorBorder: border,
                        disabledBorder: border,
                        enabledBorder: border,
                        focusedBorder: border,
                        focusedErrorBorder: border,
                        fillColor: Color(0xDD6a2825),
                        labelStyle: TextStyle(color: Colors.white),
                        errorStyle: TextStyle(color: Colors.white),
                        helperStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                        filled: true,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            ResourcesUtils.appLogo,
                            width: 160,
                            height: 160,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 40),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              // CustomFutureBuilder<OrganizationDTOListResponse>(
                              //   initFuture: () async {
                              //     final response = await Repository().getOrganizationsDetails();
                              //     return response;
                              //   },
                              //   onError: (context, snapshot) {
                              //     return Text('Could not connect');
                              //   },
                              //   onSuccess: (context, snapshot) {
                              //     organization = snapshot.data.result[0].key;
                              //     organizationValue = snapshot.data.result[0].name;
                              //
                              //     final _img = Image.network(
                              //       snapshot.data.result[0].logoPath,
                              //       fit: BoxFit.cover,
                              //       height: 50,
                              //     );
                              //
                              //     return Container(
                              //       padding: EdgeInsets.symmetric(horizontal: 16),
                              //       decoration: ShapeDecoration(
                              //         shape: RoundedRectangleBorder(
                              //           side: BorderSide(color: Colors.white, width: 1.5),
                              //           borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              //         ),
                              //       ),
                              //       child: DropdownButton<String>(
                              //           isExpanded: false,
                              //           dropdownColor: Colors.redAccent,
                              //           icon: Icon(Icons.keyboard_arrow_down),
                              //           underline: Container(),
                              //           style: TextStyle(color: Colors.black),
                              //           value: organizationValue,
                              //           items: <DropdownMenuItem<String>>[
                              //             for (var index in [
                              //               organizationValue,
                              //             ])
                              //               DropdownMenuItem<String>(
                              //                 value: index,
                              //                 child: Padding(
                              //                   padding: const EdgeInsets.all(8.0),
                              //                   child: Container(
                              //                     child: Row(
                              //                       children: [
                              //                         _img,
                              //                         const SizedBox(width: 16),
                              //                         Center(
                              //                           child: Text(
                              //                             index,
                              //                             style: TextStyle(fontSize: 18, color: Colors.white),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //           ],
                              //           onTap: null,
                              //           onChanged: null
                              //           //  (value) {
                              //           //   setState(() {
                              //           //     organization = value;
                              //           //   });
                              //           // },
                              //           ),
                              //     );
                              //   },
                              // ),
                              // const SizedBox(height: 40),
                              SizedBox(
                                width: double.infinity,
                                child: MaterialButton(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  splashColor: Colors.white.withOpacity(0.65),
                                  textColor: Colors.white,
                                  color: Colors.white,
                                  onPressed: _signIn,
                                  child: const Text(
                                    "Next",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              if (errorMessage != null)
                                Text(
                                  errorMessage!,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 14, color: Colors.white),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
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
        await showErrorDialog(context, response);
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

  _navigateToHome(BuildContext context) async {
    Navigator.of(context).pushNamedAndRemoveUntil(MyRouter.checkInOut, (_) => false);
  }
}
