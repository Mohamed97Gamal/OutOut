import 'package:flairstechsuite_mobile/features/cycles/domain/entity/cycle_entity.dart';
import 'package:flairstechsuite_mobile/features/cycles/presentation/cycle/widgets/cycle_status_row.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/navigation.dart';
import '../../../../../widgets/basic/confirmation_dialog.dart';
import '../../../../../widgets/basic/refreshable.dart';
import '../../../data/model/cycle/cycle_dto.dart';
import '../../../data/repository/cycle_repository_impl.dart';

class CycleItemCard extends StatelessWidget {
  final CycleEntity? cycle;

  final bool isDetailsScreen;
  final GlobalKey<RefreshableState>? refreshableKey;
  const CycleItemCard({
    Key? key,
    this.cycle,
    this.isDetailsScreen = false,
    this.refreshableKey,
    // this.delete
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => isDetailsScreen ? null : _onCycleDetails(context, cycle),
      child: Card(
        borderOnForeground: true,
        clipBehavior: Clip.antiAlias,
        child: ClipPath(
          child: Container(
            // height: 100,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.grey, width: 1.0),
                right: BorderSide(color: Colors.grey, width: 1.0),
                bottom: BorderSide(color: Colors.grey, width: 1.0),
                top: BorderSide(
                    color: cycle!.isCurrent! ? Color(0xff73bfc7) : Colors.red,
                    width: 6),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              height: 140,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsetsDirectional.only(
                                end: cycle!.isCurrent! ? 28 : 0),
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              cycle!.name!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.darkGrayColor,
                                  fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Country: ',
                                  style: TextStyle(
                                      color: Color(0xffD13827),
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: getCountry(cycle!.country),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(cycle!.from!.toLocal()),
                                  style:
                                      TextStyle(color: MyColors.lightGrayColor),
                                ),
                                const SizedBox(width: 5),
                                VerticalDivider(
                                  color: Color(0xffD13827),
                                  thickness: 2,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(cycle!.to!.toLocal()),
                                  style:
                                      TextStyle(color: MyColors.lightGrayColor),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      height: 1,
                      endIndent: .5,
                      indent: .5,
                      thickness: 2,
                    ),
                  ),
                 CycleStatusRow(
                    cycle: cycle,
                    isDetailsScreen: isDetailsScreen,
                    refreshableKey: refreshableKey,
                  )
                ],
              ),
            ),
          ),
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          )),
        ),
      ),
    );
  }

  String? getCountry(int? val) {
    switch (val) {
      case 0:
        return "Egypt";
      case 1:
        return "Canada";
      case 2:
        return "Poland";
      case 3:
        return "USA";
      default:
        return null;
    }
  }

  _onCycleDetails(BuildContext context, CycleEntity? cycle) {
    Navigation.navToCycleDetails(context, cycle as CycleDTO?);
  }
}
