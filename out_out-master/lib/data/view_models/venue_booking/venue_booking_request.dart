class VenueBookingRequest {
  late String venueId;

  late int peopleNumber;

  late DateTime date;

  VenueBookingRequest();

  @override
  String toString() {
    return 'VenueBookingRequest[venueId=$venueId, peopleNumber=$peopleNumber, date=$date, ]';
  }

  VenueBookingRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    venueId = json['venueId'];
    peopleNumber = json['peopleNumber'];
    date = DateTime.parse(json['date']);
  }

  Map<String, dynamic> toJson() {
    return {'venueId': venueId, 'peopleNumber': peopleNumber, 'date': date.toUtc().toIso8601String()};
  }

  static List<VenueBookingRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueBookingRequest>.empty()
        : json.map((value) => new VenueBookingRequest.fromJson(value)).toList();
  }

  static Map<String, VenueBookingRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueBookingRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new VenueBookingRequest.fromJson(value));
    }
    return map;
  }
}
