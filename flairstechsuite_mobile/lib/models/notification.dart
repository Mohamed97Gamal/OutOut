import 'package:collection/collection.dart' show IterableExtension;
import 'package:equatable/equatable.dart';
import 'package:flairstechsuite_mobile/utils/common.dart';

class NotificationType extends Equatable {
  final int rawValue;

  const NotificationType._(this.rawValue) : assert(rawValue != null);

  static const createEditAnnouncement = NotificationType._(1);
  static const sendNotificationAnnouncement = NotificationType._(2);
  static const checkInOutReminder = NotificationType._(3);
  static const userRoleChanged = NotificationType._(4);
  static const tasksStatusChanged = NotificationType._(5);
  static const managerLocationRequest = NotificationType._(6);
  static const sendStartTaskReminder = NotificationType._(7);
  static const locationRequestStatusChanged = NotificationType._(8);
  static const tenroxRequestNotification = NotificationType._(9);

  @override
  List<Object> get props => [rawValue];

  static const values = [
    createEditAnnouncement,
    sendNotificationAnnouncement,
    checkInOutReminder,
    userRoleChanged,
    tasksStatusChanged,
    managerLocationRequest,
    sendStartTaskReminder,
    locationRequestStatusChanged,
    tenroxRequestNotification
  ];
}

enum NotificationSource { onLaunch, onResume, onMessage }

class NotificationContent extends Equatable {
  final String? title;
  final String? body;
  final NotificationSource? source;
  final NotificationType? type;
  final dynamic payload;

  const NotificationContent._({
    this.title,
    this.body,
    this.payload,
    this.source,
    this.type,
  }) : assert(source != null && type != null);

  @override
  List<Object?> get props => [title, body, source, type, payload];

  factory NotificationContent.parse(Map<String, dynamic> message,
      { NotificationSource? source}) {
    // TODO: Revise it after migration
    // if (source == null) return null;
    // if ((message ?? {}).isEmpty) return null;
    final data = Map<String, dynamic>.from(message["data"] ?? message);
    // if ((data ?? {}).isEmpty) return null;
    final payload = data["payload"];
    final typeInt =
        tryCast<int>(payload) ?? int.tryParse(tryCast<String>(payload) ?? "");
    final type = NotificationType.values
        .firstWhereOrNull((e) => e.rawValue == typeInt);
    if (type == null) {
      printIfDebug("Unknown notification type: $typeInt");
      // return null;
    }

    Map<String, dynamic> notification;
    if (message["notification"] != null) {
      notification = Map<String, dynamic>.from(message["notification"]);
    } else {
      final aps = Map<String, dynamic>.from(message["aps"] ?? {});
      notification = Map<String, dynamic>.from(aps["alert"] ?? {});
    }
    final title = nullIfEmpty(tryCast<String>(notification["title"]));
    final body = nullIfEmpty(tryCast<String>(notification["body"]));

    return NotificationContent._(
      title: title,
      body: body,
      type: type,
      source: source,
      payload: data["payload_parameter"],
    );
  }
}
