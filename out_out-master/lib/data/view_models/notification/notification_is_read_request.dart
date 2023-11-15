class NotificationIsReadRequest {
  late List<String> notificationIds;

  NotificationIsReadRequest();

  @override
  String toString() {
    return 'NotificationIsReadRequest[notificationIds=$notificationIds]';
  }

  Map<String, dynamic> toJson() {
    return {'notificationIds': notificationIds};
  }

  NotificationIsReadRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    notificationIds = json['notificationIds'];
  }

  static List<NotificationIsReadRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<NotificationIsReadRequest>.empty()
        : json
            .map((value) => new NotificationIsReadRequest.fromJson(value))
            .toList();
  }

  static Map<String, NotificationIsReadRequest> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, NotificationIsReadRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NotificationIsReadRequest.fromJson(value));
    }
    return map;
  }
}
