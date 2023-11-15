class OTPVerificationTimeLeftResponse {
  late int minutes;

  late int seconds;

  OTPVerificationTimeLeftResponse();

  @override
  String toString() {
    return 'OTPVerificationTimeLeftResponse[minutes=$minutes, seconds=$seconds, ]';
  }

  OTPVerificationTimeLeftResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    return {'minutes': minutes, 'seconds': seconds};
  }

  static List<OTPVerificationTimeLeftResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<OTPVerificationTimeLeftResponse>.empty()
        : json.map((value) => new OTPVerificationTimeLeftResponse.fromJson(value)).toList();
  }

  static Map<String, OTPVerificationTimeLeftResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, OTPVerificationTimeLeftResponse>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new OTPVerificationTimeLeftResponse.fromJson(value));
    }
    return map;
  }
}
