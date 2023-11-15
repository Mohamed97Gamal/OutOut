import 'package:out_out/data/view_models/event_booking/single_event_booking_ticket_summary_response_page.dart';

class SingleEventBookingTicketSummaryResponsePageOperationResult {
  late bool status;

  late SingleEventBookingTicketSummaryResponsePage result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  SingleEventBookingTicketSummaryResponsePageOperationResult();

  @override
  String toString() {
    return 'SingleEventBookingTicketSummaryResponsePageOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  SingleEventBookingTicketSummaryResponsePageOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new SingleEventBookingTicketSummaryResponsePage.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<SingleEventBookingTicketSummaryResponsePageOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<SingleEventBookingTicketSummaryResponsePageOperationResult>.empty()
        : json.map((value) => new SingleEventBookingTicketSummaryResponsePageOperationResult.fromJson(value)).toList();
  }

  static Map<String, SingleEventBookingTicketSummaryResponsePageOperationResult> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, SingleEventBookingTicketSummaryResponsePageOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SingleEventBookingTicketSummaryResponsePageOperationResult.fromJson(value));
    }
    return map;
  }
}
