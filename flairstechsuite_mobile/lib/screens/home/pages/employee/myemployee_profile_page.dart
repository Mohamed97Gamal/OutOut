import 'package:flairstechsuite_mobile/enums/cycle_country.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/providers/my_profile_provider.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/date_utils.dart' as date_utils;
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/views/location_status_icon.dart';
import 'package:flairstechsuite_mobile/views/location_tile.dart';
import 'package:flairstechsuite_mobile/views/profile_property_tile.dart';
import 'package:flairstechsuite_mobile/views/profile_shift_tile.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_progress_indicator.dart';
import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
import 'package:flairstechsuite_mobile/widgets/basic/cached_network_image.dart';
import 'package:flairstechsuite_mobile/widgets/basic/confirmation_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class MyEmployeeProfilePage extends StatelessWidget {
    final bool isNavFromDrawer;

  final _refreshableKey = GlobalKey<RefreshableState>();

  MyEmployeeProfilePage({this.isNavFromDrawer = true});

  @override
  Widget build(BuildContext context) {
    return menu.DrawerScaffold(
      builder: (context) {
        return NotificationScaffold(
          bottomNavigationBar: const MyBottomNavigationBar(),
          body: Refreshable(
            key: _refreshableKey,
            child: RefreshIndicator(
              onRefresh: () async => _refreshableKey.currentState!.refresh(),
              child: CustomFutureBuilder<EmployeeProfileDTOResponse>(
                initFuture: () => Provider.of<MyProfileProvider>(context, listen: false).get(force: true),
                onLoading: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      leading: isNavFromDrawer
                          ? IconButton(
                        icon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(ResourcesUtils.menu),
                        ),
                        onPressed: () => Provider.of<menu.MenuController>(context, listen: false).toggle(),
                      )
                          : IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back)),
                      centerTitle: true,
                      title: Text("My Profile".toUpperCase()),
                      flexibleSpace: Container(height: 200.0),
                    ),
                    body: Center(
                      child: AdaptiveProgressIndicator(),
                    ),
                  );
                },
                onSuccess: (context, snapshot) {
                  final employeeDTO = snapshot.data!.result!;
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        expandedHeight: 200.0,
                        floating: false,
                        pinned: true,
                        leading: isNavFromDrawer
                            ? IconButton(
                          icon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(ResourcesUtils.menu),
                          ),
                          onPressed: () => Provider.of<menu.MenuController>(context, listen: false).toggle(),
                        )
                            : IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(Icons.arrow_back)),
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          centerTitle: true,
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              if (employeeDTO.fullName != null)
                                Text(
                                  employeeDTO.fullName!,
                                  style: TextStyle(fontSize: 18.0),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if (employeeDTO.title != null)
                                Text(
                                  employeeDTO.title!,
                                  style: TextStyle(fontSize: 10.0),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                          background: Center(
                            child: InkWell(
                              onTap: (employeeDTO?.profileImagePath ?? "").isEmpty
                                  ? null
                                  : () => Navigation.navToFullImage(context, employeeDTO.profileImagePath),
                              child: AvatarNetworkImage(
                                employeeDTO.profileImagePath,
                                width: 100.0,
                                height: 100.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            const SizedBox(height: 32.0),
                            ProfilePropertyTile(
                              name: "Email: ",
                              icon: Icon(FontAwesomeIcons.envelopeOpenText),
                              value: employeeDTO.organizationEmail,
                            ),
                            Divider(),
                            ProfilePropertyTile(
                              name: "Manager: ",
                              icon: Icon(FontAwesomeIcons.userTie),
                              value: employeeDTO.managerName ?? "No Manager",
                            ),
                            Divider(),
                            ProfilePropertyTile(
                              name: "Join Date: ",
                              icon: Icon(FontAwesomeIcons.calendarDay),
                              value: date_utils.DateUtils.dateFormat.format(employeeDTO.employmentDate!),
                            ),
                            Divider(),
                            ProfileShiftTile(
                              shift: employeeDTO.assignedShift,
                            ),
                            Divider(),
                            ProfilePropertyTile(
                              name: "Holiday Set: ",
                              icon: Icon(FontAwesomeIcons.calendar),
                              value: CycleCountry.fromJson(employeeDTO.country).name ?? "N/A",
                            ),
                            Divider(),
                            CustomFutureBuilder<NameValueDTOListResponse>(
                              initFuture: () => Repository().getWorkspacePolicyTypes(),
                              onSuccess: (context, snapshot) {
                                final nameValueDTOsList = snapshot.data!.result!;
                                return ProfilePropertyTile(
                                  name: "Work Space Policy: ",
                                  icon: Icon(FontAwesomeIcons.scroll),
                                  value:
                                      nameValueDTOsList.firstWhere((e) => e.value == employeeDTO.workspacePolicy).name,
                                );
                              },
                            ),
                            Divider(),
                            ProfilePropertyTile(
                              name: "Use Tenrox Tasks Feature",
                              icon: SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: Checkbox(
                                  value: employeeDTO.useTenroxTasksFeature,
                                  onChanged: null,
                                ),
                              ),
                              value: "",
                            ),
                            Divider(),
                            MyLocationsPropertyTile(),
                            const SizedBox(height: 80.0),
                          ],
                        ),
                      ),
                    ],
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

class MyLocationsPropertyTile extends StatelessWidget {
  final Map<String, bool> expansionStatus = {};

  MyLocationsPropertyTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.location_on),
              const SizedBox(width: 10.0),
              Text(
                "My Locations",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          CustomFutureBuilder<LocationDTOListResponse>(
            initFuture: () => Repository().getMyLocations(),
            onSuccess: (index, snapshot) {
              final locationsList = snapshot.data!.result!.records!;
              if (locationsList.isEmpty) return Text("No Locations.");
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (final location in locationsList)
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 32),
                      child: LocationTile(
                        location: location,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LocationStatusIcon(location.status),
                            const SizedBox(width: 12),
                            InkResponse(
                              child: Tooltip(
                                message: "Delete",
                                child: Icon(
                                  FontAwesomeIcons.solidTrashAlt,
                                  size: 20,
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
                                  Refreshable.of(context)!.refresh();
                                } else {
                                  await showErrorDialog(context, response);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
