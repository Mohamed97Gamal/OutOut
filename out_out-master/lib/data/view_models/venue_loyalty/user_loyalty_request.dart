class UserLoyaltyRequest {
  
  late String loyaltyId;

  late String loyaltyCode;

  UserLoyaltyRequest();

  @override
  String toString() {
    return 'UserLoyaltyRequest[loyaltyId=$loyaltyId, loyaltyCode=$loyaltyCode, ]';
  }

  UserLoyaltyRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    loyaltyId = json['loyaltyId'];
    loyaltyCode = json['loyaltyCode'];
  }

  Map<String, dynamic> toJson() {
    return {
      'loyaltyId': loyaltyId,
      'loyaltyCode': loyaltyCode
     };
  }

  static List<UserLoyaltyRequest> listFromJson(List<dynamic>? json) {
    return json == null ? new List<UserLoyaltyRequest>.empty() : json.map((value) => new UserLoyaltyRequest.fromJson(value)).toList();
  }

  static Map<String, UserLoyaltyRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, UserLoyaltyRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new UserLoyaltyRequest.fromJson(value));
    }
    return map;
  }
}
