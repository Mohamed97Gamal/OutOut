import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/disk/disk_repo.dart';
import 'package:out_out/data/memory/memory_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/view_models/auth/logout_request.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/utils/share_utils.dart';
import 'package:out_out/widgets/avatar.dart';
import 'package:out_out/widgets/containers/custom_flat_scaffold.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_bottom_sheet.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAccountFullName = context.select<MyAccountProvider, String>(
      (myAccountProvider) => myAccountProvider.applicationUserResponse.fullName,
    );
    final myAccountProfileImage = context.select<MyAccountProvider, String?>(
      (myAccountProvider) => myAccountProvider.applicationUserResponse.profileImage,
    );
    return CustomFlatScaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: 120.0,
                padding: const EdgeInsets.only(top: 30.0),
                child: Card(
                  elevation: 8.0,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Positioned(
                top: 0.0,
                left: 16.0,
                bottom: 8.0,
                child: Row(
                  children: [
                    Avatar(myAccountProfileImage),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          myAccountFullName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Material(
            color: Theme.of(context).primaryColor,
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              color: Colors.white,
              child: Column(
                children: [
                  MyProfileNavigationItem(
                    titleText: "My Account",
                    onTap: () => Navigation().navToMyAccountScreen(context),
                  ),
                  MyProfileNavigationItem(
                    titleText: "My Favorites",
                    onTap: () => Navigation().navToMyFavouritesScreen(context),
                  ),
                  MyProfileNavigationItem(
                    titleText: "My Bookings",
                    onTap: () => Navigation().navToTabsViewScreen(context),
                  ),
                  MyProfileNavigationItem(
                    titleText: "My Offers",
                    onTap: () => Navigation().navToMyOffersScreen(context),
                  ),
                  MyProfileNavigationItem(
                    titleText: "My Shared Tickets",
                    onTap: () => Navigation().navToMyEventSharedTicketsScreen(context),
                  ),
                  MyProfileNavigationItem(
                    titleText: "My Loyalty",
                    onTap: () => Navigation().navToMyLoyaltyScreen(context),
                  ),
                  MyProfileNavigationItem(
                    titleText: "Invite A Friend",
                    onTap: () => shareApp(),
                  ),
                  MyProfileNavigationItem(
                    titleText: "Settings",
                    onTap: () => Navigation().navToSettingsScreen(context),
                  ),
                  MyProfileNavigationItem(
                    titleText: "Customer Service",
                    onTap: () => Navigation().navToCustomerServiceScreen(context),
                  ),
                  MyProfileNavigationItem(
                    titleText: "FAQs",
                    onTap: () => Navigation().navToFAQScreen(context),
                  ),
                  MyProfileNavigationItem(
                    titleText: "Logout",
                    onTap: () => _handleLogout(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _handleLogout(BuildContext context) async {
    await showAdaptiveBottomSheet(
      context: context,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "Are you sure you want to log out from OutOut?",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      actions: <AdaptiveBottomSheetAction>[
        AdaptiveBottomSheetAction(
          title: "Yes",
          onPressed: () async {
            await showFutureProgressDialog(
              context: context,
              initFuture: () async {
                try {
                  //Ignore any error to logout anyways
                  final request = new LogoutRequest()..firebaseMessagingToken = await FirebaseMessaging.instance.getToken();
                  await ApiRepo().authClient.logout(request);
                } catch (_) {}

                MemoryRepo().deleteTokensData();
                await DiskRepo().deleteTokensData();
              },
            );
            Navigation().navToLoginScreen(context);
          },
          isPrimary: true,
        ),
        AdaptiveBottomSheetAction(
          title: "No",
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class MyProfileNavigationItem extends StatelessWidget {
  final String titleText;
  final Function() onTap;

  const MyProfileNavigationItem({
    Key? key,
    required this.titleText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(titleText),
          ),
          trailing: Icon(Icons.arrow_forward_ios_outlined),
          onTap: onTap,
        ),
        Divider(
          indent: 16.0,
          height: 1.0,
        ),
      ],
    );
  }
}
