import 'package:flairstechsuite_mobile/features/quick_leave/presentation/widgets/half_day_timing.dart';

import 'manager/balance_provider.dart';
import 'manager/calendar_dates_provider.dart';
import 'manager/leave_files_provider.dart';
import 'manager/quick_leave_provider.dart';
import 'widgets/calendar_view.dart';
import 'widgets/files_listview.dart';
import 'widgets/quick_leave_options_component.dart';
import 'widgets/selected_days_number.dart';
import '../../../utils/resources_utils.dart';
import '../../../widgets/basic/drawer_scaffold.dart'as menu;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../../../widgets/notification_scaffold.dart';
import '../../../screens/common/fields/custom_text_form_field.dart';


class CreateQuickLeaveRequestScreen extends StatefulWidget {
  final bool? isNavFromDrawer;
  CreateQuickLeaveRequestScreen({required this.isNavFromDrawer});
  @override
  _CreateQuickLeaveRequestScreenState createState() =>
      _CreateQuickLeaveRequestScreenState();
}

class _CreateQuickLeaveRequestScreenState
    extends State<CreateQuickLeaveRequestScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = TextEditingController();

  bool _didPressSave = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuickLeaveProvider()),
        ChangeNotifierProvider(create: (_) => BalanceProvider()),
        ChangeNotifierProvider(create: (_) => LeaveFilesProvider()),
        ChangeNotifierProvider(create: (_) => CalendarDatesProvider()),
      ],
      child: menu.DrawerScaffold(
        builder: (context) => NotificationScaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Quick LEAVE REQUEST"),
            leading: widget.isNavFromDrawer ?? true
                ? IconButton(
                    icon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(ResourcesUtils.menu),
                    ),
                    onPressed: () =>
                        Provider.of<menu.MenuController>(context, listen: false)
                            .toggle(),
                  )
                : null,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                    const Text(
                      "Leave Type",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    QuickLeaveOptions(
                      textEditingController: controller,
                    ),
                    const HalfDayTiming(),
                    const SizedBox(height: 16),

                    CalendarView(
                      controller: controller,
                    ),
                    const SizedBox(height: 32),
                    const NumberOfSelectedDaysWidget(),
                    const SizedBox(height: 16),
                    FilesListView(
                      scaffoldKey: _scaffoldKey,
                    ),
                  FormBuilder(
                      key: formKey,
                      autovalidateMode: _didPressSave
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      child: CustomTextFormField(
                      name: "reason",
                      labelText: "Reason",
                      // isRequired: true,
                      validator: (reason) {
                        if ((reason ?? "").trim().isEmpty)
                          return "Reason is required";
                        if ((reason ?? "").trim().length > 50)
                          return "Maximum length is 50 characters";
                        return null;
                      },
                    ),
                    ),
                    const SizedBox(height: 32),
                            Consumer<LeaveFilesProvider>(
                        builder: (context, value, child) {
                      return ElevatedButton(
                          child: const Text("SUBMIT"),
                          onPressed: () {
                            final quickLeaveProvider =
                                Provider.of<QuickLeaveProvider>(context,
                                    listen: false);
                            final balanceProvider =
                                Provider.of<BalanceProvider>(context,
                                    listen: false);

                            setState(() => _didPressSave = true);

                            quickLeaveProvider.checkSelectedDate(context);

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
                            final reason = formKey.currentState!.value['reason'];

                            balanceProvider.checkNumberOfSelectedDays(context);
                            quickLeaveProvider.createQuickLeaveRequest(
                                context,
                                reason,
                                widget.isNavFromDrawer,
                                value.totalSize,
                                value.uploadedFiles);
                          }
                          );
                    }),
                ],
              )
                // FormBuilder(
                //   key: formKey,
                //   autovalidateMode: _didPressSave
                //       ? AutovalidateMode.always
                //       : AutovalidateMode.disabled,
                //   child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                //     children: [
                // const Text(
                //   "Leave Type",
                //   style: TextStyle(
                //     fontSize: 18,
                //     color: Colors.black,
                //     fontWeight: FontWeight.w300,
                //   ),
                // ),
                // QuickLeaveOptions(
                //   textEditingController: controller,
                // ),
                // const HalfDayTiming(),
                // const SizedBox(height: 16),

                // CalendarView(
                //   controller: controller,
                // ),
                // const SizedBox(height: 32),
                // const NumberOfSelectedDaysWidget(),
                // const SizedBox(height: 16),
                // FilesListView(
                //   scaffoldKey: _scaffoldKey,
                // ),
                // CustomTextFormField(
                //   name: "reason",
                //   labelText: "Reason",
                //   // isRequired: true,
                //   validator: (reason) {
                //     if ((reason ?? "").trim().isEmpty)
                //       return "Reason Name is required";
                //     if ((reason ?? "").trim().length > 50)
                //       return "Maximum length is 50 characters";
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 32),
                // Consumer<LeaveFilesProvider>(
                //     builder: (context, value, child) {
                //   return MaterialButton(
                //       child: const Text("SUBMIT"),
                //       onPressed: () {
                //         final quickLeaveProvider =
                //             Provider.of<QuickLeaveProvider>(context,
                //                 listen: false);
                //         final balanceProvider =
                //             Provider.of<BalanceProvider>(context,
                //                 listen: false);

                //         setState(() => _didPressSave = true);

                //         quickLeaveProvider.checkSelectedDate(context);

                //         if (!formKey.currentState.validate()) {
                //           // ignore: deprecated_member_use
                //           _scaffoldKey.currentState.showSnackBar(
                //             const SnackBar(
                //                 content: Text(
                //                     "Please fix the errors in red before submitting.")),
                //           );
                //           return;
                //         }
                //         formKey.currentState.save();
                //         final reason = formKey.currentState.value['reason'];

                //         balanceProvider.checkNumberOfSelectedDays(context);
                //         quickLeaveProvider.createQuickLeaveRequest(
                //             context,
                //             reason,
                //             widget.isNavFromDrawer,
                //             value.totalSize,
                //             value.uploadedFiles);
                //       }
                //       );
                // }),
                //     ],
                //   ),
                // ),
            ),
          ),
        ),
      ),
    );
  }
}
