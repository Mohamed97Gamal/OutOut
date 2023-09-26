import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/my_partner_response.dart';
import 'package:flairstechsuite_mobile/widgets/loading/custom_paged_sliver_list_view.dart';

class MyPartnerResponsePage {
  
  int? nextPage = null;

  int? pageIndex = null;

  int? previousPage = null;

  int? pageSize = null;

  int? recordsTotalCount = null;

  int? totalPages = null;

  List<MyPartnerResponse> records = [];

  MyPartnerResponsePage();

  PagedList<MyPartnerResponse> toPagedList() {
    return PagedList<MyPartnerResponse>()
      ..pageSize = pageSize
      ..pageNumber = pageIndex!+1
      ..hasNext = nextPage != null
      ..hasPrevious = previousPage != null
      ..recordsTotalCount = recordsTotalCount
      ..totalPages = totalPages
      ..records = records;
  }

  @override
  String toString() {
    return 'MyPartnerResponsePage[nextPage=$nextPage, pageIndex=$pageIndex, previousPage=$previousPage, pageSize=$pageSize, recordsTotalCount=$recordsTotalCount, totalPages=$totalPages, records=$records, ]';
  }

  MyPartnerResponsePage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    nextPage = json['nextPage'];
    pageIndex = json['pageIndex'];
    previousPage = json['previousPage'];
    pageSize = json['pageSize'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    records = MyPartnerResponse.listFromJson(json['records']);
  }

  Map<String, dynamic> toJson() {
    return {
      'nextPage': nextPage,
      'pageIndex': pageIndex,
      'previousPage': previousPage,
      'pageSize': pageSize,
      'recordsTotalCount': recordsTotalCount,
      'totalPages': totalPages,
      'records': records
     };
  }

  static List<MyPartnerResponsePage> listFromJson(List<dynamic>? json) {
    return json == null ? new List<MyPartnerResponsePage>.empty() : json.map((value) => new MyPartnerResponsePage.fromJson(value)).toList();
  }

  static Map<String, MyPartnerResponsePage> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, MyPartnerResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new MyPartnerResponsePage.fromJson(value));
    }
    return map;
  }
}
