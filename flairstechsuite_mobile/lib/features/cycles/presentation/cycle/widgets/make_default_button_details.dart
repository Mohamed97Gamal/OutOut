import 'package:flutter/material.dart';

import '../../../../../utils/notifier_utils.dart';
import '../../../../../widgets/basic/adaptive_alert_dialog.dart';
import '../../../../../widgets/basic/confirmation_dialog.dart';
import '../../../../../widgets/basic/refreshable.dart';
import '../../../data/repository/cycle_repository_impl.dart';

class MakeDefaultDetailsButton extends StatelessWidget {
  final GlobalKey<RefreshableState>? refreshableKey;
  final String? cycleName;
  final String? cycleId;
  const MakeDefaultDetailsButton(
      {Key? key, this.refreshableKey, this.cycleName, this.cycleId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      child: Text(
        "Make Default".toUpperCase(),
        style: theme.textTheme.subtitle2!.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.primaryColor,
        ),
      ),
      onTap: () async {
        final result = await showConfirmationDialog(
          context: context,
          icon: Icons.warning,
          title: "Change Default cycle",
          actionText:
              "Are you sure you want to change the default cycle for all new employees to \"${cycleName}\"",
        );
        if (result) {
          final response =
              await CycleRepositoryImpl().setCycleAsDefault(cycleId);
          response.fold(
            (error) => showErrorDialog(context, error.message),
            (cycle) => showAdaptiveAlertDialog(
                    context: context,
                    content: Text(
                        "(${cycleName}) was successfully set as the default Cycle"))
                .then((value) => refreshableKey!.currentState!.refresh()),
          );
        }
      },
    );
  }
}
