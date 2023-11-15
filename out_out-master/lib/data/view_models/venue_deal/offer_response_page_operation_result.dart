import 'package:out_out/data/view_models/venue_deal/offer_response_page.dart';
import 'package:out_out/data/view_models/venue_deal/offer_with_venue_response_page.dart';

class OfferResponsePageOperationResult {
  late bool status;

  late OfferResponsePage result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  OfferResponsePageOperationResult();

  @override
  String toString() {
    return 'OfferResponsePageOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  OfferResponsePageOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new OfferResponsePage.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'result': result,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
      'errors': errors
    };
  }

  static List<OfferResponsePageOperationResult> listFromJson(
      List<dynamic>? json) {
    return json == null
        ? new List<OfferResponsePageOperationResult>.empty()
        : json
            .map(
                (value) => new OfferResponsePageOperationResult.fromJson(value))
            .toList();
  }

  static Map<String, OfferResponsePageOperationResult> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, OfferResponsePageOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new OfferResponsePageOperationResult.fromJson(value));
    }
    return map;
  }
}
