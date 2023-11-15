import 'package:out_out/data/models/enums/loyalty_stars.dart';
import 'package:out_out/data/view_models/available_time_response.dart';
import 'package:out_out/data/view_models/redemption.dart';
import 'package:out_out/data/view_models/venue/venue_mini_summary_response.dart';
import 'package:out_out/data/view_models/venue_loyalty/loyalty_type_summary_response.dart';

class LoyaltyResponse {
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

  late VenueMiniSummaryResponse venue;

  LoyaltyResponse();

  @override
  String toString() {
    return 'LoyaltyResponse[id=$id, type=$type, stars=$stars, isActive=$isActive, validOnDays=$validOnDays,maxUsage=$maxUsage, redemptions=$redemptions, isApplicable=$isApplicable, canGet=$canGet, starsCount=$starsCount, venue=$venue, ]';
  }

  LoyaltyResponse.fromJson(Map<String, dynamic>? json) {
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
    venue = new VenueMiniSummaryResponse.fromJson(json['venue']);
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
      'starsCount': starsCount,
      'venue': venue
    };
  }

  static List<LoyaltyResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<LoyaltyResponse>.empty()
        : json.map((value) => new LoyaltyResponse.fromJson(value)).toList();
  }

  static Map<String, LoyaltyResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, LoyaltyResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new LoyaltyResponse.fromJson(value));
    }
    return map;
  }
}
