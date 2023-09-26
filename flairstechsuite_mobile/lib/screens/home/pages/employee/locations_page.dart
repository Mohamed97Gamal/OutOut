import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/views/location_status_icon.dart';
import 'package:flairstechsuite_mobile/views/location_tile.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
import 'package:flairstechsuite_mobile/widgets/basic/confirmation_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class LocationsPage extends StatelessWidget {
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
                padding: const EdgeInsets.all(10),
                child: Image.asset(ResourcesUtils.menu),
              ),
              onPressed: () {
                return Provider.of<menu.MenuController>(context, listen: false).toggle();
              },
            ),
            title: Text("My Locations".toUpperCase()),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                tooltip: "New Location",
                onPressed: () async {
                  final added = await Navigation.navToCreateLocation(context);
                  if (added == true) _refreshableKey.currentState!.refresh();
                },
              )
            ],
          ),
          body: Refreshable(
            key: _refreshableKey,
            child: RefreshIndicator(
              onRefresh: () async => _refreshableKey.currentState!.refresh(),
              child: CustomFutureBuilder<LocationDTOListResponse>(
                initFuture: () => Repository().getMyLocations(),
                onSuccess: (context, snapshot) {
                  final locationsList = snapshot.data!.result!.records!;
                  if (locationsList.isEmpty) {
                    return Center(child: Text("No Locations."));
                  }
                  return ListView.separated(
                    padding: const EdgeInsetsDirectional.only(top: 8, start: 16, end: 16, bottom: 32),
                    itemCount: locationsList.length,
                    separatorBuilder: (_, __) => const Divider(height: 12),
                    itemBuilder: (context, index) {
                      final location = locationsList[index];
                      return LocationTile(
                        location: location,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LocationStatusIcon(location.status),
                            const SizedBox(width: 12),
                            InkResponse(
                              child: Tooltip(
                                message: "Delete",
                                child: FaIcon(
                                  FontAwesomeIcons.solidTrashAlt,
                                  color: Theme.of(context).textTheme.subtitle1!.color,
                                ),
                              ),
                              onTap: () async {
                                final confirm = await showConfirmationDialog(
                                  context: context,
                                  actionText: "Delete location (${location.name})",
                                  icon: FontAwesomeIcons.solidTrashAlt,
                                );
                                if (confirm != true) return;

                                final response = await showFutureProgressDialog(
                                  context: context,
                                  initFuture: () => Repository().deleteLocation(location.id),
                                );
                                if (response?.status ?? false) {
                                  await showAdaptiveAlertDialog(
                                    context: context,
                                    content: const Text("You have successfully deleted the location."),
                                  );
                                  _refreshableKey.currentState!.refresh();
                                } else {
                                  await showErrorDialog(context, response);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
