import 'dart:async';

import 'package:flairstechsuite_mobile/features/cycles/presentation/manager/cycles_manager.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../enums/cycle_country.dart';
import '../../../../screens/common/fields/custom_date_range_form_field.dart';
import '../../../../screens/common/fields/custom_text_form_field.dart';
import '../../../../utils/notifier_utils.dart';
import '../../../../widgets/basic/adaptive_alert_dialog.dart';
import '../../../../widgets/basic/confirmation_dialog.dart';
import '../../../../widgets/basic/future_dialog.dart';
import '../../../../widgets/notification_scaffold.dart';
import '../../data/model/cycle/cycle_dto.dart';
import '../../data/repository/cycle_repository_impl.dart';
import 'widgets/cycle_country_form_field.dart';

class CreateCycleScreen extends StatefulWidget {
  @override
  _CreateCycleScreenState createState() => _CreateCycleScreenState();
}

class _CreateCycleScreenState extends State<CreateCycleScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool? _setAsDefaultValue = false;
  var _didPressSave = false;
  CycleCountryDTO country =
      CycleCountryDTO(name: CycleCountry.egypt.name, value: 0);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CycleProvider()),
      ],
      child: NotificationScaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Create Cycle".toUpperCase()),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: FormBuilder(
                  key: formKey,
                  autovalidateMode: _didPressSave
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child:
                      Consumer<CycleProvider>(builder: (context, value, child) {
                    return Stack(
                      children: [
                        if (value.isLoading)
                          Center(child: AdaptiveProgressIndicator())
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomTextFormField(
                                name: "cycleName",
                                labelText: "Cycle Name",
                                // isRequired: true,
                                validator: (cycleName) {
                                  if ((cycleName ?? "").trim().isEmpty)
                                    return "Cycle Name is required";
                                  if ((cycleName ?? "").trim().length > 50)
                                    return "Maximum length is 50 characters";
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              CycleCountryFormField(
                                onValueChanged: (value) {
                                  country = value;
                                },
                                validator: (value) {},
                              ),
                              const SizedBox(height: 16),
                              CustomDateRangeFormField(
                                name: "date",
                                labelText: "",
                                hintText: "Date",
                                firstDate: DateTime(1999, 1, 1),
                                lastDate: DateTime(2050, 1, 1),
                                validator: (date) {
                                    if (date == null)
                                    return "Cycle \"Date\" is required";

                                    return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.all(0),
                                title: Text("Make Default"),
                                value: _setAsDefaultValue,
                                onChanged: (value) async {
                                  if (!_setAsDefaultValue!) {
                                    final response =
                                          await (showFutureProgressDialog<
                                            CycleDTOListResponse>(
                                      context: context,
                                        initFuture: () =>
                                          CycleRepositoryImpl().getAllCycles(),
                                    ) as FutureOr<CycleDTOListResponse>);
                                      final defaultCountries = response.result!
                                        .map((e) => e.isCurrent)
                                        .toList();
                                    final listOfCountriesValues = response
                                        .result!
                                        .map((e) => e.country)
                                        .toList();
                                    final map = Map<int?, bool?>();
                                      for (var i = 0;
                                        i < defaultCountries.length;
                                        i++) {
                                      if (defaultCountries[i] == true)
                                          map[listOfCountriesValues[i]] =
                                            defaultCountries[i];
                                    }

                                      if (map.keys.contains(country.value)) {
                                        final accepted =
                                          await showConfirmationDialog(
                                        context: context,
                                        actionText:
                                            "You already have a default cycle, Do you want to replace it with this cycle?",
                                        icon: FontAwesomeIcons.businessTime,
                                        title: "Default Shift",
                                      );
                                      if (accepted != true) return;
                                    }
                                  }
                                  setState(() => _setAsDefaultValue = value);
                                },
                              ),
                              const SizedBox(height: 32),
                              Container(
                                child: ElevatedButton(

                                  child: Text("Save Cycle".toUpperCase()),
                                    onPressed: () {
                                    setState(() {
                                      _didPressSave = true;
                                    });
                                    if (!formKey.currentState!.validate()) {
                                      // ignore: deprecated_member_use
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Please fix the errors in red before submitting.")),
                                      );
                                      return;
                                    }
                                    formKey.currentState!.save();
                                    final range = formKey.currentState!
                                        .value['date'] as DateTimeRange;
                                    final from = range.start.toUtc();
                                    final to = range.end.toUtc();

                                    final String name =
                                        formKey.currentState!.value['cycleName'];
                                    final cycleProvider =
                                        Provider.of<CycleProvider>(context,
                                            listen: false);
                                    cycleProvider.addCycle(
                                        name,
                                        from,
                                        to,
                                        _setAsDefaultValue,
                                        country.value,
                                        (error) => showErrorDialog(
                                            context, error.message),
                                        (cycle) => showAdaptiveAlertDialog(
                                                context: context,
                                                content: Text(
                                                    "(${name.trim()}) has been created successfully"))
                                            .then((value) =>
                                                Navigator.of(context)
                                                    .pop(true)));
                                  },
                                  // _createCycle,
                                ),
                              )
                            ],
                          ),
                      ],
                    );
                  })),
            ),
          ),
        ),
      ),
    );
  }
}
