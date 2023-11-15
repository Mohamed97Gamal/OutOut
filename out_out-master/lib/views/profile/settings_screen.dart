import 'dart:async';

import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/assets/logo_assets.dart';
import 'package:out_out/config.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/memory_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/view_models/update_notifications_allowed_request.dart';
import 'package:out_out/data/view_models/update_reminders_allowed_request.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showChangeLocation: true,
      headerHeight: 120.0,
      header: HeaderTitleText("Settings"),
      bodyPadding: const EdgeInsets.symmetric(vertical: 16.0),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 16.0),
              UniversalImage(
                IconAssets.account,
                width: 20.0,
                height: 20.0,
              ),
              const SizedBox(width: 4.0),
              TitleText('Account'),
            ],
          ),
          const SizedBox(height: 24.0),
          ListTile(
            title: Text('Change Password',
                style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigation().navToChangePasswordScreen(context),
          ),
          Divider(),
          ListTile(
            title:
                Text('Language', style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: Text('English,EN'),

          ),
          Divider(),
          const SizedBox(height: 24.0),
          Row(
            children: [
              const SizedBox(width: 16.0),
              UniversalImage(
                IconAssets.notification,
                width: 30.0,
                height: 30.0,
              ),
              const SizedBox(width: 4.0),
              TitleText('Notifications'),
            ],
          ),
          const SizedBox(height: 24.0),
          NotificationsSwitch(),
          Divider(),
          RemindersSwitch(),
          Divider(),
          Row(
            children: [
              const SizedBox(width: 16.0),
              Icon(Icons.info_outline, size: 30.0),
              const SizedBox(width: 4.0),
              TitleText('About'),
            ],
          ),
          const SizedBox(height: 24.0),
          AboutListTile(
            applicationName: MemoryRepo().packageInfo.appName,
            applicationVersion: "${MemoryRepo().packageInfo.version} (${MemoryRepo().packageInfo.buildNumber})",
            aboutBoxChildren: [
              Text("• Environment: ${kEnvironment.name}"),
              Text("• Package Name: ${MemoryRepo().packageInfo.packageName}"),
            ],
            applicationIcon: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: UniversalImage(
                  LogoAssets.outout_white,
                ),
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class NotificationsSwitch extends StatelessWidget {
  const NotificationsSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAccountNotificationsAllowed = context.select<MyAccountProvider, bool>(
      (myAccountProvider) => myAccountProvider.applicationUserResponse.notificationsAllowed,
    );
    return SwitchListTile.adaptive(
      value: myAccountNotificationsAllowed,
      title:
          Text('Notification', style: TextStyle(fontWeight: FontWeight.w600)),
      onChanged: (bool newValue) async {
        final request = new UpdateNotificationsAllowedRequest(newValue);
        final updateNotificationsAllowedResult = await showFutureProgressDialog(
          context: context,
          initFuture: () => ApiRepo().customersClient.updateNotificationsAllowed(request),
        );
        if (updateNotificationsAllowedResult != null && updateNotificationsAllowedResult.status) {
          scheduleMicrotask(() {
            context.read<MyAccountProvider>().update(updateNotificationsAllowedResult.result);
          });
        } else {
          await showAdaptiveErrorDialog(
            context: context,
            title: "Error",
            content: updateNotificationsAllowedResult?.errorMessage ?? "Unknown Error",
          );
        }
      },
    );
  }
}

class RemindersSwitch extends StatelessWidget {
  const RemindersSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAccountRemindersAllowed = context.select<MyAccountProvider, bool>(
      (myAccountProvider) => myAccountProvider.applicationUserResponse.remindersAllowed,
    );
    return SwitchListTile.adaptive(
      value: myAccountRemindersAllowed,
      title: Text('Reminders', style: TextStyle(fontWeight: FontWeight.w600)),
      onChanged: (bool newValue) async {
        final request = new UpdateRemindersAllowedRequest(newValue);
        final updateRemindersAllowedResult = await showFutureProgressDialog(
          context: context,
          initFuture: () => ApiRepo().customersClient.updateRemindersAllowed(request),
        );
        if (updateRemindersAllowedResult != null && updateRemindersAllowedResult.status) {
          scheduleMicrotask(() {
            context.read<MyAccountProvider>().update(updateRemindersAllowedResult.result);
          });
        } else {
          await showAdaptiveErrorDialog(
            context: context,
            title: "Error",
            content: updateRemindersAllowedResult?.errorMessage ?? "Unknown Error",
          );
        }
      },
    );
  }
}
