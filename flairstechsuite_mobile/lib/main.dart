import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
 //import 'package:device_preview/device_preview.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flairstechsuite_mobile/features/announcement/data/model/announcement_dto.dart';
import 'package:flairstechsuite_mobile/models/notification.dart';
import 'package:flairstechsuite_mobile/models/user_credentials.dart';
import 'package:flairstechsuite_mobile/navigation/my_router.dart';
import 'package:flairstechsuite_mobile/providers/manger_team.dart';
import 'package:flairstechsuite_mobile/providers/my_profile_provider.dart';
import 'package:flairstechsuite_mobile/features/announcement/presentation/manager/unread_announcements_provider.dart';
import 'package:flairstechsuite_mobile/utils/common.dart';
import 'package:flairstechsuite_mobile/utils/theme_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool showInvalidAuthData = false;

SharedPreferences? prefsInstance;
final firebaseMessaging = FirebaseMessaging.instance;

final appRefreshableKey = GlobalKey<RefreshableState>();
var navigatorKey = GlobalKey<NavigatorState>();

const defaultInitialRoute = MyRouter.splash;
var initialRoute = defaultInitialRoute;

final _localNotificationController = StreamController<NotificationContent>.broadcast();

Stream<NotificationContent> get localNotificationStream => _localNotificationController.stream;
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
      HttpOverrides.global = MyHttpOverrides();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  Connectivity().onConnectivityChanged.listen((event) {
    FirebaseCrashlytics.instance.setCustomKey("connectivity_type", event.index);
  });
  EquatableConfig.stringify = true;

  await firebaseMessaging.requestPermission();

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    _handleNotification(NotificationContent.parse(message.data, source: NotificationSource.onResume));
  });

  FirebaseMessaging.onMessage.listen((message) {
    _handleNotification(NotificationContent.parse(message.data, source: NotificationSource.onMessage));
  });

  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    _handleNotification(NotificationContent.parse(initialMessage.data, source: NotificationSource.onLaunch));
  }

  await _checkSecureStorageSafety();
  await _initPrefs();

  final ftApp = Refreshable(
    key: appRefreshableKey,
    onRefresh: () => printIfDebug("WARNING. App is refreshing."),
    child: FlairstrackerApp(),
  );

  //final app = FlairstrackerApp.isProduction ? ftApp : DevicePreview(enabled: true, builder: (context) => ftApp);

  runApp(ftApp);
}

_initPrefs() async {
  if (prefsInstance == null) prefsInstance = await SharedPreferences.getInstance();
}

// Workaround for old versions with corrupted SecureStorage
//  To be removed after a long migration period
Future<void> _checkSecureStorageSafety() async {
  printIfDebug("Checking SecureStorage safety");
  final storage = FlutterSecureStorage();
  try {
    try {
      await storage.readAll(iOptions: SecureStorageExt.defaultIosOptions);
    } on PlatformException catch (e) {
      printIfDebug("SecureStorage readAll error: " + e.toString());
      await storage.deleteAll(iOptions: SecureStorageExt.defaultIosOptions);
    }
  } catch (e) {
    printIfDebug("SecureStorage unknown error: " + e.toString());
  }
}

_handleNotification(NotificationContent? notification) async {
  if (notification == null) return;
  final announcementTypes = {NotificationType.sendNotificationAnnouncement, NotificationType.createEditAnnouncement};
  //  announcement notification
  if (announcementTypes.contains(notification.type)) {
    final announcementId = tryCast<String>(notification.payload);
    if (announcementId == null || announcementId.isEmpty == true) return;
    if (notification.source == NotificationSource.onResume) {
      _navigateToAnnouncement(announcementId);
    } else if (notification.source == NotificationSource.onMessage) {
      _localNotificationController.add(notification);
    } else if (notification.source == NotificationSource.onLaunch) {
      initialRoute = MyRouter.routeWithId(MyRouter.viewAnnouncementsDetails, id: announcementId);
    }
  }
  //  manager location notification
  else if (notification.type == NotificationType.managerLocationRequest) {
    if (notification.source == NotificationSource.onResume) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(MyRouter.managerLocationRequests, (_) => false);
    } else if (notification.source == NotificationSource.onMessage) {
      _localNotificationController.add(notification);
    } else if (notification.source == NotificationSource.onLaunch) {
      initialRoute = MyRouter.managerLocationRequests;
    }
  }
  // check In Out Reminder notification
  else if (notification.type == NotificationType.checkInOutReminder) {
    if (notification.source == NotificationSource.onResume) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(MyRouter.checkInOut, (_) => false);
    } else if (notification.source == NotificationSource.onMessage) {
      _localNotificationController.add(notification);
    } else if (notification.source == NotificationSource.onLaunch) {
      // CheckInOut is already the homepage;
    }
  }
  // user Role Changed notification
  else if (notification.type == NotificationType.userRoleChanged) {
    if (notification.source == NotificationSource.onMessage) {
      _localNotificationController.add(notification);
    }
  }
  // tasks Status Changed  notification
  else if (notification.type == NotificationType.tasksStatusChanged) {
    if (notification.source == NotificationSource.onMessage) {
      _localNotificationController.add(notification);
    }
  }
  // send Start Task Reminder notification
  else if (notification.type == NotificationType.sendStartTaskReminder) {
    if (notification.source == NotificationSource.onResume) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(MyRouter.myTasks, (_) => false);
    } else if (notification.source == NotificationSource.onMessage) {
      _localNotificationController.add(notification);
    } else if (notification.source == NotificationSource.onLaunch) {
      initialRoute = MyRouter.myTasks;
    }
  }
  //location Request Status Changed notification
  else if (notification.type == NotificationType.locationRequestStatusChanged) {
    if (notification.source == NotificationSource.onResume) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(MyRouter.myLocations, (_) => false);
    } else if (notification.source == NotificationSource.onMessage) {
      _localNotificationController.add(notification);
    } else if (notification.source == NotificationSource.onLaunch) {
      initialRoute = MyRouter.myLocations;
    }
  }
  //Self services notification
  else if (notification.type == NotificationType.tenroxRequestNotification) {
    if (notification.source == NotificationSource.onMessage) {
      _localNotificationController.add(notification);
    }
  } else {
    printIfDebug("unhandled notification ${notification.toString()}");
  }
}

_navigateToAnnouncement(String id) async {
  final result = await navigatorKey.currentState!.pushNamedAndRemoveUntil<bool>(
    MyRouter.routeWithId(MyRouter.viewAnnouncementsDetails, id: id),
    (r) => !r.settings.name!.startsWith(MyRouter.viewAnnouncementsDetails + "/"),
  );
  if (result == true) announcementReadStatusStream.add(null);
}

class FlairstrackerApp extends StatelessWidget {
  const FlairstrackerApp({Key? key}) : super(key: key);

  //Todo: Should be true when app is released for production
  //Todo: Firebase configurations should be also changed
  static const isProduction = true;

  @override
  Widget build(BuildContext context) {
    final app = MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UnreadAnnouncementsProvider()),
        ChangeNotifierProvider(create: (_) => MyProfileProvider()),
        ChangeNotifierProvider(create: (_) => Manager()),

      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: "FlairsTech Hub",
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        onGenerateRoute: MyRouter.generate,
        theme: generateAppTheme(context),
        initialRoute: initialRoute,
      ),
    );
    initialRoute = defaultInitialRoute;
    return app;
  }
}
