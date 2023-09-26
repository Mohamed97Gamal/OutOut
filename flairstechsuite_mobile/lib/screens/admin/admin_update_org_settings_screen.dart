import 'dart:convert';

import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/utils/validators/validators.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/confirmation_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/edit_fields.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UpdateOrganizationSettingsScreen extends StatefulWidget {
  final SettingsDTO settingsDTO;

  UpdateOrganizationSettingsScreen(this.settingsDTO)
      : assert(settingsDTO != null);

  @override
  _UpdateOrganizationSettingsScreenState createState() =>
      _UpdateOrganizationSettingsScreenState();
}

class _UpdateOrganizationSettingsScreenState
    extends State<UpdateOrganizationSettingsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic>? settingsMap;
  bool? fabIsVisible;
  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    settingsMap = widget.settingsDTO.toJson();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _canPop(),
      child: NotificationScaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Update Settings".toUpperCase()),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.done),
          onPressed: _onSubmit,
        ),
        body: _EditForm(settingsMap, _formKey, scrollController),
      ),
    );
  }

  _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      // ignore: deprecated_member_use
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fix the errors in red before submitting.")),
      );
      return;
    }

    final newSettingsDTO = SettingsDTO.fromJson(
      json.decode(json.encode(settingsMap).toString()) as Map<String, dynamic>,
    );
    final response = await showFutureProgressDialog<SettingsDTOResponse>(
      context: context,
      initFuture: () => Repository().updateOrganizationSettings(newSettingsDTO),
    );
    if (response?.status ?? false) {
      await showAdaptiveAlertDialog(
          context: context, content: Text("Settings updated successfully"));
      Navigator.of(context).pop(true);
    } else {
      showErrorDialog(context, response);
    }
  }

  Future<bool> _canPop() async {
    final result = await showConfirmationDialog(
      context: context,
      title: "Discard Changes",
      actionText: "Are you sure you want to discard your changes?",
      icon: Icons.warning,
    );
    return result ?? false;
  }
}

class _EditForm extends StatelessWidget {
  final Map<String, dynamic>? settingsMap;
  final GlobalKey<FormState> _formKey;
  final ScrollController? _scrollController;

  const _EditForm(this.settingsMap, this._formKey, this._scrollController);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Row(
                children: [
                  Icon(Icons.info, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                        "Any change in the settings will affect all employees in your company."),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TimeZonesDropDown(
                      settingsMap,
                      "Time Zone",
                      "regionTimeZoneName",
                      (s) => requiredFieldValidator(s??""),
                      isRequired: true,
                    ),
                    IntEditingField(
                      settingsMap,
                      "Location Radius",
                      "locationRadius",
                      (s) {
                        if ((s != null && s.isNotEmpty)) {
                          if ((int.tryParse(s)! >= 1 &&
                              int.tryParse(s)! <= 500)) {
                            return null;
                          } else {
                            return "must be between 1 and 500.";
                          }
                        }
                        return "This field is required.";
                      },
                      isRequired: true,
                      suffixText: "meters",
                    ),
                    IntEditingField(
                      settingsMap,
                      "Minimum Task Time",
                      "minimumTaskTime",
                      (s) {
                        if ((s != null && s.isNotEmpty)) {
                          if ((int.tryParse(s)! >= 15 &&
                              int.tryParse(s)! <= 480)) {
                            return null;
                          } else {
                            return "must be between 15 and 480.";
                          }
                        }
                        return "This field is required.";
                      },
                      isRequired: true,
                      suffixText: "minutes",
                    ),
                    IntEditingField(
                      settingsMap,
                      "Check Out Reminder Margin",
                      "checkOutReminderMargin",
                      (s) {
                        if ((s != null && s.isNotEmpty)) {
                          if ((int.tryParse(s)! >= 0 &&
                              int.tryParse(s)! <= 480)) {
                            return null;
                          } else {
                            return "must be between 0 and 480.";
                          }
                        }
                        return "This field is required.";
                      },
                      isRequired: true,
                      emptyIfZero: false,
                      suffixText: "minutes",
                    ),
                    IntEditingField(
                      settingsMap,
                      "Maximum Locations",
                      "maxLocations",
                      (s) {
                        if ((s != null && s.isNotEmpty)) {
                          if ((int.tryParse(s)! >= 0 && int.tryParse(s)! <= 10)) {
                            return null;
                          } else {
                            return "must be between 0 and 10.";
                          }
                        }
                        return "This field is required.";
                      },
                      isRequired: true,
                    ),
                    SwitchField(settingsMap, "Manual Check In/Out",
                        "allowManualCheckInOut"),
                    SwitchField(settingsMap, "Automatic Check In/Out",
                        "allowAutomaticCheckInOut"),
                    SwitchField(settingsMap, "Tenrox Tasks Feature",
                        "useTenroxTasksFeature"),
                    SwitchField(settingsMap, "Tenrox Check In/Out Feature",
                        "useTenroxCheckInOutFeature"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeZonesDropDown extends StatefulWidget {
  final Map? _map;
  final String _fieldName;
  final String _fieldMapName;
  final ValidateField _validateField;

  final bool isRequired;

  const TimeZonesDropDown(
      this._map, this._fieldName, this._fieldMapName, this._validateField,
      {this.isRequired = false});

  @override
  _TimeZonesDropDownState createState() => _TimeZonesDropDownState();
}

class _TimeZonesDropDownState extends State<TimeZonesDropDown> {
  String? _selected;
  List<String>? _timeZones;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomFutureBuilder<ListStringResponse>(
        initFuture: () => Repository().getTimeZones(),
        onSuccess: (context, snapshot) {
          _timeZones = snapshot.data!.result;
          if (_timeZones!.contains(widget._map![widget._fieldMapName]))
            _selected = widget._map![widget._fieldMapName];

          return DropdownButtonFormField<String>(
            hint: Text(widget._fieldName + (widget.isRequired ? " *" : "")),
            value: _selected,
            validator: widget._validateField,
            onChanged: (value) {
              setState(() {
                _selected = value;
                widget._map![widget._fieldMapName] = value;
              });
            },
            items: _timeZones!.map((timeZone) {
              return DropdownMenuItem<String>(
                child: Text(timeZone),
                value: timeZone,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class SwitchField extends StatefulWidget {
  final Map? _map;
  final String _fieldName;
  final String _fieldMapName;

  const SwitchField(this._map, this._fieldName, this._fieldMapName);

  @override
  _SwitchFieldState createState() => _SwitchFieldState();
}

class _SwitchFieldState extends State<SwitchField> {
  bool? switchValue;

  @override
  void initState() {
    super.initState();
    if ((!widget._map!.containsKey(widget._fieldMapName)) ||
        widget._map![widget._fieldMapName] == null) {
      widget._map![widget._fieldMapName] = false;
      switchValue = false;
    } else {
      switchValue = widget._map![widget._fieldMapName];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SwitchListTile(
        contentPadding: EdgeInsets.only(right: 50),
        value: switchValue!,
        title: Text(widget._fieldName),
        onChanged: (value) {
          setState(() {
            switchValue = value;
            widget._map![widget._fieldMapName] = value;
          });
        },
      ),
    );
  }
}
