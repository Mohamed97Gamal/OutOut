import 'package:out_out/data/view_models/category/category_response.dart';
import 'package:out_out/data/view_models/event/event_occurrence_response.dart';
import 'package:out_out/data/view_models/event/location_response.dart';
import 'package:out_out/data/view_models/event_booking/event_booking_mini_summary_response.dart';
import 'package:out_out/data/view_models/venue/venue_mini_summary_response.dart';

class SingleEventOccurrenceResponse {
  late String id;

  late String name;

  String? description;

  String? image;
  String? tableLogo;
  String? detailsLogo;

  late LocationResponse location;

  String? phoneNumber;

  String? email;

  List<CategoryResponse> categories = [];

  String? facebookLink;

  String? instagramLink;

  String? youtubeLink;

  String? webpageLink;

  late bool isFeatured;

  EventOccurrenceResponse? occurrence;

  late List<EventOccurrenceResponse> occurrences = [];

  late bool isFavorite;

  late VenueMiniSummaryResponse venue;

  EventBookingMiniSummaryResponse? booking;

  SingleEventOccurrenceResponse();

  @override
  String toString() {
    return 'SingleEventOccurrenceResponse[id=$id, name=$name, description=$description, image=$image, location=$location, phoneNumber=$phoneNumber, email=$email, categories=$categories, facebookLink=$facebookLink, instagramLink=$instagramLink, youtubeLink=$youtubeLink, webpageLink=$webpageLink isFeatured=$isFeatured, occurrence=$occurrence, occurrences=$occurrences, isFavorite=$isFavorite, venue=$venue, booking=$booking, ]';
  }

  SingleEventOccurrenceResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    detailsLogo = json['detailsLogo'];
    tableLogo = json['tableLogo'];
    location = new LocationResponse.fromJson(json['location']);
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    categories = CategoryResponse.listFromJson(json['categories']);
    facebookLink = json['facebookLink'];
    instagramLink = json['instagramLink'];
    youtubeLink = json['youtubeLink'];
    webpageLink = json['webpageLink'];
    isFeatured = json['isFeatured'];
    occurrence = new EventOccurrenceResponse.fromJson(json['occurrence']);
    occurrences = EventOccurrenceResponse.listFromJson(json['occurrences']);
    isFavorite = json['isFavorite'];
    venue = new VenueMiniSummaryResponse.fromJson(json['venue']);
    booking = json['booking'] != null ? new EventBookingMiniSummaryResponse.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'tableLogo': tableLogo,
      'detailsLogo': detailsLogo,
      'location': location,
      'phoneNumber': phoneNumber,
      'email': email,
      'categories': categories,
      'facebookLink': facebookLink,
      'instagramLink': instagramLink,
      'youtubeLink': youtubeLink,
      'webpageLink': webpageLink,
      'isFeatured': isFeatured,
      'occurrence': occurrence,
      'occurrences': occurrences,
      'isFavorite': isFavorite,
      'venue': venue,
      'booking': booking,
    };
  }

  static List<SingleEventOccurrenceResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<SingleEventOccurrenceResponse>.empty()
        : json.map((value) => new SingleEventOccurrenceResponse.fromJson(value)).toList();
  }

  static Map<String, SingleEventOccurrenceResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, SingleEventOccurrenceResponse>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new SingleEventOccurrenceResponse.fromJson(value));
    }
    return map;
  }
}
