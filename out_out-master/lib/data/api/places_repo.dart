import 'package:google_maps_webservice/places.dart';
import 'package:out_out/config.dart';

class PlacesRepo {
  static final PlacesRepo _singleton = PlacesRepo._internal();

  factory PlacesRepo() => _singleton;

  PlacesRepo._internal();

  Future<List<PlacesSearchResult>> searchByText(String text) async {
    final places = new GoogleMapsPlaces(apiKey: geoApiKey);
    PlacesSearchResponse response = await places.searchByText(text);
    print(response.toJson());
    return response.results;
  }
}
