import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:out_out/data/view_models/venue/venue_summary_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/views/venue/action_buttons/favorite_venue_button.dart';
import 'package:out_out/views/venue/items/venue_card_item.dart';
import 'package:out_out/widgets/universal_image.dart';

class MyFavoriteVenueCardItem extends StatelessWidget {
  final VenueSummaryResponse venueSummaryResponse;
  final ValueChanged<bool>? onFavoriteChanged;

  const MyFavoriteVenueCardItem({
    Key? key,
    required this.venueSummaryResponse,
    this.onFavoriteChanged,
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
        onTap: () => Navigation().navToVenueDetailsScreen(context, venueId: venueSummaryResponse.id),
        child: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: UniversalImage.venue(venueSummaryResponse.logo),
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
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            venueSummaryResponse.name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                        ),
                        VenueOpenTimes(
                          openTimes: venueSummaryResponse.openTimes,
                          showFirstOnly: true,
                        ),
                        if (venueSummaryResponse.location != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  "${venueSummaryResponse.location!.area} - ${venueSummaryResponse.location!.city.name}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
                                ),
                              ),
                              Text(
                                "${venueSummaryResponse.location!.distance} km",
                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (venueSummaryResponse.categories.isNotEmpty)
              Positioned(
                top: 0.0,
                right: 0.0,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  child: Text(
                    venueSummaryResponse.categories.first.name,
                    style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: FavoriteVenueButton(
                venueId: venueSummaryResponse.id,
                venueName: venueSummaryResponse.name,
                initialIsFavorite: venueSummaryResponse.isFavorite,
                onChanged: onFavoriteChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
