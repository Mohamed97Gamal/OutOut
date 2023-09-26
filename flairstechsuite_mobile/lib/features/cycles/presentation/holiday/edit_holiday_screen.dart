import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../enums/cycle_country.dart';
import '../../../../screens/common/fields/custom_date_range_form_field.dart';
import '../../../../screens/common/fields/custom_text_form_field.dart';
import '../../../../utils/notifier_utils.dart';
import '../../../../widgets/basic/adaptive_alert_dialog.dart';
import '../../../../widgets/basic/refreshable.dart';
import '../../../../widgets/notification_scaffold.dart';
import '../../data/model/cycle/cycle_dto.dart';
import '../../data/repository/holiday_repository_impl.dart';
import '../../domain/entity/cycle_entity.dart';
import '../../domain/entity/holiday_entity.dart';

class EditHolidayScreen extends StatefulWidget {
  final CycleEntity? cycle;
  final HolidayEntity? holiday;
  final GlobalKey<RefreshableState>? refreshableKey;
  const EditHolidayScreen({
    Key? key,
    required this.cycle,
    required this.holiday,
    this.refreshableKey,
  });
  @override
  _EditHolidayScreenState createState() => _EditHolidayScreenState();
}

class _EditHolidayScreenState extends State<EditHolidayScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _didPressSave = false;
  CycleCountryDTO country =
      CycleCountryDTO(name: CycleCountry.egypt.name, value: 0);
  @override
  Widget build(BuildContext context) {
    return NotificationScaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Holiday".toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: FormBuilder(
            key: formKey,
            autovalidateMode: _didPressSave
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextFormField(
                  name: "holidayName",
                  labelText: "Holiday Name", initialValue: widget.holiday!.name,
                  //  isRequired: true,
                  validator: (holidayName) {
                    if ((holidayName ?? "").trim().isEmpty)
                      return "Holiday Name is required";
                    if ((holidayName ?? "").trim().length > 50)
                      return "Maximum length is 50 characters";
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Card(
                  child: CustomDateRangeFormField(
                    enabled: false,
                    name: "date",
                    labelText: "",
                    hintText: "Date",
                    initialValue: DateTimeRange(
                        start: widget.holiday!.from!, end: widget.holiday!.to!),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  child: ElevatedButton(
                    child: Text("Save Holiday".toUpperCase()),
                    onPressed: _editHoliday,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _editHoliday() async {
    formKey.currentState!.save();
    final name = formKey.currentState!.value['holidayName'];
    setState(() => _didPressSave = true);
    if (!formKey.currentState!.validate()) {
      // ignore: deprecated_member_use
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fix the errors in red before submitting.")),
      );
      return;
    }

    final response = await HolidayRepositoryImpl()
        .updateHoilday(widget.cycle!.id, widget.holiday!.id, name);

    response.fold(
        (error) async => await showErrorDialog(context, error.message),
        (r) async => await showAdaptiveAlertDialog(
              context: context,
              content: Text(
                "Holiday (${widget.holiday!.name}) has been updated successfully",
              ),
            ).then((value) {
              widget.refreshableKey!.currentState!.refresh();
              Navigator.of(context).pop(true);
            }));
  }
}
