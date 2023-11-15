import 'package:out_out/data/view_models/venue_loyalty/loyalty_response.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';

class LoyaltyResponsePage {
  late int pageSize;
  int? previousPage;
  late int pageNumber;
  int? nextPage;
  late int recordsTotalCount;
  late int totalPages;

  List<LoyaltyResponse> records = [];

  LoyaltyResponsePage();

  PagedList<LoyaltyResponse> toPagedList() {
    return new PagedList<LoyaltyResponse>()
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
    return 'LoyaltyResponsePage[nextPage=$nextPage, pageNumber=$pageNumber, previousPage=$previousPage, pageSize=$pageSize, recordsTotalCount=$recordsTotalCount, totalPages=$totalPages, records=$records, ]';
  }

  LoyaltyResponsePage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    nextPage = json['nextPage'];
    pageNumber = json['pageNumber'];
    previousPage = json['previousPage'];
    pageSize = json['pageSize'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    records = LoyaltyResponse.listFromJson(json['records']);
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

  static List<LoyaltyResponsePage> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<LoyaltyResponsePage>.empty()
        : json.map((value) => new LoyaltyResponsePage.fromJson(value)).toList();
  }

  static Map<String, LoyaltyResponsePage> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, LoyaltyResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new LoyaltyResponsePage.fromJson(value));
    }
    return map;
  }
}
