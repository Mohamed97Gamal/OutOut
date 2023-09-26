import '../../data/model/cycle_holiday_dto.dart';
import '../../domain/entity/cycle_entity.dart';
import '../../../../utils/notifier_utils.dart';
import '../../../../widgets/basic/adaptive_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../enums/cycle_country.dart';
import '../../../../screens/common/fields/custom_date_range_form_field.dart';
import '../../../../screens/common/fields/custom_text_form_field.dart';
import '../../../../widgets/notification_scaffold.dart';
import '../../data/model/cycle/cycle_dto.dart';
import '../../data/model/holiday/holiday_dto.dart';
import '../../data/repository/holiday_repository_impl.dart';

class CreateHolidayScreen extends StatefulWidget {
  final CycleEntity cycle;
  const CreateHolidayScreen({
    Key? key,
    required this.cycle,
  }) : assert(cycle != null);
  @override
  _CreateHolidayScreenState createState() => _CreateHolidayScreenState();
}

class _CreateHolidayScreenState extends State<CreateHolidayScreen> {
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
        title: Text("Create Holiday".toUpperCase()),
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
                  labelText: "Holiday Name",
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
                CustomDateRangeFormField(
                  name: "date",
                  labelText: "",
                  hintText: "Date",
                  firstDate: widget.cycle.from!.toLocal(),
                  lastDate: widget.cycle.to!.toLocal(),
                  validator: (date) {
                    if (date == null || date.start == null || date.end == null)
                      return "Holiday \"Date\" is required";

                    return null;
                  },
                ),
                const SizedBox(height: 32),
                Container(
                  child: ElevatedButton(
                    child: Text("Save Holiday".toUpperCase()),
                    onPressed: _createHoliday,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createHoliday() async {
    setState(() {
      _didPressSave = true;
    });
    if (!formKey.currentState!.validate()) {
      // ignore: deprecated_member_use
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fix the errors in red before submitting.")),
      );
      return;
    }
    formKey.currentState!.save();
    final range = formKey.currentState!.value['date'] as DateTimeRange;
    final from = range.start.toUtc();
    final to = range.end.toUtc();

    final name = formKey.currentState!.value['holidayName'];
    print("object ${widget.cycle.id}");
    final response = await HolidayRepositoryImpl().createHoilday(
      CycleHoliday(
        cycleId: widget.cycle.id,
        holidays: [
          HolidayDTO(
          name: name,
          from: from,
          to: to,
        ),
        ],
      ),
    );
    response.fold(
        (error) async => await showErrorDialog(context, error.message),
        (r) async => await showAdaptiveAlertDialog(
              context: context,
              content: Text(
                "Holiday (${name}) has been created successfully",
              ),
            ).then((value) => Navigator.of(context).pop(true)));
   
  }
}
