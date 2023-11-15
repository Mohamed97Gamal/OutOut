import 'package:out_out/data/view_models/venue_deal/offer_type_summary_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_with_venue_response_page.dart';

class OfferTypeSumamryResponseListOperationResult {
  late bool status;

  late List<OfferTypeSummaryResponse> result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  OfferTypeSumamryResponseListOperationResult();

  @override
  String toString() {
    return 'OfferTypeSumamryResponseListOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  OfferTypeSumamryResponseListOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = OfferTypeSummaryResponse.listFromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<OfferTypeSumamryResponseListOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<OfferTypeSumamryResponseListOperationResult>.empty()
        : json.map((value) => new OfferTypeSumamryResponseListOperationResult.fromJson(value)).toList();
  }

  static Map<String, OfferTypeSumamryResponseListOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, OfferTypeSumamryResponseListOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new OfferTypeSumamryResponseListOperationResult.fromJson(value));
    }
    return map;
  }
}
