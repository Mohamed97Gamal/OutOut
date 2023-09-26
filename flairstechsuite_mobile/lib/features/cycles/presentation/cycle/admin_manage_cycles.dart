
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/navigation.dart';
import '../../../../../utils/resources_utils.dart';
import '../../../../../widgets/basic/bottom_bar.dart';
import '../../../../../widgets/basic/drawer_scaffold.dart' as menu;
import '../../../../../widgets/basic/future_builder.dart';
import '../../../../../widgets/basic/refreshable.dart';
import '../../../../../widgets/notification_scaffold.dart';
import '../../data/model/cycle/cycle_dto.dart';
import '../../data/repository/cycle_repository_impl.dart';
import 'widgets/cycle_item.dart';

class ManageCyclesPage extends StatelessWidget {
  final _refreshableKey = GlobalKey<RefreshableState>();
  @override
  Widget build(BuildContext context) {
    return menu.DrawerScaffold(
      builder: (context) {
        return NotificationScaffold(
          bottomNavigationBar: const MyBottomNavigationBar(),
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(ResourcesUtils.menu),
              ),
              onPressed: () =>
                  Provider.of<menu.MenuController>(context, listen: false).toggle(),
            ),
            title: Text("Manage Cycles".toUpperCase()),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                tooltip: "Add new Cycle-",
                onPressed: () async {
                  final changed = await Navigation.navToCreateCycle(context);
                  if (changed != true) return;
                  _refreshableKey.currentState!.refresh();
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            child: Refreshable(
              key: _refreshableKey,
              child: RefreshIndicator(
                onRefresh: () async => _refreshableKey.currentState!.refresh(),
                child: CustomFutureBuilder<CycleDTOListResponse>(
                  initFuture: () => CycleRepositoryImpl().getAllCycles(),
                  onSuccess: (context, snapshot) {
                    final cycles = snapshot.data!.result!;
                    return ListView.separated(
                              padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemCount: cycles.length,
                        itemBuilder: (context, i) => CycleItemCard(
                              refreshableKey: _refreshableKey,
                              cycle: cycles[i],
                            ));
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
