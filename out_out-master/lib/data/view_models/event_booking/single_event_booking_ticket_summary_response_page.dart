import 'package:out_out/data/view_models/event_booking/single_event_booking_ticket_summary_response.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';

class SingleEventBookingTicketSummaryResponsePage {
  int? nextPage;

  late int pageNumber;

  int? previousPage;

  late int pageSize;

  late int recordsTotalCount;

  late int totalPages;

  late List<SingleEventBookingTicketSummaryResponse> records = [];

  SingleEventBookingTicketSummaryResponsePage();

  PagedList<SingleEventBookingTicketSummaryResponse> toPagedList() {
    return new PagedList<SingleEventBookingTicketSummaryResponse>()
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
    return 'SingleEventBookingTicketSummaryResponsePage[nextPage=$nextPage, pageNumber=$pageNumber, previousPage=$previousPage, pageSize=$pageSize, recordsTotalCount=$recordsTotalCount, totalPages=$totalPages, records=$records, ]';
  }

  SingleEventBookingTicketSummaryResponsePage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    nextPage = json['nextPage'];
    pageNumber = json['pageNumber'];
    previousPage = json['previousPage'];
    pageSize = json['pageSize'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    records = SingleEventBookingTicketSummaryResponse.listFromJson(json['records']);
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

  static List<SingleEventBookingTicketSummaryResponsePage> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<SingleEventBookingTicketSummaryResponsePage>.empty()
        : json.map((value) => new SingleEventBookingTicketSummaryResponsePage.fromJson(value)).toList();
  }

  static Map<String, SingleEventBookingTicketSummaryResponsePage> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, SingleEventBookingTicketSummaryResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SingleEventBookingTicketSummaryResponsePage.fromJson(value));
    }
    return map;
  }
}
