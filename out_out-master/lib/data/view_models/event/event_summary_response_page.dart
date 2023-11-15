import 'package:out_out/data/view_models/event/event_summary_response.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';

class EventSummaryResponsePage {
  int? nextPage;

  late int pageNumber;

  int? previousPage;

  late int pageSize;

  late int recordsTotalCount;

  late int totalPages;

  late List<EventSummaryResponse> records = [];

  EventSummaryResponsePage();

  PagedList<EventSummaryResponse> toPagedList() {
    return new PagedList<EventSummaryResponse>()
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
    return 'EventSummaryResponsePage[nextPage=$nextPage, pageNumber=$pageNumber, previousPage=$previousPage, pageSize=$pageSize, recordsTotalCount=$recordsTotalCount, totalPages=$totalPages, records=$records, ]';
  }

  EventSummaryResponsePage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    nextPage = json['nextPage'];
    pageNumber = json['pageNumber'];
    previousPage = json['previousPage'];
    pageSize = json['pageSize'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    records = EventSummaryResponse.listFromJson(json['records']);
  }

  Map<String, dynamic> toJson() {
    return {
      'nextPage': nextPage,
      'pageNumber': pageNumber,
      'previousPage': previousPage,
      'pageSize': pageSize,
      'recordsTotalCount': recordsTotalCount,
      'totalPages': totalPages,
      'records': records
    };
  }

  static List<EventSummaryResponsePage> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<EventSummaryResponsePage>.empty()
        : json.map((value) => new EventSummaryResponsePage.fromJson(value)).toList();
  }

  static Map<String, EventSummaryResponsePage> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EventSummaryResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new EventSummaryResponsePage.fromJson(value));
    }
    return map;
  }
}
