import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/models/organization_dto.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/utils/url_launcher_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
import 'package:flairstechsuite_mobile/widgets/basic/cached_network_image.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
import 'package:flairstechsuite_mobile/widgets/basic/scale_down.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage>
    with SingleTickerProviderStateMixin {
  final _orgInfoRefreshableKey = GlobalKey<RefreshableState>();
  final _orgSettingsRefreshableKey = GlobalKey<RefreshableState>();
  final tabs = [
    Tab(text: "Info".toUpperCase()),
    Tab(text: "Settings".toUpperCase()),
  ];

  TabController? _tabController;
  SettingsDTO? settingsDTO;
  OrganizationDTO? organizationDTO;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

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
            title: ScaleDown(child: Text("Company Information".toUpperCase())),
            bottom: TabBar(
              controller: _tabController,
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              orgInfoTabView(),
              orgSettingsTabView(),
            ],
          ),
        );
      },
    );
  }

  Widget orgInfoTabView() {
    return Refreshable(
      key: _orgInfoRefreshableKey,
      child: RefreshIndicator(
        onRefresh: () async => _orgInfoRefreshableKey.currentState!.refresh(),
        child: CustomFutureBuilder<OrganizationDTOResponse>(
          initFuture: () => Repository().getMyOrganizationDetails(),
          onSuccess: (context, snapshot) {
            organizationDTO = snapshot.data!.result;
            return ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Color(0xff707070),
                        width: 1.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffE2E2E2),
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ],
                  ),
                  //color: Theme.of(context).primaryColor,
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: CustomCachedNetworkImage(
                      organizationDTO!.logoPath,
                      fitMode: BoxFit.contain,
                      width: double.infinity,
                      height: 120.0,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                OrganizationInfoTile(
                  name: "Business: ",
                  icon: const Icon(Icons.home),
                  value: organizationDTO!.business,
                ),
                const Divider(),
                OrganizationInfoTile(
                  name: "Contact: ",
                  icon: const Icon(
                    IconData(
                      0xe0cd,
                      fontFamily: 'MaterialIcons',
                      matchTextDirection: true,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  value: organizationDTO!.contactNumber ?? "",
                  onPressed: () =>
                      launchURL("tel://${organizationDTO!.contactNumber}"),
                ),
                const Divider(),
                OrganizationInfoTile(
                  name: "Website: ",
                  icon: Icon(Icons.language),
                  value: organizationDTO!.website,
                  onPressed: () => launchURL("${organizationDTO!.website}"),
                ),
                const Divider(),
                OrganizationAddressesPropertyTile(
                  organizationDTO: organizationDTO,
                ),
                const Divider(),
                OrganizationDomainsTile(
                  organizationDTO: organizationDTO,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget orgSettingsTabView() {
    return Refreshable(
      key: _orgSettingsRefreshableKey,
      child: RefreshIndicator(
        onRefresh: () async =>
            _orgSettingsRefreshableKey.currentState!.refresh(),
        child: CustomFutureBuilder<SettingsDTOResponse>(
          initFuture: () => Repository().getMyOrganizationSettings(),
          onSuccess: (context, snapshot) {
            settingsDTO = snapshot.data!.result;
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.edit),
                onPressed: () async {
                  final changed = await Navigation.navToUpdateOrgSettings(
                      context, settingsDTO);
                  if (changed == true)
                    _orgSettingsRefreshableKey.currentState!.refresh();
                },
              ),
              body: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 32.0),
                children: <Widget>[
                  OrganizationInfoTile(
                    name: "Time Zone: ",
                    icon: Icon(Icons.watch),
                    value: settingsDTO!.regionTimeZoneName,
                  ),
                  const Divider(),
                  OrganizationInfoTile(
                    name: "Location Radius: ",
                    icon: Icon(Icons.wifi_tethering),
                    value: settingsDTO!.locationRadius.toString(),
                    suffix: "meters",
                  ),
                  const Divider(),
                  OrganizationInfoTile(
                    name: "Minimum Task Time: ",
                    icon: Icon(Icons.timer),
                    value: settingsDTO!.minimumTaskTime.toString(),
                    suffix: "minutes",
                  ),
                  const Divider(),
                  OrganizationInfoTile(
                    name: "Check Out Reminder Margin: ",
                    icon: Icon(Icons.av_timer),
                    value: settingsDTO!.checkOutReminderMargin.toString(),
                    suffix: "minutes",
                  ),
                  const Divider(),
                  OrganizationInfoTile(
                    name: "Maximum Locations: ",
                    icon: Icon(Icons.not_listed_location),
                    value: settingsDTO!.maxLocations.toString(),
                  ),
                  const Divider(),
                  OrganizationInfoTile(
                    name: "Manual Check In/Out: ",
                    icon: Icon(Icons.location_searching),
                    value: settingsDTO!.allowManualCheckInOut.toString(),
                  ),
                  const Divider(),
                  OrganizationInfoTile(
                    name: "Automatic Check In/Out: ",
                    icon: Icon(Icons.my_location),
                    value: settingsDTO!.allowAutomaticCheckInOut.toString(),
                  ),
                  const Divider(),
                  OrganizationInfoTile(
                    name: "Tenrox Tasks Feature: ",
                    icon: Icon(Icons.hourglass_empty),
                    value: settingsDTO!.useTenroxTasksFeature.toString(),
                  ),
                  const Divider(),
                  OrganizationInfoTile(
                    name: "Tenrox Check In/Out Feature: ",
                    icon: Icon(Icons.fingerprint),
                    value: settingsDTO!.useTenroxCheckInOutFeature.toString(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class OrganizationInfoTile extends StatelessWidget {
  const OrganizationInfoTile({
    Key? key,
    required this.name,
    required this.icon,
    required this.value,
    this.onPressed,
    this.suffix,
  }) : super(key: key);

  final String name;
  final String? value;
  final Widget icon;
  final Function? onPressed;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed as void Function()?,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(width: 10.0),
            Expanded(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text(
                    "$name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                  (value?.toLowerCase() == "true" ||
                          value?.toLowerCase() == "false")
                      ? Icon((value == "true") ? Icons.check : Icons.close,
                          color: (value == "true") ? Colors.green : Colors.red)
                      : Text(
                          "$value",
                          softWrap: true,
                          style: TextStyle(
                            decoration: onPressed != null
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                        ),
                  if (suffix != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(suffix!),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrganizationDomainsTile extends StatelessWidget {
  final OrganizationDTO? organizationDTO;

  const OrganizationDomainsTile({
    Key? key,
    this.organizationDTO,
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
              Icon(Icons.domain),
              const SizedBox(width: 10.0),
              Text(
                "Domains:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          if (organizationDTO!.domains!.isEmpty) Text("No Domains."),
          for (final domain in organizationDTO!.domains!)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  domain ?? "",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w100),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class OrganizationAddressesPropertyTile extends StatelessWidget {
  final OrganizationDTO? organizationDTO;

  const OrganizationAddressesPropertyTile({
    Key? key,
    this.organizationDTO,
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
                "Addresses:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          if (organizationDTO!.addresses!.isEmpty) Text("No Addresses."),
          for (final address in organizationDTO!.addresses!)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      address.name ?? "",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      address.description ?? "",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
