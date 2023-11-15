import 'package:out_out/data/models/enums/loyalty_time_filter.dart';

class LoyaltyFilterationRequest {
  late String searchQuery;

  late LoyaltyTimeFilter timeFilter;

  LoyaltyFilterationRequest();

  @override
  String toString() {
    return 'LoyaltyFilterationRequest[searchQuery=$searchQuery, timeFilter=$timeFilter, ]';
  }

  LoyaltyFilterationRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    searchQuery = json['searchQuery'];
    timeFilter = new LoyaltyTimeFilter.fromJson(json['timeFilter']);
  }

  Map<String, dynamic> toJson() {
    return {'searchQuery': searchQuery, 'timeFilter': timeFilter.value};
  }

  static List<LoyaltyFilterationRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<LoyaltyFilterationRequest>.empty()
        : json.map((value) => new LoyaltyFilterationRequest.fromJson(value)).toList();
  }

  static Map<String, LoyaltyFilterationRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, LoyaltyFilterationRequest>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new LoyaltyFilterationRequest.fromJson(value));
    }
    return map;
  }
}
