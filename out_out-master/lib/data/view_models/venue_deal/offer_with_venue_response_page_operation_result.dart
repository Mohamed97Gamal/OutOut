import 'package:out_out/data/view_models/venue_deal/offer_with_venue_response_page.dart';

class OfferWithVenueResponsePageOperationResult {
  late bool status;

  late OfferWithVenueResponsePage result;

  late int errorCode;

  String? errorMessage;

  late List<String> errors = [];

  OfferWithVenueResponsePageOperationResult();

  @override
  String toString() {
    return 'OfferWithVenueResponsePageOperationResult[status=$status, result=$result, errorCode=$errorCode, errorMessage=$errorMessage, errors=$errors, ]';
  }

  OfferWithVenueResponsePageOperationResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    status = json['status'];
    result = new OfferWithVenueResponsePage.fromJson(json['result']);
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'result': result, 'errorCode': errorCode, 'errorMessage': errorMessage, 'errors': errors};
  }

  static List<OfferWithVenueResponsePageOperationResult> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<OfferWithVenueResponsePageOperationResult>.empty()
        : json.map((value) => new OfferWithVenueResponsePageOperationResult.fromJson(value)).toList();
  }

  static Map<String, OfferWithVenueResponsePageOperationResult> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, OfferWithVenueResponsePageOperationResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new OfferWithVenueResponsePageOperationResult.fromJson(value));
    }
    return map;
  }
}
