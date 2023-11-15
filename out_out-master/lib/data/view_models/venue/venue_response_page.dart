import 'package:out_out/data/view_models/venue/venue_response.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';

class VenueResponsePage {
  late int pageSize;
  int? previousPage;
  late int pageNumber;
  int? nextPage;
  late int recordsTotalCount;
  late int totalPages;

  List<VenueResponse> records = [];

  VenueResponsePage();

  PagedList<VenueResponse> toPagedList() {
    return new PagedList<VenueResponse>()
      ..pageSize = pageSize
      ..previousPage = previousPage
      ..pageNumber = pageNumber
      ..nextPage = nextPage
      ..recordsTotalCount = recordsTotalCount
      ..totalPages = totalPages
      ..records = records;
  }

  VenueResponsePage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    pageSize = json['pageSize'];
    previousPage = json['previousPage'];
    pageNumber = json['pageNumber'];
    nextPage = json['nextPage'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    records = VenueResponse.listFromJson(json['records']);
  }

  Map<String, dynamic> toJson() {
    return {
      'pageSize': pageSize,
      'previousPage': previousPage,
      'pageNumber': pageNumber,
      'nextPage': nextPage,
      'recordsTotalCount': recordsTotalCount,
      'totalPages': totalPages,
      'records': records,
    };
  }

  static List<VenueResponsePage> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueResponsePage>.empty()
        : json.map((value) => new VenueResponsePage.fromJson(value)).toList();
  }

  static Map<String, VenueResponsePage> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new VenueResponsePage.fromJson(value));
    }
    return map;
  }
}
