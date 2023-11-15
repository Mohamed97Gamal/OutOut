import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:out_out/config.dart';
import 'package:out_out/data/memory/providers/bottom_navigation_bar_provider.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/outout_app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
///
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Directory dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  await Hive.openBox<bool>('myBox');
  await runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      await FirebaseCrashlytics.instance.setCustomKey("kEnvironment", kEnvironment.name);
    }
    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
      );
    }).sendPort);

    if (kEnvironment != Environment.production) {
      HttpOverrides.global = MyHttpOverrides();
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider.instance),
            ChangeNotifierProvider(create: (_) => MyAccountProvider()),
            ChangeNotifierProvider(create: (_) => SearchProvider.instance),
          ],
          child: OutOutApp(),
        ),
      ),
    );
  }, FirebaseCrashlytics.instance.recordError);
}
