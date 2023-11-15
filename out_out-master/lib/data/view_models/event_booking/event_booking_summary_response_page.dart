import 'package:out_out/data/view_models/event_booking/event_booking_summary_response.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';

class EventBookingSummaryResponsePage {
   int? nextPage;

  late int pageNumber;

   int? previousPage;

  late int pageSize;

  late int recordsTotalCount;

  late int totalPages;

  List<EventBookingSummaryResponse> records = [];

  EventBookingSummaryResponsePage();

  PagedList<EventBookingSummaryResponse> toPagedList() {
    return new PagedList<EventBookingSummaryResponse>()
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
    return 'EventBookingSummaryResponsePage[nextPage=$nextPage, pageNumber=$pageNumber, previousPage=$previousPage, pageSize=$pageSize, recordsTotalCount=$recordsTotalCount, totalPages=$totalPages, records=$records, ]';
  }

  EventBookingSummaryResponsePage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    nextPage = json['nextPage'];
    pageNumber = json['pageNumber'];
    previousPage = json['previousPage'];
    pageSize = json['pageSize'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    records = EventBookingSummaryResponse.listFromJson(json['records']);
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

  static List<EventBookingSummaryResponsePage> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<EventBookingSummaryResponsePage>.empty()
        : json.map((value) => new EventBookingSummaryResponsePage.fromJson(value)).toList();
  }

  static Map<String, EventBookingSummaryResponsePage> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, EventBookingSummaryResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new EventBookingSummaryResponsePage.fromJson(value));
    }
    return map;
  }
}
