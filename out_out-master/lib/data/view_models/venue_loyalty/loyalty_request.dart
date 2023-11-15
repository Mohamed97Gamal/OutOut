import 'package:out_out/data/models/enums/loyalty_stars.dart';
import 'package:out_out/data/view_models/available_time_response.dart';
import 'package:out_out/data/view_models/venue_loyalty/loyalty_type_summary_response.dart';

class LoyaltyRequest {
  late LoyaltyTypeSummaryResponse type;

  late LoyaltyStars stars;

  late bool isActive;

  late AvailableTimeResponse validOnDays;

  late int maxUsagesPerDay;

  LoyaltyRequest();

  @override
  String toString() {
    return 'LoyaltyRequest[type=$type, stars=$stars, isActive=$isActive, validOnDays=$validOnDays, maxUsagesPerDay=$maxUsagesPerDay, ]';
  }

  LoyaltyRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    type = new LoyaltyTypeSummaryResponse.fromJson(json['type']);
    stars = new LoyaltyStars.fromJson(json['stars']);
    isActive = json['isActive'];
    validOnDays = new AvailableTimeResponse.fromJson(json['validOnDays']);
    maxUsagesPerDay = json['maxUsagesPerDay'];
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'stars': stars,
      'isActive': isActive,
      'validOnDays': validOnDays,
      'maxUsagesPerDay': maxUsagesPerDay
    };
  }

  static List<LoyaltyRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<LoyaltyRequest>.empty()
        : json.map((value) => new LoyaltyRequest.fromJson(value)).toList();
  }

  static Map<String, LoyaltyRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, LoyaltyRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new LoyaltyRequest.fromJson(value));
    }
    return map;
  }
}
