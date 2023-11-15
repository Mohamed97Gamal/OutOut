import 'package:out_out/data/view_models/venue_deal/offer_with_venue_response.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';

class OfferWithVenueResponsePage {
  late int pageSize;
  int? previousPage;
  late int pageNumber;
  int? nextPage;
  late int recordsTotalCount;
  late int totalPages;

  List<OfferWithVenueResponse> records = [];

  OfferWithVenueResponsePage();

  PagedList<OfferWithVenueResponse> toPagedList() {
    return new PagedList<OfferWithVenueResponse>()
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
    return 'OfferWithVenueResponsePage[nextPage=$nextPage, pageNumber=$pageNumber, previousPage=$previousPage, pageSize=$pageSize, recordsTotalCount=$recordsTotalCount, totalPages=$totalPages, records=$records, ]';
  }

  OfferWithVenueResponsePage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    nextPage = json['nextPage'];
    pageNumber = json['pageNumber'];
    previousPage = json['previousPage'];
    pageSize = json['pageSize'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    records = OfferWithVenueResponse.listFromJson(json['records']);
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

  static List<OfferWithVenueResponsePage> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<OfferWithVenueResponsePage>.empty()
        : json.map((value) => new OfferWithVenueResponsePage.fromJson(value)).toList();
  }

  static Map<String, OfferWithVenueResponsePage> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, OfferWithVenueResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new OfferWithVenueResponsePage.fromJson(value));
    }
    return map;
  }
}
