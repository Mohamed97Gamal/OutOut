import 'package:out_out/data/view_models/available_time_response.dart';
import 'package:out_out/data/view_models/category/category_response.dart';
import 'package:out_out/data/view_models/event/event_summary_response.dart';
import 'package:out_out/data/view_models/event/location_response.dart';
import 'package:out_out/data/view_models/venue_booking/venue_booking_summary_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_response.dart';
import 'package:out_out/data/view_models/venue_loyalty/loyalty_summary_response.dart';

class VenueResponse {
  late String id;

  late String name;

  String? description;

  String? logo;
  String? detailsLogo;

  String? background;

  late LocationResponse location;

  late List<CategoryResponse> categories = [];

  late List<AvailableTimeResponse> openTimes = [];

  String? phoneNumber;

  String? menu;

  late List<String> gallery = [];

  String? facebookLink;

  String? instagramLink;

  String? youtubeLink;

  String? webpageLink;

  late bool isFavorite;

  List<OfferResponse> offers = [];
   List<OfferResponse> upcomingOffers = [];

  LoyaltySummaryResponse? loyalty;

  VenueBookingSummaryResponse? booking;

  List<EventSummaryResponse>? upcomingEvent;

  VenueResponse();

  @override
  String toString() {
    return 'VenueResponse[id=$id, name=$name, description=$description, logo=$logo, background=$background, location=$location, categories=$categories, openTimes=$openTimes, phoneNumber=$phoneNumber, menu=$menu, facebookLink=$facebookLink, instagramLink=$instagramLink, youtubeLink=$youtubeLink, webpageLink=$webpageLink, gallery=$gallery, isFavorite=$isFavorite, offers=$offers,upcomingOffers=$upcomingOffers, loyalty=$loyalty, booking=$booking, upcomingEvent=$upcomingEvent, detailsLogo=$detailsLogo ]';
  }

  bool isMatchingDate(DateTime date) {
    return openTimes.any((openTime) => openTime.isMatchingDate(date));
  }

  bool isMatchingTime(DateTime datetime) {
    return openTimes.any((openTime) => openTime.isMatchingDate(datetime) && openTime.isMatchingTime(datetime));
  }

  VenueResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    description = json['description'];
    logo = json['logo'];
    detailsLogo = json['detailsLogo'];
    background = json['background'];
    location = new LocationResponse.fromJson(json['location']);
    categories = CategoryResponse.listFromJson(json['categories']);
    openTimes = AvailableTimeResponse.listFromJson(json['openTimes']);
    phoneNumber = json['phoneNumber'];
    menu = json['menu'];
    facebookLink = json['facebookLink'];
    instagramLink = json['instagramLink'];
    youtubeLink = json['youtubeLink'];
    webpageLink = json['webpageLink'];
    gallery = json['gallery'] != null
        ? (json['gallery'] as List).map((item) => item as String).toList()
        : [];
    isFavorite = json['isFavorite'];
    offers = OfferResponse.listFromJson(json['offers']);
    upcomingOffers = OfferResponse.listFromJson(json['upcomingOffers']);
    loyalty = json['loyalty'] != null ? new LoyaltySummaryResponse.fromJson(json['loyalty']) : null;
    booking = json['booking'] != null ? new VenueBookingSummaryResponse.fromJson(json['booking']) : null;
    upcomingEvent = EventSummaryResponse.listFromJson(json['upcomingEvents']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logo': logo,
      'detailsLogo': detailsLogo,
      'background': background,
      'location': location,
      'categories': categories,
      'openTimes': openTimes,
      'phoneNumber': phoneNumber,
      'menu': menu,
      'facebookLink': facebookLink,
      'instagramLink': instagramLink,
      'youtubeLink': youtubeLink,
      'webpageLink': webpageLink,
      'gallery': gallery,
      'isFavorite': isFavorite,
      'offers': offers,
      'upcomingOffers': upcomingOffers,
      'loyalty': loyalty,
      'booking': booking,
      'upcomingEvent': upcomingEvent
    };
  }

  static List<VenueResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<VenueResponse>.empty()
        : json.map((value) => new VenueResponse.fromJson(value)).toList();
  }

  static Map<String, VenueResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, VenueResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new VenueResponse.fromJson(value));
    }
    return map;
  }
}
