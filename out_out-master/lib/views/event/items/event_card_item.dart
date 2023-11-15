import 'package:flutter/material.dart';
import 'package:out_out/data/view_models/event/event_summary_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/universal_image.dart';

class EventCardItem extends StatelessWidget {
  final EventSummaryResponse eventSummaryResponse;

  const EventCardItem({
    required this.eventSummaryResponse,
    Key? key,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 16.0),
        child: InkWell(
          onTap: () {
            Navigation().navToEventDetailsScreen(
              context,
              occurrenceId: eventSummaryResponse.occurrence!.id,
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1.05,
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
                      if (eventSummaryResponse.name != null)
                        Text(
                          eventSummaryResponse.name!,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                  ),
                        ),
                          const SizedBox(height: 8.0),
                      if (eventSummaryResponse.occurrence != null)
                        Text(
                          eventSummaryResponse.occurrence!.explain(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                          const SizedBox(height: 8.0),
                      if (eventSummaryResponse.location != null)
                        Text(
                          "${eventSummaryResponse.location!.area}, ${eventSummaryResponse.location!.city.name} | ${eventSummaryResponse.location!.distance} km",
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w300),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
