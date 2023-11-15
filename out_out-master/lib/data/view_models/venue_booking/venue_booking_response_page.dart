import 'package:out_out/data/view_models/venue_booking/venue_booking_response.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';

class VenueBookingResponsePage {
  late int pageSize;
  int? previousPage;
  late int pageNumber;
  int? nextPage;
  late int recordsTotalCount;
  late int totalPages;

  List<VenueBookingResponse> records = [];

  VenueBookingResponsePage();

  PagedList<VenueBookingResponse> toPagedList() {
    return new PagedList<VenueBookingResponse>()
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
    return 'VenueBookingResponsePage[nextPage=$nextPage, pageNumber=$pageNumber, previousPage=$previousPage, pageSize=$pageSize, recordsTotalCount=$recordsTotalCount, totalPages=$totalPages, records=$records, ]';
  }

  VenueBookingResponsePage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    nextPage = json['nextPage'];
    pageNumber = json['pageNumber'];
    previousPage = json['previousPage'];
    pageSize = json['pageSize'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    records = VenueBookingResponse.listFromJson(json['records']);
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

  static List<VenueBookingResponsePage> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueBookingResponsePage>.empty()
        : json.map((value) => new VenueBookingResponsePage.fromJson(value)).toList();
  }

  static Map<String, VenueBookingResponsePage> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueBookingResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new VenueBookingResponsePage.fromJson(value));
    }
    return map;
  }
}
