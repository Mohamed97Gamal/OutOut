import 'package:out_out/data/models/enums/offer_usage_per_year.dart';
import 'package:out_out/data/view_models/available_time_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_type_summary_response.dart';

class OfferResponse {
  late String id;

  String? image;

  late OfferTypeSummaryResponse type;

  late bool isActive;
  late DateTime? nextAvailableDate;
  late DateTime expiryDate;

  late List<AvailableTimeResponse> validOn;

  late OfferUsagePerYear maxUsagePerYear;

  late bool isApplicable;

  OfferResponse();

  @override
  String toString() {
    return 'OfferResponse[id=$id, image=$image, type=$type, isActive=$isActive, expiryDate=$expiryDate, validOn=$validOn, maxUsagePerYear=$maxUsagePerYear, isApplicable=$isApplicable, nextAvailableDate=$nextAvailableDate]';
  }

  OfferResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    image = json['image'];
    type = OfferTypeSummaryResponse.fromJson(json['type']);
    isActive = json['isActive'];
    expiryDate = DateTime.parse(json['expiryDate']);
    validOn = AvailableTimeResponse.listFromJson(json['validOn']);
    maxUsagePerYear = OfferUsagePerYear.fromJson(json['maxUsagePerYear']);
    isApplicable = json['isApplicable'];
    nextAvailableDate = DateTime.parse(json['nextAvailableDate']); 
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'type': type,
      'isActive': isActive,
      'expiryDate': expiryDate.toUtc().toIso8601String(),
      'validOn': validOn,
      'maxUsagePerYear': maxUsagePerYear,
      'isApplicable': isApplicable,
      'nextAvailableDate': nextAvailableDate
    };
  }

  static List<OfferResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<OfferResponse>.empty()
        : json.map((value) => new OfferResponse.fromJson(value)).toList();
  }

  static Map<String, OfferResponse> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, OfferResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new OfferResponse.fromJson(value));
    }
    return map;
  }
}
