import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/notifier_utils.dart';
import '../../../../../widgets/basic/adaptive_alert_dialog.dart';
import '../../../../../widgets/basic/confirmation_dialog.dart';
import '../../../../../widgets/basic/refreshable.dart';
import '../../../data/repository/holiday_repository_impl.dart';
import '../../../domain/entity/cycle_entity.dart';
import '../../../domain/entity/holiday_entity.dart';
import '../edit_holiday_screen.dart';

class HolidayItem extends StatelessWidget {
  final CycleEntity? cycle;
  final HolidayEntity holiday;
  final GlobalKey<RefreshableState> refreshableKey;
  const HolidayItem({
    Key? key,
    required this.cycle,
    required this.holiday,
    required this.refreshableKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        side: BorderSide(color: Colors.grey),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              holiday.name!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Color(0xff131315),
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: IntrinsicHeight(
              child: Row(
                children: [
                  Text(
                    DateFormat('dd-MM-yyyy').format(holiday.from!.toLocal()),
                    style: TextStyle(color: Color(0xffD13827), fontSize: 14),
                  ),
                  const VerticalDivider(
                    color: MyColors.lightGrayColor,
                    thickness: 2,
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(holiday.to!.toLocal()),
                    style: TextStyle(color: Color(0xffD13827), fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Divider(
              color: MyColors.lightGrayColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Icon(
                    FontAwesomeIcons.edit,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () async {
                    final changed = await Navigator.of(context)
                        .push(MaterialPageRoute<bool>(
                            builder: (_) => EditHolidayScreen(
                                  cycle: cycle,
                                  holiday: holiday,
                                  refreshableKey: refreshableKey,
                                )));
                    if (changed != true) return;
                    refreshableKey.currentState!.refresh();
                  },
                ),
                InkWell(
                  child: const FaIcon(
                    FontAwesomeIcons.trashAlt,
                    size: 20,
                    color: MyColors.darkGrayColor,
                  ),
                  onTap: () async {
                    final result = await showConfirmationDialog(
                      context: context,
                      icon: Icons.warning,
                      trueTitle: "Delete",
                      falseTitle: "Cancel",
                      title: "Delete \"${holiday.name}\"",
                      actionText:
                          "Holiday \"${holiday.name}\" will be permanently deleted. Press delete to proceed.",
                    );
                    if (result) {
                   final response = await HolidayRepositoryImpl()
                          .deleteHoliday(cycle!.id, holiday.id);
                      response.fold(
                          (error) async =>
                              await showErrorDialog(context, error.message),
                          (r) async => await showAdaptiveAlertDialog(
                                context: context,
                                content: Text(
                                  "Holiday (${holiday.name}) has been deleted successfully",
                                ),
                              ).then((value) =>
                                  refreshableKey.currentState!.refresh()));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
