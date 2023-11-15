import 'package:out_out/data/view_models/event/event_summary_response.dart';
import 'package:out_out/data/view_models/venue/venue_summary_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_with_venue_response.dart';

class HomePageResponse {
   List<VenueSummaryResponse>? venues;

   List<EventSummaryResponse>? events;

   List<OfferWithVenueResponse>? offers;

  HomePageResponse();

  @override
  String toString() {
    return 'HomePageResponse[venues=$venues, events=$events, offers=$offers, ]';
  }

  HomePageResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    venues = VenueSummaryResponse.listFromJson(json['venues']);
    events = EventSummaryResponse.listFromJson(json['events']);
    offers = OfferWithVenueResponse.listFromJson(json['offers']);
  }

  Map<String, dynamic> toJson() {
    return {'venues': venues, 'events': events, 'offers': offers};
  }

  static List<HomePageResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<HomePageResponse>.empty()
        : json.map((value) => new HomePageResponse.fromJson(value)).toList();
  }

  static Map<String, HomePageResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, HomePageResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new HomePageResponse.fromJson(value));
    }
    return map;
  }
}
