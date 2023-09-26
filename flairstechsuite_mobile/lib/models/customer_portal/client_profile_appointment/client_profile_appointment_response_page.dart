import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_appointment_response.dart';
import 'package:flairstechsuite_mobile/widgets/loading/custom_paged_sliver_list_view.dart';

class ClientProfileAppointmentResponsePage {
  int? nextPage = null;

  int? pageIndex = null;

  int? previousPage = null;

  int? pageSize = null;

  int? recordsTotalCount = null;

  int? totalPages = null;

  List<ClientProfileAppointmentResponse> records = [];

  ClientProfileAppointmentResponsePage();

  PagedList<ClientProfileAppointmentResponse> toPagedList() {
    return PagedList<ClientProfileAppointmentResponse>()
      ..pageSize = pageSize
      ..pageNumber = pageIndex! + 1
      ..hasNext = nextPage != null
      ..hasPrevious = previousPage != null
      ..recordsTotalCount = recordsTotalCount
      ..totalPages = totalPages
      ..records = records;
  }

  @override
  String toString() {
    return 'ClientProfileAppointmentResponsePage[nextPage=$nextPage, pageIndex=$pageIndex, previousPage=$previousPage, pageSize=$pageSize, recordsTotalCount=$recordsTotalCount, totalPages=$totalPages, records=$records, ]';
  }

  ClientProfileAppointmentResponsePage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    nextPage = json['nextPage'];
    pageIndex = json['pageIndex'];
    previousPage = json['previousPage'];
    pageSize = json['pageSize'];
    recordsTotalCount = json['recordsTotalCount'];
    totalPages = json['totalPages'];
    records = ClientProfileAppointmentResponse.listFromJson(json['records']);
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

  static List<ClientProfileAppointmentResponsePage> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<ClientProfileAppointmentResponsePage>.empty()
        : json.map((value) => ClientProfileAppointmentResponsePage.fromJson(value)).toList();
  }

  static Map<String, ClientProfileAppointmentResponsePage> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = Map<String, ClientProfileAppointmentResponsePage>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = ClientProfileAppointmentResponsePage.fromJson(value));
    }
    return map;
  }
}
