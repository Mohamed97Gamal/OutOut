import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/providers/my_profile_provider.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';


class BalanceReportPage extends StatefulWidget {
  final bool teamOnly;

  BalanceReportPage({this.teamOnly = true});

  @override
  _BalanceReportPageState createState() => _BalanceReportPageState();
}

class _BalanceReportPageState extends State<BalanceReportPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  bool? checkBoxValue=true;

  List<String>? emails = [];

  List<String?> cc = [];

  static List<String> getSuggestions(String query, List<String> emails) {
    final matches = <String>[];
    matches.addAll(emails);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return menu.DrawerScaffold(
      builder: (context) {
        return NotificationScaffold(
          key: _scaffoldKey,
          bottomNavigationBar: const MyBottomNavigationBar(),
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(ResourcesUtils.menu),
              ),
              onPressed: () => Provider.of<menu.MenuController>(context, listen: false).toggle(),
            ),
            title: Text("Balance Report".toUpperCase()),
          ),
          body: CustomFutureBuilder<ListStringResponse>(
            initFuture: () => Repository().getAllEmails(),
            onSuccess: (context, snapshot) {
              emails = snapshot.data!.result;
              return _buildBody(context);
            },
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                LayoutBuilder(builder: (context, constraints) {
                 return SizedBox(
                    width: constraints.maxWidth - 72,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        textFialdSuggest(),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            for (var item in cc)
                              Chip(
                                label: Text(item!),
                                deleteIcon: Icon(
                                  Icons.cancel_rounded,
                                ),
                                onDeleted: () {
                                  setState(() {
                                    cc.remove(item);
                                  });
                                },
                              ),
                            CheckboxListTile(
                              value: checkBoxValue,
                              onChanged: (value) {
                                setState(() {
                                  checkBoxValue = value;
                                });
                              },
                              title: Text("Generate Direct Reportees only"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 24),
                              child: FloatingActionButton.extended(
                                onPressed: _onSend,
                                label: Text('Send Report via Email'.toUpperCase()),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ));
  }

  Widget textFialdSuggest() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: false,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'Search by Email',
            labelText: "CC",
              labelStyle: TextStyle(color: Colors.grey),
              hintStyle: TextStyle(color: Colors.grey),
          ),
          controller: _emailController,
        ),
        validator: _checkEmail,
        hideOnEmpty: true,
        hideOnLoading: true,
        hideOnError: true,
        suggestionsCallback: (pattern) async {
          setState(() {
            if (pattern.contains(' ')) {
              pattern = pattern.replaceAll(' ', '');
            }
          });
          var allEmails = await getSuggestions(pattern, emails!);
          if (allEmails.length >= 3) allEmails = allEmails.sublist(0, 3);
          if (allEmails.length < 3) allEmails = allEmails.sublist(0);
          if (_checkEmail(pattern) == null) {
            allEmails.add(pattern);
          }
          allEmails = allEmails.toSet().toList();
          return allEmails;
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        itemBuilder: (context, dynamic suggestion) {
          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                suggestion,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          );
        },
        onSuggestionSelected: (dynamic suggestion) {
          setState(() {
            _emailController.clear();
            String? mailWithOutSpaces;
            setState(() {
              if (suggestion.contains(' ')) {
                mailWithOutSpaces = suggestion.replaceAll(' ', '');
                suggestion = mailWithOutSpaces;
              }
            });
            if (!cc.contains(suggestion)) {
              setState(() {
                cc.add(suggestion);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email already added")));
            }
          });
          // _emailController.text = suggestion;
        },
      ),
    );
  }

  String? _checkEmail(String? value) {
    value = value!.trim();
    if (value.isNotEmpty == true) {
      final emailValid = RegExp(
              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)\b")
          .hasMatch(value);
      final dotInMail = value.endsWith('.');
      if (emailValid && !dotInMail)
        return null;
      else
        return "Email is not valid";
    } else {
      return null;
    }
  }

  _onSend() async {
    if (!_formKey.currentState!.validate()) {
      // ignore: deprecated_member_use
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fix the errors in red before submitting.")),
      );
      return;
    }
    final response = await showFutureProgressDialog<BoolResponse>(
      context: context,
      message: "Please wait, this might take a while.",
      initFuture: () => Repository().sendBalanceReport(
        teamOnly: widget.teamOnly,
        cc: cc,
        directReporteesOnly: checkBoxValue,
      ),
    );
    if (response?.status ?? false) {
      final provider = Provider.of<MyProfileProvider>(context, listen: false);
      final profile = await provider.get();
      final email = profile.result?.organizationEmail ?? provider.current!.organizationEmail;
      await showAdaptiveAlertDialog(
        context: context,
        content: Text(cc.isNotEmpty == true ? "Balance Report has been sent to ${email} and all CC mails" : "Balance Report has been sent to ${email} "),
      );
    } else {
      await showErrorDialog(context, response);
    }
    setState(() {
      cc.clear();
    });
  }
}
