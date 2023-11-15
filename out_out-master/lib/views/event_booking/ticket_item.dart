import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/view_models/event/single_event_occurrence_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/utils/dynamic_links_utils.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketItem extends StatelessWidget {
  final SingleEventOccurrenceResponse singleEventOccurrenceResponse;
  final int index;
  final RefreshNotifier refreshNotifier;
  final String? ticketIdFromShared, ticketId;

  const TicketItem({
    Key? key,
    required this.singleEventOccurrenceResponse,
    required this.index,
    required this.refreshNotifier,
    this.ticketIdFromShared,
    this.ticketId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAccountProvider = context.watch<MyAccountProvider>();
    return InkWell(
      onTap: () {
        refreshNotifier.refresh();
        Navigation().navToTicketsScreen(
          context,
          eventDetailsRefreshNotifier: refreshNotifier,
          singleEventOccurrenceResponse: singleEventOccurrenceResponse,
          ticketIdFromShared: ticketIdFromShared,
          ticketId: ticketId,
          carouselSliderIndex: index,
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        singleEventOccurrenceResponse.name,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                singleEventOccurrenceResponse.occurrence!
                                    .explain(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Quantity : ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${index + 1} of ${singleEventOccurrenceResponse.booking!.quantity}",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 13.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomFutureBuilder<String>(
                  initFuture: () async {
                    final link = await createLink(
                      relativeUrl: singleEventOccurrenceResponse
                          .booking!.tickets[index]
                          .qrCodeRelativeUrl(
                              myAccountProvider.applicationUserResponse.id),
                    );
                    return link;
                  },
                  onSuccess: (context, snapshot) {
                    final data = snapshot.data;
                    if (data != null) {
                      return QrImageView(
                        data: data,
                        version: QrVersions.auto,
                        size: 50.0,
                        gapless: true,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
