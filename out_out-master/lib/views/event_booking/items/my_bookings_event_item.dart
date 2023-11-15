import 'package:flutter/material.dart';
import 'package:out_out/data/view_models/event_booking/event_booking_summary_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/universal_image.dart';

class MyBookingsEventCardItem extends StatelessWidget {
  final EventBookingSummaryResponse eventBookingSummaryResponse;

  const MyBookingsEventCardItem({
    Key? key,
    required this.eventBookingSummaryResponse,
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
        onTap: () => Navigation().navToEventBookingDetailsScreen(
          context,
          eventBookingId: eventBookingSummaryResponse.id,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: UniversalImage.venue(eventBookingSummaryResponse.event.image),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          eventBookingSummaryResponse.event.name!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.bold, fontSize: 15.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          eventBookingSummaryResponse.event.occurrence!.explain(),
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "Status: ${eventBookingSummaryResponse.status.name}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontWeight: FontWeight.w300, fontSize: 10.0),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                      child: Text(
                        "View Details",
                        style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white, fontSize: 15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
