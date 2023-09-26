import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/notifier_utils.dart';
import '../../../../../widgets/basic/adaptive_alert_dialog.dart';
import '../../../../../widgets/basic/confirmation_dialog.dart';
import '../../../../../widgets/basic/refreshable.dart';
import '../../../data/repository/cycle_repository_impl.dart';
import '../../../domain/entity/cycle_entity.dart';

class CycleStatusRow extends StatelessWidget {
  final CycleEntity? cycle;
  final GlobalKey<RefreshableState>? refreshableKey;
  final bool? isDetailsScreen;

  const CycleStatusRow(
      {Key? key, this.cycle, this.refreshableKey, this.isDetailsScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cycleRepository = CycleRepositoryImpl();

    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        cycle!.isCurrent!
            ? Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    "Default",
                    style: theme.textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff73bfc7)),
                  ),
                ),
              )
            : Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      "Make Default".toUpperCase(),
                      style: theme.textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  onTap: () async {
                    final result = await showConfirmationDialog(
                      context: context,
                      icon: Icons.warning,
                      title: "Change Default cycle",
                      actionText:
                          "Are you sure you want to change the default cycle for all new employees to \"${cycle!.name}\"",
                    );
                    if (result) {
                      final response =
                          await cycleRepository.setCycleAsDefault(cycle!.id);
                      response.fold(
                        (error) => showErrorDialog(context, error.message),
                        (cycle) => showAdaptiveAlertDialog(
                                context: context,
                                content: Text(
                                    "(${this.cycle!.name}) was successfully set as the default Cycle"))
                            .then((value) =>
                                refreshableKey!.currentState!.refresh()),
                      );
                    }
                  },
                ),
              ),
        if (!isDetailsScreen!)
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: FaIcon(
                FontAwesomeIcons.trashAlt,
                size: 22,
                color: MyColors.darkGrayColor,
              ),
            ),
            onTap: () async {
              final result = await showConfirmationDialog(
                context: context,
                icon: Icons.warning,
                title: "Delete \"${cycle!.name}\"",
                trueTitle: "Delete",
                falseTitle: "Cancel",
                actionText:
                    "Cycle \"${cycle!.name}\" will be permanently deleted. Press delete to proceed.",
              );
              if (result) {
                final response = await cycleRepository.deleteCycle(cycle!.id);
                response.fold(
                  (error) => showErrorDialog(context, error.message),
                  (cycle) => showAdaptiveAlertDialog(
                          context: context,
                          content: Text(
                              "(${this.cycle!.name}) was successfully deleted"))
                      .then((value) => refreshableKey!.currentState!.refresh()),
                );
              }
            },
          ),
      ],
    );
  }
}
