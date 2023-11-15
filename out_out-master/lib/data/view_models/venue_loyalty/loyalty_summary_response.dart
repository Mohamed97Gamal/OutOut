import 'package:out_out/data/models/enums/loyalty_stars.dart';
import 'package:out_out/data/view_models/available_time_response.dart';
import 'package:out_out/data/view_models/redemption.dart';
import 'package:out_out/data/view_models/venue_loyalty/loyalty_type_summary_response.dart';

class LoyaltySummaryResponse {
  late String id;

  late LoyaltyTypeSummaryResponse type;

  late LoyaltyStars stars;

  late bool isActive;

  late AvailableTimeResponse validOnDays;

  late int maxUsage;

  late List<Redemption> redemptions = [];

  late bool isApplicable;

  late bool canGet;

  late int starsCount;

  LoyaltySummaryResponse();

  @override
  String toString() {
    return 'VenueLoyaltySummaryResponse[id=$id, type=$type, stars=$stars, isActive=$isActive, validOnDays=$validOnDays, maxUsage=$maxUsage, redemptions=$redemptions, isApplicable=$isApplicable, canGet=$canGet, starsCount=$starsCount, ]';
  }

  LoyaltySummaryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    type = new LoyaltyTypeSummaryResponse.fromJson(json['type']);
    stars = new LoyaltyStars.fromJson(json['stars']);
    isActive = json['isActive'];
    validOnDays = new AvailableTimeResponse.fromJson(json['validOnDays']);
    maxUsage = json['maxUsage'];
    redemptions = Redemption.listFromJson(json['redemptions']);
    isApplicable = json['isApplicable'];
    canGet = json['canGet'];
    starsCount = json['starsCount'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'stars': stars,
      'isActive': isActive,
      'validOnDays': validOnDays,
      'maxUsage': maxUsage,
      'redemptions': redemptions,
      'isApplicable': isApplicable,
      'canGet': canGet,
      'starsCount': starsCount
    };
  }

  static List<LoyaltySummaryResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<LoyaltySummaryResponse>.empty()
        : json.map((value) => new LoyaltySummaryResponse.fromJson(value)).toList();
  }

  static Map<String, LoyaltySummaryResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, LoyaltySummaryResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new LoyaltySummaryResponse.fromJson(value));
    }
    return map;
  }
}
