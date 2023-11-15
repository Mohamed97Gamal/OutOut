import 'dart:async';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/view_models/event/single_event_occurrence_response.dart';
import 'package:out_out/data/view_models/event/single_event_occurrence_response_operation_result.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/views/event_booking/ticket_image_view.dart';
import 'package:out_out/views/event_booking/ticket_share_button.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/custom_carousel.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/refreshable.dart';

class TicketsScreen extends StatefulWidget {
  final SingleEventOccurrenceResponse singleEventOccurrenceResponse;
  final int initialCarouselSliderIndex;
  final RefreshNotifier eventDetailsRefreshNotifier;
  final String? ticketIdFromShared;
  final String? ticketId;

  const TicketsScreen({
    Key? key,
    required this.singleEventOccurrenceResponse,
    required this.initialCarouselSliderIndex,
    required this.eventDetailsRefreshNotifier,
    this.ticketIdFromShared,
    this.ticketId,
  }) : super(key: key);

  @override
  _TicketsScreenState createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  late int _current;
  final RefreshNotifier refreshNotifier = RefreshNotifier();
  Timer? timer;
  bool flagRedeemed = false;
  String flagStatus = "";

  @override
  void initState() {
    super.initState();
    _current = widget.initialCarouselSliderIndex;
    flagStatus =
        widget.singleEventOccurrenceResponse.booking!.tickets[_current].status;
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) {
      refreshNotifier.refresh();
      widget.eventDetailsRefreshNotifier.refresh();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      headerHeight: 130,
      header: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 20),
          child: Text(
            "Tickets",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Refreshable(
        refreshNotifier: refreshNotifier,
        child:
            CustomFutureBuilder<SingleEventOccurrenceResponseOperationResult?>(
          initFuture: () async {
            if (widget.ticketIdFromShared != null || widget.ticketId != null) {
              final eventBookingDetailsResult = await ApiRepo()
                  .eventClient
                  .getSharedTicketDetails(widget.ticketIdFromShared??widget.ticketId!);
              return eventBookingDetailsResult;
            } else {
              final eventBookingDetailsResult = await ApiRepo()
                  .eventClient
                  .getBookingDetails(
                      widget.singleEventOccurrenceResponse.booking!.id);
              return eventBookingDetailsResult;
            }
          },
          onLoading: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.singleEventOccurrenceResponse.name,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                      ),
                      TicketShareButton(
                        singleEventOccurrenceResponse:
                            widget.singleEventOccurrenceResponse,
                        ticketNumber: _current,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Date : ${widget.singleEventOccurrenceResponse.occurrence!.explain()}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Quantity : ${_current + 1} of ${widget.singleEventOccurrenceResponse.booking!.quantity}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Time : ${widget.singleEventOccurrenceResponse.occurrence!.startTime} | ${widget.singleEventOccurrenceResponse.occurrence!.endTime}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Total Amount : ${widget.singleEventOccurrenceResponse.booking!.tickets.first.package.price} ${widget.singleEventOccurrenceResponse.booking!.currency}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Location : ${widget.singleEventOccurrenceResponse.location.description}, ${widget.singleEventOccurrenceResponse.location.city.name}",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Status : $flagStatus",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 40.0),
                  Center(
                    child: DottedLine(
                      dashLength: 10,
                      dashGapLength: 5,
                      dashColor: Colors.grey,
                      lineLength: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      "This QR code will be scanned by the Venue upon arrival",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      "Redeem and share button are per single ticket ",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: CustomCarousel(
                      initialPage: _current,
                      aspectRatio: 2.5,
                      borderRadius: 10.0,
                      showIndicator: true,
                      enableInfiniteScroll: true,
                      withCards: false,
                      onChanged: (current) {
                        setState(() {
                          _current = current;
                        });
                      },
                      items: [
                        for (int i = 0;
                            i <
                                widget.singleEventOccurrenceResponse.booking!
                                    .tickets.length;
                            i++)
                          Center(
                            child: TicketImageView(
                              key: ValueKey(widget.singleEventOccurrenceResponse
                                  .booking!.tickets[_current].id),
                              isQrClickable: true,
                              onPressed: null,
                              ticketResponse: widget
                                  .singleEventOccurrenceResponse
                                  .booking!
                                  .tickets[_current],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: double.maxFinite,
                    height: 40.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Theme.of(context).primaryColor),
                      child: widget.singleEventOccurrenceResponse.booking!
                              .tickets[_current].isRedeemed
                          ? Text("Redeemed")
                          : Text(
                              "Redeem",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.white),
                            ),
                      onPressed: widget.singleEventOccurrenceResponse.booking!
                                  .tickets[_current].isRedeemed ||
                              flagRedeemed
                          ? null
                          : () async {
                              var redeemed =
                                  await Navigation().navToTicketRedeemScreen(
                                context,
                                refreshNotifier: refreshNotifier,
                                ticketResponse: widget
                                    .singleEventOccurrenceResponse
                                    .booking!
                                    .tickets[_current],
                              );
                              if (redeemed) {
                                setState(() {
                                  widget
                                      .singleEventOccurrenceResponse
                                      .booking!
                                      .tickets[_current]
                                      .redemptionDate = DateTime.now().toUtc();
                                });
                              }
                            },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: double.maxFinite,
                    height: 40.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Theme.of(context).primaryColor),
                      child: Text(
                        "Done",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).maybePop();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          onSuccess: (context, snapshot) {
            final status =
                snapshot.data!.result.booking!.tickets[_current].status;
            flagRedeemed = widget.singleEventOccurrenceResponse.booking!
                    .tickets[_current].isRedeemed ||
                status == "Approved" ||
                status == "Rejected";
            flagStatus = status;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.singleEventOccurrenceResponse.name,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                      ),
                      TicketShareButton(
                        singleEventOccurrenceResponse:
                            widget.singleEventOccurrenceResponse,
                        ticketNumber: _current,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Date : ${widget.singleEventOccurrenceResponse.occurrence!.explain()}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Quantity : ${_current + 1} of ${widget.singleEventOccurrenceResponse.booking!.quantity}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Time : ${widget.singleEventOccurrenceResponse.occurrence!.startTime} | ${widget.singleEventOccurrenceResponse.occurrence!.endTime}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Total Amount : ${widget.singleEventOccurrenceResponse.booking!.tickets.first.package.price} ${widget.singleEventOccurrenceResponse.booking!.currency}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Location : ${widget.singleEventOccurrenceResponse.location.description}, ${widget.singleEventOccurrenceResponse.location.city.name}",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Status : ${status}",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 40.0),
                  Center(
                    child: DottedLine(
                      dashLength: 10,
                      dashGapLength: 5,
                      dashColor: Colors.grey,
                      lineLength: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      "This QR code will be scanned by the Venue upon arrival",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      "Redeem and share button are per single ticket ",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: CustomCarousel(
                      initialPage: _current,
                      aspectRatio: 2.5,
                      borderRadius: 10.0,
                      showIndicator: true,
                      enableInfiniteScroll: true,
                      withCards: false,
                      onChanged: (current) {
                        setState(() {
                          _current = current;
                        });
                      },
                      items: [
                        for (int i = 0;
                            i <
                                widget.singleEventOccurrenceResponse.booking!
                                    .tickets.length;
                            i++)
                          Center(
                            child: TicketImageView(
                              key: ValueKey(widget.singleEventOccurrenceResponse
                                  .booking!.tickets[_current].id),
                              isQrClickable: true,
                              onPressed: null,
                              ticketResponse: widget
                                  .singleEventOccurrenceResponse
                                  .booking!
                                  .tickets[_current],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: double.maxFinite,
                    height: 40.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Theme.of(context).primaryColor),
                      child: widget.singleEventOccurrenceResponse.booking!
                              .tickets[_current].isRedeemed
                          ? Text("Redeemed")
                          : Text(
                              "Redeem",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.white),
                            ),
                      onPressed: widget.singleEventOccurrenceResponse.booking!
                                  .tickets[_current].isRedeemed ||
                              status == "Approved" ||
                              status == "Rejected"
                          ? null
                          : () async {
                              var redeemed =
                                  await Navigation().navToTicketRedeemScreen(
                                context,
                                refreshNotifier: refreshNotifier,
                                ticketResponse: widget
                                    .singleEventOccurrenceResponse
                                    .booking!
                                    .tickets[_current],
                              );
                              if (redeemed) {
                                setState(() {
                                  widget
                                      .singleEventOccurrenceResponse
                                      .booking!
                                      .tickets[_current]
                                      .redemptionDate = DateTime.now().toUtc();
                                });
                              }
                            },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: double.maxFinite,
                    height: 40.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Theme.of(context).primaryColor),
                      child: Text(
                        "Done",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        refreshNotifier.refresh();
                        widget.eventDetailsRefreshNotifier.refresh();
                        Navigator.of(context).maybePop();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
