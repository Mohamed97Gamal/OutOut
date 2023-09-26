import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_dialog.dart'as dia;
import 'package:flairstechsuite_mobile/widgets/basic/custom_radio.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showUpdateEmployeeWorkspacePolicyDialog(
  BuildContext context,
  String employeeId,
  int? oldWorkspacePolicy,
) async {
  final selectedWorkspacePolicy = ValueNotifier<int?>(oldWorkspacePolicy);
  final selected = await dia.showAdaptiveDialog<int>(
    context: context,
    builder: (context) {
      return AdaptiveAlertDialog(
        title: Text("Change Work Space Policy"),
        content: ValueListenableBuilder(
          valueListenable: selectedWorkspacePolicy,
          builder: (context, dynamic value, child) {
            return CustomFutureBuilder<NameValueDTOListResponse>(
              initFuture: () async {
                final result = await Repository().getWorkspacePolicyTypes();
                selectedWorkspacePolicy.value ??= result.result!.first.value;
                return result;
              },
              onSuccess: (context, snapshot) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (final workspacePolicy in snapshot.data!.result!)
                      CustomRadioListTile<int?>(
                        value: workspacePolicy.value,
                        groupValue: selectedWorkspacePolicy.value,
                        onChanged: (value) => selectedWorkspacePolicy.value = value,
                        title: Text(workspacePolicy.name!),
                      ),
                  ],
                );
              },
            );
          },
        ),
        actions: <AdaptiveAlertDialogAction>[
          AdaptiveAlertDialogAction(
            isPrimary: true,
            title: "Change",
            onPressed: () => Navigator.of(context).pop(selectedWorkspacePolicy.value),
          ),
          AdaptiveAlertDialogAction(
            title: "Cancel",
            onPressed: () => Navigator.of(context).pop(null),
          ),
        ],
      );
    },
  );
  if (selected != null) {
    final response = await showFutureProgressDialog<BoolResponse>(
      context: context,
      initFuture: () => Repository().updateEmployeeWorkspacePolicy(employeeId, selected),
    );
    if (response?.status ?? false) {
      await showAdaptiveAlertDialog(
        context: context,
        content: const Text("You have successfully updated work space policy."),
      );
      return true;
    } else {
      await showErrorDialog(context, response);
    }
  }

  return false;
}
