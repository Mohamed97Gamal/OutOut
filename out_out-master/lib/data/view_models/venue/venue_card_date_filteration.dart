
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/date_utils.dart';
import '../../models/enums/day_of_week.dart';
import '../available_time_response.dart';

class VenueCardDateFilteration {
  List<AvailableTimeResponse>? joinedDates;
  bool? isOpenNowTab;
  bool? isSearchFilter;
  DateTime? dateFilterRequestFrom;
  VenueCardDateFilteration({
    required List<AvailableTimeResponse> joinedDates,
    required bool isOpenNowTab,
    required bool isSearchFilter,
    required DateTime dateFilterRequestFrom,
  }) {
    this.joinedDates = joinedDates;
    this.dateFilterRequestFrom = dateFilterRequestFrom;
    this.isOpenNowTab = isOpenNowTab;
    this.isSearchFilter = isSearchFilter;
  }

  Widget venueCardDateDetails(
    BuildContext context,
  ) {
    final venueData = dateFilterationVenueCard();
    for (var i = 0; i < venueData.keys.length; i++) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * .54,
        child: Text(
          "${venueData.keys.map((e) => e).toList()[i].explain()} | ${venueData.values.map((e) => e.key).toList()[i]} - ${venueData.values.map((e) => e.value).toList()[i]}",
                                            overflow: TextOverflow.ellipsis,
          softWrap: true,
          maxLines: 4,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 13),
        ),
      );
    }
    return Container();
  }

  Map<List<DayOfWeek>, MapEntry> dateFilterationVenueCard() {
    int nextIndex = 0;
    Map<List<DayOfWeek>, MapEntry> venueData = {};
    _addAllVenues(venueData);
    for (var i = 0; i < joinedDates!.length; i++) {
      if (joinedDates!.length > 1 &&
          joinedDates![i].to.hours == 23 &&
          joinedDates![i].to.minutes == 59 &&
          joinedDates![i + 1].from.hours == 00 &&
          joinedDates![i + 1].from.minutes == 00) {
        // * check if venue is seperated on 2 days
        nextIndex = i + 1;
        if (joinedDates![nextIndex].from.hours == 00 &&
            joinedDates![nextIndex].from.minutes == 00) {
          // * update venue date to be 1 day
          if ((isOpenNowTab! && isSearchFilter!) ||
              joinedDates![i].days.length == 7)
            venueData.update(
              joinedDates![i].days,
                  (value) =>
                  MapEntry(joinedDates![i].from, joinedDates![nextIndex].to),
              ifAbsent: () =>
                  MapEntry(joinedDates![i].from, joinedDates![nextIndex].to),
            );
        }
      } else {
        if (joinedDates![i].from.hours == 00 &&
            joinedDates![i].from.minutes == 00) {
          if (joinedDates!.length > 1 &&
              joinedDates![i - 1].to.hours == 23 &&
              joinedDates![i - 1].to.minutes == 59) {
            // * remove next seperated day
            if (!joinedDates![i].days.explain().contains('All Days'))
              venueData.removeWhere((key, value) =>
              key == joinedDates![i].days.explain() &&
                  value.key.hours == 00 &&
                  value.key.minutes == 00);
          }
        }
      }
    }


    int currentWeekday = DateTime
        .now()
        .weekday;
    if (venueData.length > 1 && venueData.isNotEmpty) {
      List<DayOfWeek> targetKey = venueData.keys.firstWhere(
            (key) => key.contains(DayOfWeek.availableOptions[currentWeekday]),
      );

      if (targetKey.isNotEmpty) {
        Map<List<DayOfWeek>, MapEntry<dynamic, dynamic>> outputMap = {
          targetKey: venueData[targetKey]!,
        }
          ..addAll(venueData);

        print(outputMap);
        return outputMap;
      } else {
        return venueData;
      }
    }
    else {return venueData;}
  }

  void _addAllVenues(Map<List<DayOfWeek>, MapEntry> venueData) {
    if (isOpenNowTab!)
      _addVenuesFromDate(
        venueData,
      );
    else if (isSearchFilter!)
      _addVenuesFromDate(
        venueData,
      );
    else
      for (AvailableTimeResponse openTime in joinedDates!)
        venueData.addAll({
          openTime.days: MapEntry(
            openTime.from,
            openTime.to,
          )
        });
  }

  void _addVenuesFromDate(
    Map<List<DayOfWeek>, MapEntry> venueData,
  ) {
    if (isOpenNowTab!) dateFilterRequestFrom = DateTime.now();
    for (AvailableTimeResponse openTime in joinedDates!)
      // * this case only for search or filter with date

      venueData.addAll({
        if (openTime.isMatchingDate(dateFilterRequestFrom!))
          openTime.days: MapEntry(
            openTime.from,
            openTime.to,
          )
        // * this case only for search or filter without date
        else
          openTime.days: MapEntry(
            openTime.from,
            openTime.to,
          )
      });
  }
}
