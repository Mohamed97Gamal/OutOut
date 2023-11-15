import 'package:flutter/material.dart';
import 'package:out_out/data/view_models/available_time_response.dart';
import 'package:out_out/data/view_models/venue/venue_card_date_filteration.dart';
import 'package:out_out/data/view_models/venue/venue_summary_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/universal_image.dart';

class VenueCardItem extends StatelessWidget {
  final VenueSummaryResponse venueSummaryResponse;
  final bool? isOpenNowTab;
  final bool? isSearchFilter;
  final DateTime? dateTime;
  const VenueCardItem({
    Key? key,
    required this.venueSummaryResponse,
    this.isOpenNowTab = false,
    this.isSearchFilter = false,
    this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Stack(
        children: [
          if (venueSummaryResponse.categories.isNotEmpty)
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.155,
                color: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                child: Text(
                  venueSummaryResponse.categories.first.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white, fontSize: 10.0),
                ),
              ),
            ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 1.0, horizontal: 16.0),
            child: InkWell(
              onTap: () => Navigation().navToVenueDetailsScreen(context,
                  venueId: venueSummaryResponse.id),
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      Expanded(
                          flex: 1,
                          child:
                            AspectRatio(
                            aspectRatio: 1.05,
                            child:
                                UniversalImage.venue(venueSummaryResponse.tableLogo),
                          )),
                      const SizedBox(width: 8.0),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  venueSummaryResponse.name,
                                  maxLines: 5,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0),
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              VenueOpenTimes(
                                  openTimes: venueSummaryResponse.openTimes,
                                  showFirstOnly: true,
                                  isOpenNowTab: isOpenNowTab,
                                  isSearchFilter: isSearchFilter,
                                  dateFilterRequestFrom: dateTime),
                              const SizedBox(height: 12.0),
                              Text(
                                "${venueSummaryResponse.location!.area} - ${venueSummaryResponse.location!.city.name} | ${venueSummaryResponse.location!.distance} km",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w300),
                              ),
                             const SizedBox(height: 6.0),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                    
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VenueOpenTimes extends StatelessWidget {
  final List<AvailableTimeResponse> openTimes;
  final bool showFirstOnly;
  final bool? isOpenNowTab;
  final bool? isSearchFilter;
  final DateTime? dateFilterRequestFrom;
  const VenueOpenTimes(
      {Key? key,
      required this.openTimes,
      this.showFirstOnly = false,
      this.isOpenNowTab = false,
      this.isSearchFilter = false,
      this.dateFilterRequestFrom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (openTimes.isEmpty) {
      return Text("No Open Time");
    }
    var todaysDates = openTimes
        .where((element) => element.days.contains(DateTime.now().weekday));
    var joinedDates = <AvailableTimeResponse>[];
    var singleDates = openTimes.where((element) =>
        element.days.length == 1 &&
        element.from.hours == 0 &&
        element.from.minutes == 0);
    var toEndOfDayDates = openTimes
        .where((element) => element.to.hours == 23 && element.to.minutes == 59);

    var nonProcessedDates = openTimes.toList();
    for (final openTime in toEndOfDayDates) {
      var matchSingle = false;
      for (final singleDate in singleDates) {
        var singleDay = singleDate.days.first;
        var matchingDates = openTime.days
            .where((element) => (singleDay.value - element.value + 7) % 7 == 1)
            .toList();
        var matchingDate =
            matchingDates.isNotEmpty ? matchingDates.first : null;
        if (matchingDate != null) {
          var value = AvailableTimeResponse.fromJson(openTime.toJson());
          //value.days.add(singleDay);
          value.to = singleDate.to;
          nonProcessedDates.remove(openTime);
          nonProcessedDates.remove(singleDate);
          joinedDates.add(value);
          matchSingle = true;
          // print("#####################################");
          break;
        }
      }
      if (!matchSingle) {
        nonProcessedDates.remove(openTime);
        joinedDates.add(openTime);
      }
    }
    joinedDates.addAll(nonProcessedDates);
    final VenueCardDateFilteration venueCardDateFilteration =
        VenueCardDateFilteration(
            joinedDates: joinedDates,
            isOpenNowTab: isOpenNowTab!,
            isSearchFilter: isSearchFilter!,
            dateFilterRequestFrom: dateFilterRequestFrom ?? DateTime.now());
    return venueCardDateFilteration.venueCardDateDetails(
      context,
    );
  }
}
