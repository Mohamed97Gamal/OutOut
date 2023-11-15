import 'package:out_out/data/view_models/notification/notification_response_page.dart';

class NotificationResponsePageOperationResult {
  late bool status;

  late NotificationResponsePage result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  NotificationResponsePageOperationResult();

  @override
  String toString() {
    return 'NotificationResponsePageOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  NotificationResponsePageOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new NotificationResponsePage.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<NotificationResponsePageOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<NotificationResponsePageOperationResult>.empty()
        : json.map((value) => new NotificationResponsePageOperationResult.fromJson(value)).toList();
  }

  static Map<String, NotificationResponsePageOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, NotificationResponsePageOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NotificationResponsePageOperationResult.fromJson(value));
    }
    return map;
  }
}
