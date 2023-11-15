import 'package:out_out/data/view_models/venue/venue_summary_response.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';

class VenueSummaryResponsePage {
  late int pageSize;
  int? previousPage;
  late int pageNumber;
  int? nextPage;
  late int recordsTotalCount;
  late int totalPages;

  List<VenueSummaryResponse> records = [];

  VenueSummaryResponsePage();

  PagedList<VenueSummaryResponse> toPagedList() {
    return new PagedList<VenueSummaryResponse>()
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
    return 'VenueSummaryResponsePage[nextPage=$nextPage, pageNumber=$pageNumber, previousPage=$previousPage, pageSize=$pageSize, recordsTotalCount=$recordsTotalCount, totalPages=$totalPages, records=$records, ]';
  }

  VenueSummaryResponsePage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    nextPage = json['nextPage'];
    pageNumber = json['pageNumber'];
    previousPage = json['previousPage'];
    pageSize = json['pageSize'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    records = VenueSummaryResponse.listFromJson(json['records']);
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

  static List<VenueSummaryResponsePage> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueSummaryResponsePage>.empty()
        : json.map((value) => new VenueSummaryResponsePage.fromJson(value)).toList();
  }

  static Map<String, VenueSummaryResponsePage> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueSummaryResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new VenueSummaryResponsePage.fromJson(value));
    }
    return map;
  }
}
