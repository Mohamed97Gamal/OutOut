import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:out_out/data/view_models/event/event_summary_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/universal_image.dart';

class FeaturedEventCarouselItem extends StatelessWidget {
  static DateFormat _dateFormat = DateFormat("${DateFormat.DAY}\n${DateFormat.ABBR_MONTH}");
  final EventSummaryResponse eventSummaryResponse;

  const FeaturedEventCarouselItem({
    Key? key,
    required this.eventSummaryResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation().navToEventDetailsScreen(context, occurrenceId: eventSummaryResponse.occurrence!.id);
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: UniversalImage.eventBackground(
                    eventSummaryResponse.image,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventSummaryResponse.name!,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 13.0, fontWeight: FontWeight.bold),
                      ),
                      if (eventSummaryResponse.description != null)
                        Text(
                          eventSummaryResponse.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            child: Container(
              width: 30,
              height: 30,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  eventSummaryResponse.occurrence!.explainDateOnly(_dateFormat),
                  style: TextStyle(fontSize: 12.0, height: 1.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
