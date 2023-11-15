import 'package:out_out/data/view_models/venue_deal/history_offer_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_with_venue_response.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';

class OfferResponsePage {
  late int pageSize;
  int? previousPage;
  late int pageNumber;
  int? nextPage;
  late int recordsTotalCount;
  late int totalPages;

  List<HistoryOfferResponse> records = [];

  OfferResponsePage();

  PagedList<HistoryOfferResponse> toPagedList() {
    return new PagedList<HistoryOfferResponse>()
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
    return 'OfferResponsePage[nextPage=$nextPage, pageNumber=$pageNumber, previousPage=$previousPage, pageSize=$pageSize, recordsTotalCount=$recordsTotalCount, totalPages=$totalPages, records=$records, ]';
  }

  OfferResponsePage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    nextPage = json['nextPage'];
    pageNumber = json['pageNumber'];
    previousPage = json['previousPage'];
    pageSize = json['pageSize'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    records = HistoryOfferResponse.listFromJson(json['records']);
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

  static List<OfferResponsePage> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<OfferResponsePage>.empty()
        : json.map((value) => new OfferResponsePage.fromJson(value)).toList();
  }

  static Map<String, OfferResponsePage> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, OfferResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new OfferResponsePage.fromJson(value));
    }
    return map;
  }
}
