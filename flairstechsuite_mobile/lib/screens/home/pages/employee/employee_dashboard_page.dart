import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/screens/home/pages/admin/admin_dashboard_page.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/utils/url_launcher_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
import 'package:flairstechsuite_mobile/widgets/basic/cached_network_image.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EmployeeDashboardPage extends StatelessWidget {
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
              onPressed: () => Provider.of<menu.MenuController>(context, listen: false).toggle(),
            ),
            title: Text("My Company".toUpperCase()),
          ),
          body: Refreshable(
            key: _refreshableKey,
            child: RefreshIndicator(
              onRefresh: () async => _refreshableKey.currentState!.refresh(),
              child: CustomFutureBuilder<OrganizationDTOResponse>(
                initFuture: () => Repository().getMyOrganizationDetails(),
                onSuccess: (context, snapshot) {
                  final organizationDTO = snapshot.data!.result!;
                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xff707070), width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(color: Color(0xffE2E2E2), offset: Offset(0.0, 2.0), blurRadius: 6.0)],
                        ),
                        //color: Theme.of(context).primaryColor,
                        child: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(15),
                          child: CustomCachedNetworkImage(
                            organizationDTO.logoPath,
                            fitMode: BoxFit.contain,
                            width: double.infinity,
                            height: 120.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      OrganizationInfoTile(
                        name: "Business: ",
                        icon: Icon(Icons.home),
                        value: organizationDTO.business,
                      ),
                      const Divider(),
                      OrganizationInfoTile(
                        name: "Contact: ",
                        icon: Icon(
                          const IconData(
                            0xe0cd,
                            fontFamily: 'MaterialIcons',
                            matchTextDirection: true,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        value: organizationDTO.contactNumber,
                        onPressed: () => launchURL("tel://${organizationDTO.contactNumber}"),
                      ),
                      const Divider(),
                      OrganizationInfoTile(
                        name: "Website: ",
                        icon: Icon(Icons.language),
                        value: organizationDTO.website,
                        onPressed: () => launchURL("${organizationDTO.website}"),
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
          ),
        );
      },
    );
  }
}
