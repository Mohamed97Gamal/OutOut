import 'package:out_out/data/models/enums/notification_action.dart';

class NotificationResponse {
  late String id;

  String? affectedId;

  String? updatedEntityId;

  late String? title;

  late String? body;

  String? image;

  late NotificationAction? action;

  late DateTime sentDate;

  late bool isRead;

  NotificationResponse();

  @override
  String toString() {
    return 'NotificationResponse[id=$id, affectedId=$affectedId, title=$title, body=$body, image=$image, action=$action, sentDate=$sentDate, UpdatedEntityId=$updatedEntityId, isRead=$isRead]';
  }

  NotificationResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    affectedId = json['affectedId'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
    action = json['action'] == null
        ? null
        : NotificationAction.fromJson(json['action']);
    sentDate = DateTime.parse(json['sentDate']);
    updatedEntityId = json['updatedEntityId'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'affectedId': affectedId,
      'title': title,
      'body': body,
      'image': image,
      'action': action,
      'sentDate': sentDate.toUtc().toIso8601String(),
      'updatedEntityId': updatedEntityId,
      'isRead': isRead
    };
  }

  static List<NotificationResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<NotificationResponse>.empty()
        : json
            .map((value) => new NotificationResponse.fromJson(value))
            .toList();
  }

  static Map<String, NotificationResponse> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, NotificationResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NotificationResponse.fromJson(value));
    }
    return map;
  }
}
