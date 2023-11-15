import 'package:flutter/material.dart';
import 'package:out_out/data/view_models/event/event_summary_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/views/event/action_buttons/favorite_event_button.dart';
import 'package:out_out/widgets/universal_image.dart';

class MyFavouriteEventCardItem extends StatelessWidget {
  final EventSummaryResponse eventSummaryResponse;
  final ValueChanged<bool>? onFavoriteChanged;

  const MyFavouriteEventCardItem({
    Key? key,
    this.onFavoriteChanged,
    required this.eventSummaryResponse,
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
        onTap: () => Navigation().navToEventDetailsScreen(context, occurrenceId: eventSummaryResponse.occurrence!.id),
        child: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: UniversalImage.event(eventSummaryResponse.image),
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
                            eventSummaryResponse.name!,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                        ),
                        Text(
                          eventSummaryResponse.occurrence!.explain(),
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).primaryColor),
                        ),
                        if (eventSummaryResponse.location != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "${eventSummaryResponse.location!.area} - ${eventSummaryResponse.location!.city.name}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
                                ),
                              ),
                              Text(
                                "${eventSummaryResponse.location!.distance} km",
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
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: FavoriteEventButton(
                eventName: eventSummaryResponse.name!,
                occurrenceId: eventSummaryResponse.occurrence!.id,
                initialIsFavorite: eventSummaryResponse.isFavorite!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
