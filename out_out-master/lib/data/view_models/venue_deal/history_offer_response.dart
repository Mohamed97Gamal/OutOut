import 'package:out_out/data/models/enums/offer_usage_per_year.dart';
import 'package:out_out/data/view_models/available_time_response.dart';
import 'package:out_out/data/view_models/venue/venue_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_type_summary_response.dart';

class HistoryOfferResponse {
  late String id;

  String? image;

  late OfferTypeSummaryResponse type;

  late bool isActive;

  late DateTime expiryDate;

  late List<AvailableTimeResponse> validOn;

  late OfferUsagePerYear maxUsagePerYear;

  late int count;
  late VenueResponse venue;
  HistoryOfferResponse();

  @override
  String toString() {
    return 'OfferResponse[id=$id, image=$image, type=$type, isActive=$isActive, expiryDate=$expiryDate, validOn=$validOn, maxUsagePerYear=$maxUsagePerYear, count=$count, venue,$venue]';
  }

  HistoryOfferResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    image = json['image'];
    type = OfferTypeSummaryResponse.fromJson(json['type']);
    isActive = json['isActive'];
    expiryDate = DateTime.parse(json['expiryDate']);
    validOn = AvailableTimeResponse.listFromJson(json['validOn']);
    maxUsagePerYear = OfferUsagePerYear.fromJson(json['maxUsagePerYear']);
    count = json['count'];
    venue = VenueResponse.fromJson(json['venue']);
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
      'count': count,
      'venue': venue
    };
  }

  static List<HistoryOfferResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<HistoryOfferResponse>.empty()
        : json
            .map((value) => new HistoryOfferResponse.fromJson(value))
            .toList();
  }

  static Map<String, HistoryOfferResponse> mapFromJson(
      Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, HistoryOfferResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new HistoryOfferResponse.fromJson(value));
    }
    return map;
  }
}
