import 'package:dartz/dartz.dart';
import 'package:flairstechsuite_mobile/core/network/failure.dart';
import 'package:flairstechsuite_mobile/features/cycles/domain/entity/cycle_entity.dart';
import 'package:flairstechsuite_mobile/features/cycles/presentation/cycle/widgets/headline_text.dart';
import 'package:flairstechsuite_mobile/features/cycles/presentation/cycle/widgets/make_default_button_details.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../repo/repository.dart';
import '../../../../../utils/colors.dart';
import '../../../../../widgets/basic/confirmation_dialog.dart';
import '../../../../../widgets/basic/future_builder.dart';
import '../../../../../widgets/basic/refreshable.dart';
import '../../../data/model/cycle/cycle_dto.dart';
import '../../../data/repository/cycle_repository_impl.dart';

class CycleDetailsContainer extends StatelessWidget {
  final CycleEntity? cycle;

  const CycleDetailsContainer({
    Key? key,
    this.cycle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _refreshableKey = GlobalKey<RefreshableState>();

    return Container(
      alignment: Alignment.center,
      height: 135,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  HeadlineText(
                      title: 'Country:', subtitle: getCountry(cycle!.country)),
                  const SizedBox(height: 15),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Text(
                          DateFormat('dd-MM-yyyy').format(cycle!.from!.toLocal()),
                          style: const TextStyle(
                            color: MyColors.lightGrayColor,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const VerticalDivider(
                          color: Color(0xffD13827),
                          thickness: 2,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          DateFormat('dd-MM-yyyy').format(cycle!.to!.toLocal()),
                          style: const TextStyle(
                            color: MyColors.lightGrayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Refreshable(
                    key: _refreshableKey,
                    child:
                        CustomFutureBuilder<Either<Failure, CycleDTOResponse>>(
                      onLoading: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      initFuture: () =>
                          CycleRepositoryImpl().getCycleById(cycle!.id),
                      onSuccess: (context, snapshot) {
                        final cycle = snapshot.data!.fold(
                            (error) => error.message, ((cycle) => cycle.result!));

                        return cycle.isCurrent!
                            ? HeadlineText(
                                title: 'Status:',
                                subtitle: "Default",
                                color: MyColors.greenColor)
                            : MakeDefaultDetailsButton(
                                cycleId: cycle.id,
                                cycleName: cycle.id,
                                refreshableKey: _refreshableKey,
                              );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
            endIndent: .5,
            indent: .5,
            thickness: 2,
          ),
        ],
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
}
