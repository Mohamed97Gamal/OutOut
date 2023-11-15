import 'package:out_out/data/view_models/faq/faq_response.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';

class FAQResponsePage {
  late int pageSize;
  int? previousPage;
  late int pageNumber;
  int? nextPage;
  late int recordsTotalCount;
  late int totalPages;

  List<FAQResponse> records = [];

  FAQResponsePage();

  PagedList<FAQResponse> toPagedList() {
    return new PagedList<FAQResponse>()
      ..pageSize = pageSize
      ..previousPage = previousPage
      ..pageNumber = pageNumber
      ..nextPage = nextPage
      ..recordsTotalCount = recordsTotalCount
      ..totalPages = totalPages
      ..records = records;
  }

  FAQResponsePage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    pageSize = json['pageSize'];
    previousPage = json['previousPage'];
    pageNumber = json['pageNumber'];
    nextPage = json['nextPage'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    records = FAQResponse.listFromJson(json['records']);
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

  static List<FAQResponsePage> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<FAQResponsePage>.empty()
        : json.map((value) => new FAQResponsePage.fromJson(value)).toList();
  }

  static Map<String, FAQResponsePage> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, FAQResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new FAQResponsePage.fromJson(value));
    }
    return map;
  }
}
