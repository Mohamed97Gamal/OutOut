import 'package:dartz/dartz.dart';
import 'package:flairstechsuite_mobile/core/network/failure.dart';
import 'package:flairstechsuite_mobile/features/cycles/data/repository/cycle_repository_impl.dart';
import 'package:flairstechsuite_mobile/features/cycles/domain/entity/cycle_entity.dart';
import 'package:flutter/material.dart';

import '../../../../repo/repository.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/navigation.dart';
import '../../../../widgets/basic/bottom_bar.dart';
import '../../../../widgets/basic/drawer_scaffold.dart'as menu;
import '../../../../widgets/basic/future_builder.dart';
import '../../../../widgets/basic/refreshable.dart';
import '../../../../widgets/notification_scaffold.dart';
import '../../data/model/cycle/cycle_dto.dart';
import '../holiday/widgets/holiday_item.dart';
import 'widgets/cycle_details_container.dart';

class CycleDetailsScreen extends StatelessWidget {
  final CycleEntity cycle;

  const CycleDetailsScreen({Key? key, required this.cycle})
      : assert(cycle != null);

  @override
  Widget build(BuildContext context) {
    final _refreshableKey = GlobalKey<RefreshableState>();

    return menu.DrawerScaffold(
      builder: (context) {
        return NotificationScaffold(
          backgroundColor: Colors.white,
          // Color(0xfff6f6f6),
          bottomNavigationBar: const MyBottomNavigationBar(),
          appBar: AppBar(
            centerTitle: true,
            title: SizedBox(
              height: 30,
              width: 400,
              child: FittedBox(
                child: Text(
                  "${cycle.name} HOLIDAYS".toUpperCase(),
                  maxLines: 1,
                  style:
                      TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                tooltip: "Add new Holiday",
                onPressed: () async {
                  final changed = await Navigation.navToCreatHoliday(
                    context,
                    cycle as CycleDTO,
                  );
                  if (changed != true) return;
                  _refreshableKey.currentState!.refresh();
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
            child: Column(
              children: [
                CycleDetailsContainer(
                  cycle: cycle,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Cycle Holidays",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColors.lightGrayColor,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Refreshable(
                    key: _refreshableKey,
                    child: RefreshIndicator(
                      onRefresh: () async =>
                          _refreshableKey.currentState!.refresh(),
                      child: CustomFutureBuilder<
                          Either<Failure, CycleDTOResponse>>(
                        initFuture: () =>
                            CycleRepositoryImpl().getCycleById(cycle.id),
                        onSuccess: (context, snapshot) {
                         return snapshot.data!.fold(
                              (l) => Text(l.message),
                              (response) => ListView.builder(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 8),
                            itemCount: response.result!.holidays!.length,
                            itemBuilder: (context, i) {
                              return HolidayItem(
                                cycle: response.result,
                                        holiday: response.result!.holidays![i],
                                refreshableKey: _refreshableKey,
                              );
                            },
                          ));
                        },
                      ),
                      // ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
