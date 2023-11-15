import 'package:out_out/data/view_models/venue/venue_summary_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_type_summary_response.dart';

class OfferWithVenueResponse {
  late String id;
  String? image;
  late OfferTypeSummaryResponse type;
  late VenueSummaryResponse venue;
  late bool isActive;

  OfferWithVenueResponse();

  @override
  String toString() {
    return 'OfferWithVenueResponse[id=$id, image=$image, type=$type, venue=$venue, isActive=$isActive]';
  }

  OfferWithVenueResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    image = json['image'];
    type = OfferTypeSummaryResponse.fromJson(json['type']);
    venue = new VenueSummaryResponse.fromJson(json['venue']);
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'image': image, 'type': type, 'venue': venue, 'isActive': isActive};
  }

  static List<OfferWithVenueResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<OfferWithVenueResponse>.empty()
        : json.map((value) => new OfferWithVenueResponse.fromJson(value)).toList();
  }

  static Map<String, OfferWithVenueResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, OfferWithVenueResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new OfferWithVenueResponse.fromJson(value));
    }
    return map;
  }
}
