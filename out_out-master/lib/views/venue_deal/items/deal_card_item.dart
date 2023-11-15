import 'package:flutter/material.dart';
import 'package:out_out/data/view_models/venue_deal/offer_with_venue_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/views/venue/items/venue_card_item.dart';
import 'package:out_out/widgets/universal_image.dart';

class DealCardItem extends StatelessWidget {
  final OfferWithVenueResponse offerWithVenueResponse;
  final DateTime dateTime;
  const DealCardItem({
    Key? key,
    required this.offerWithVenueResponse,
    required this.dateTime,
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
      child: InkWell(
        onTap: () => Navigation().navToVenueDetailsScreen(context,
            venueId: offerWithVenueResponse.venue.id),
        child: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 1.05,
                    child:
                        UniversalImage.venue(offerWithVenueResponse.venue.logo),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            offerWithVenueResponse.type.name,
                            maxLines: 5,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        VenueOpenTimes(
                          openTimes: offerWithVenueResponse.venue.openTimes,
                          showFirstOnly: true,
                          isSearchFilter: true,
                          dateFilterRequestFrom: DateTime.now(),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "${offerWithVenueResponse.venue.location!.area} - ${offerWithVenueResponse.venue.location!.city.name} | ${offerWithVenueResponse.venue.location!.distance} km",
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
