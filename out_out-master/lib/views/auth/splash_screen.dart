import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../assets/image_assets.dart';
import '../../assets/logo_assets.dart';
import '../../data/api/api_repo.dart';
import '../../data/disk/disk_repo.dart';
import '../../data/memory/memory_repo.dart';
import '../../data/memory/providers/my_account_provider.dart';
import '../../navigation/deep_link_navigation.dart';
import '../../navigation/navigation.dart';
import '../../widgets/loading/future_builder.dart';
import '../../widgets/universal_image.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Stack(
        children: [
          Positioned(
            top: -120.0,
            left: -120.0,
            child: UniversalImage(ImageAssets.splash_left_corner_cut),
          ),
          Positioned(
            bottom: -120.0,
            right: -120.0,
            child: UniversalImage(ImageAssets.splash_right_corner_cut),
          ),
          Positioned.fill(
            child: CustomFutureBuilder<bool?>(
              onLoading: (context) => Center(
                child: UniversalImage(LogoAssets.outout_white),
              ),
              initFuture: () async {
                var initializationFuture = Future(() async {
                  await MemoryRepo().ensureInitialized();
                  await DiskRepo().ensureInitialized();
                  await ApiRepo().ensureInitialized();
                  final _appLinks = AppLinks();
                  if (Platform.isIOS) {
                    final uri = await _appLinks.getInitialAppLink();
                    if (uri != null) {
                      final PendingDynamicLinkData? data =
                          await FirebaseDynamicLinks.instance
                              .getDynamicLink(uri);
                      if (data != null) {
                        DeepLinkNavigation.initialLink = data.link.toString();
                      }
                    }
                  } else {
                    final initialDynamicLink =
                        await FirebaseDynamicLinks.instance.getInitialLink();
                    if (initialDynamicLink != null) {
                      DeepLinkNavigation.initialLink =
                          initialDynamicLink.link.toString();
                    }
                  }
                });
                final delayFuture = Future.delayed(Duration(seconds: 1));
                await Future.wait([initializationFuture, delayFuture]);

                final tokensData = DiskRepo().loadTokensData();
                if (tokensData != null) {
                  MemoryRepo().updateTokensData(tokensData);
                  try {
                    final userInfoResponse =
                        await ApiRepo().customersClient.getAccountInfo();
                    if (!userInfoResponse.status) {
                      //TODO: handle invalid userinfo w/ message
                      scheduleMicrotask(
                          () => Navigation().navToLoginScreen(context));
                      return;
                    }
                    context
                        .read<MyAccountProvider>()
                        .update(userInfoResponse.result);

                    scheduleMicrotask(
                        () => Navigation().navToHomeScreen(context));
                  } catch (ex) {
                    //TODO: handle invalid userinfo w/ message
                    scheduleMicrotask(
                        () => Navigation().navToLoginScreen(context));
                    return;
                  }
                } else {
                  scheduleMicrotask(
                      () => Navigation().navToLoginScreen(context));
                }
                return;
              },
              onSuccess: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
                return Center(
                  child: UniversalImage(LogoAssets.outout_white),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
