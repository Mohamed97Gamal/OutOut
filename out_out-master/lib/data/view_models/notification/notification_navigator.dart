import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:out_out/navigation/navigation.dart';

class NotificationNavigator {
  Box? database;
  void init() {
    database = Hive.box<bool>('myBox');
  }

  void navigationHandler(
      String id, int notificationAction, BuildContext context) {
    switch (notificationAction) {
      case 1:
      case 7:
      case 8:
        Navigation()
            .navToVenueBookingDetailsScreen(context, venueBookingId: id);
        break;
      case 2:
      case 10:
        Navigation()
            .navToEventBookingDetailsScreen(context, eventBookingId: id);
        break;
      case 3:
      case 5:
        Navigation().navToVenueDetailsScreen(context, venueId: id);
        break;
      case 4:
        Navigation().navToEventDetailsScreen(context, occurrenceId: id);
        break;
      default:
        Navigation().navToNotificationsScreen(context);
    }
  }

  void appLifecycleStateHandler(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        database!.put("isDetached", false);
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        database!.put("isDetached", true);
        break;
      case AppLifecycleState.detached:
        database!.put("isDetached", true);
        break;
    }
  }
}
