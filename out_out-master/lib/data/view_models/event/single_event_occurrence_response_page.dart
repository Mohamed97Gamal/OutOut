import 'package:out_out/data/view_models/event/single_event_occurrence_response.dart';

class SingleEventOccurrenceResponsePage {
  int? nextPage;

  late int pageNumber;

  int? previousPage;

  late int pageSize;

  late int recordsTotalCount;

  late int totalPages;

  late List<SingleEventOccurrenceResponse> records = [];

  SingleEventOccurrenceResponsePage();

  @override
  String toString() {
    return 'SingleEventOccurrenceResponsePage[nextPage=$nextPage, pageNumber=$pageNumber, previousPage=$previousPage, pageSize=$pageSize, recordsTotalCount=$recordsTotalCount, totalPages=$totalPages, records=$records, ]';
  }

  SingleEventOccurrenceResponsePage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    nextPage = json['nextPage'];
    pageNumber = json['pageNumber'];
    previousPage = json['previousPage'];
    pageSize = json['pageSize'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    records = SingleEventOccurrenceResponse.listFromJson(json['records']);
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

  static List<SingleEventOccurrenceResponsePage> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<SingleEventOccurrenceResponsePage>.empty()
        : json.map((value) => new SingleEventOccurrenceResponsePage.fromJson(value)).toList();
  }

  static Map<String, SingleEventOccurrenceResponsePage> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, SingleEventOccurrenceResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new SingleEventOccurrenceResponsePage.fromJson(value));
    }
    return map;
  }
}
