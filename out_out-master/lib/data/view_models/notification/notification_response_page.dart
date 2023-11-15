import 'package:out_out/data/view_models/notification/notification_response.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';

class NotificationResponsePage {
  int? nextPage;

  late int pageNumber;

  int? previousPage;

  late int pageSize;

  late int recordsTotalCount;

  late int totalPages;

  late int unReadNotificationsCount;

  late List<NotificationResponse> records = [];

  NotificationResponsePage();

  PagedList<NotificationResponse> toPagedList() {
    return new PagedList<NotificationResponse>()
      ..pageSize = pageSize
      ..previousPage = previousPage
      ..pageNumber = pageNumber
      ..nextPage = nextPage
      ..recordsTotalCount = recordsTotalCount
      ..totalPages = totalPages
      ..records = records;
  }

  @override
  String toString() {
    return 'NotificationResponsePage[nextPage=$nextPage, pageNumber=$pageNumber, previousPage=$previousPage, pageSize=$pageSize, recordsTotalCount=$recordsTotalCount, totalPages=$totalPages, records=$records, UnReadNotificationsCount=$unReadNotificationsCount]';
  }

  NotificationResponsePage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    nextPage = json['nextPage'];
    pageNumber = json['pageNumber'];
    previousPage = json['previousPage'];
    pageSize = json['pageSize'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    records = NotificationResponse.listFromJson(json['records']);
    unReadNotificationsCount = json['unReadNotificationsCount'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nextPage': nextPage,
      'pageNumber': pageNumber,
      'previousPage': previousPage,
      'pageSize': pageSize,
      'recordsTotalCount': recordsTotalCount,
      'totalPages': totalPages,
      'records': records,
      'unReadNotificationsCount': unReadNotificationsCount
    };
  }

  static List<NotificationResponsePage> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<NotificationResponsePage>.empty()
        : json
            .map((value) => new NotificationResponsePage.fromJson(value))
            .toList();
  }

  static Map<String, NotificationResponsePage> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, NotificationResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NotificationResponsePage.fromJson(value));
    }
    return map;
  }
}

class NotificationCountResponse {
  late int unReadNotificationsCount;

  @override
  String toString() {
    return 'NotificationCountResponse[UnReadNotificationsCount=$unReadNotificationsCount]';
  }

  NotificationCountResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    unReadNotificationsCount = json['unReadNotificationsCount'];
  }

  static List<NotificationResponsePage> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<NotificationResponsePage>.empty()
        : json
            .map((value) => new NotificationResponsePage.fromJson(value))
            .toList();
  }

  static Map<String, NotificationResponsePage> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, NotificationResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NotificationResponsePage.fromJson(value));
    }
    return map;
  }
}
