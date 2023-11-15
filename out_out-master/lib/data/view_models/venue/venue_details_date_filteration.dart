import '../../../utils/date_utils.dart';
import '../available_time_response.dart';
import 'venue_response.dart';

class VenueDetailsDateFilteration {
  Map<String, MapEntry> dateFilterationVenueDetails(
      VenueResponse venueResponse) {
    int nextIndex = 0;
    Map<String, MapEntry> venueData = Map();
    _addAllVenues(venueResponse, venueData);
    for (var i = 0; i < venueResponse.openTimes.length; i++) {
      if (venueResponse.openTimes.length > 1 &&
          venueResponse.openTimes[i].to.hours == 23 &&
          venueResponse.openTimes[i].to.minutes == 59 &&
          venueResponse.openTimes[i + 1].from.hours == 00 &&
          venueResponse.openTimes[i + 1].from.minutes == 00) {
        // * check if venue is seperated on 2 days
        nextIndex = i + 1;
        if (venueResponse.openTimes[nextIndex].from.hours == 00 &&
            venueResponse.openTimes[nextIndex].from.minutes == 00) {
          // * update venue date to be 1 day
          venueData.update(
              venueResponse.openTimes[i].days.explain(),
              (value) => MapEntry(venueResponse.openTimes[i].from,
                  venueResponse.openTimes[nextIndex].to));
        }
      } else {
        if (venueResponse.openTimes[i].from.hours == 00 &&
            venueResponse.openTimes[i].from.minutes == 00) {
          // * remove next seperated day

          if (venueResponse.openTimes.length > 1 &&
              venueResponse.openTimes[i - 1].to.hours == 23 &&
              venueResponse.openTimes[i - 1].to.minutes == 59) {
            // * check if not all days then remove duplicate days

            if (!venueResponse.openTimes[i].days.explain().contains('All Days'))
              venueData.removeWhere((key, value) =>
                  key == venueResponse.openTimes[i].days.explain() &&
                  value.key.hours == 00 &&
                  value.key.minutes == 00);
          }
        }
      }
    }

    return venueData;
  }

  void _addAllVenues(
      VenueResponse venueResponse, Map<String, MapEntry> venueData) {
    // * Add all venues data
    for (AvailableTimeResponse openTime in venueResponse.openTimes)
      venueData.addAll({
        openTime.days.explain(): MapEntry(
          openTime.from,
          openTime.to,
        )
      });
  }
}
