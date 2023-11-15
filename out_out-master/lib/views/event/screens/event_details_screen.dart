import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/models/enums/payment_status.dart';
import 'package:out_out/data/models/enums/reminder_type.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/data/view_models/category/category_response.dart';
import 'package:out_out/data/view_models/event/event_package_response.dart';
import 'package:out_out/data/view_models/event/single_event_occurrence_response.dart';
import 'package:out_out/data/view_models/event/single_event_occurrence_response_operation_result.dart';
import 'package:out_out/data/view_models/event_booking/booking_reminder_request.dart';
import 'package:out_out/data/view_models/event_booking/event_booking_mini_summary_response.dart';
import 'package:out_out/data/view_models/event_booking/share_ticket_request.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/utils/constants.dart';
import 'package:out_out/utils/date_utils.dart';
import 'package:out_out/utils/dynamic_links_utils.dart';
import 'package:out_out/utils/share_utils.dart';
import 'package:out_out/utils/url_launcher_utils.dart';
import 'package:out_out/views/event/action_buttons/favorite_event_button.dart';
import 'package:out_out/views/event/action_buttons/share_event_button.dart';
import 'package:out_out/views/event/event_action.dart';
import 'package:out_out/views/event/schedule_dialoge.dart';
import 'package:out_out/views/event_booking/ticket_image_view.dart';
import 'package:out_out/views/event_booking/ticket_item.dart';
import 'package:out_out/widgets/containers/custom_details_scaffold.dart';
import 'package:out_out/widgets/custom_social_media_button.dart';
import 'package:out_out/widgets/fields/custom_checkboxgroup_form_field.dart';
import 'package:out_out/widgets/loading/adaptive_progress_indicator.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_bottom_sheet.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/src/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  final refreshNotifier = RefreshNotifier();
  final String? occurrenceId;
  final String? eventBookingId;
  final String? ticketId;
  final String? secret;
  final String? ticketIdFromShared;
  final String? secretFromShared;

  EventDetailsScreen({
    this.occurrenceId,
    Key? key,
    this.eventBookingId,
    this.ticketId,
    this.secret,
    this.ticketIdFromShared,
    this.secretFromShared,
  })  : assert(occurrenceId != null ||
            eventBookingId != null ||
            ticketId != null ||
            secret != null ||
            ticketIdFromShared != null ||
            secretFromShared != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Refreshable(
      refreshNotifier: refreshNotifier,
      child: CustomFutureBuilder<SingleEventOccurrenceResponseOperationResult?>(
        initFuture: () async {
          if (occurrenceId != null) {
            final eventDetailsResult =
                await ApiRepo().eventClient.getEventDetails(occurrenceId!);
            return eventDetailsResult;
          } else if (eventBookingId != null) {
            final eventBookingDetailsResult =
                await ApiRepo().eventClient.getBookingDetails(eventBookingId!);

            return eventBookingDetailsResult;
          } else if (ticketIdFromShared != null) {
            final eventBookingDetailsResult = await ApiRepo()
                .eventClient
                .getSharedTicketDetails(ticketIdFromShared!);
            return eventBookingDetailsResult;
          } else {
            final eventBookingDetailsResult =
                await ApiRepo().eventClient.getSharedTicketDetails(ticketId!);
            if (!eventBookingDetailsResult.status) {
              final shareTicketRequest = new ShareTicketRequest()
                ..ticketId = ticketId!
                ..ticketSecret = secret!;
              final isTicketShareableResult = await ApiRepo()
                  .eventClient
                  .isTicketShareable(shareTicketRequest);
              if (isTicketShareableResult.status) {
                final request = new ShareTicketRequest()
                  ..ticketId = ticketId!
                  ..ticketSecret = secret!;
                final result =
                    await ApiRepo().eventClient.addToSharedTickets(request);
                if (result.status) {
                  final eventBookingDetailsResult = await ApiRepo()
                      .eventClient
                      .getSharedTicketDetails(ticketId!);
                  return eventBookingDetailsResult;
                } else {
                  return await showAdaptiveErrorDialog(
                    context: context,
                    title: "Error",
                    content: result.errorMessage ?? "Unknown Error",
                  );
                }
              } else {
                await showAdaptiveAlertDialog(
                  barrierDismissible: false,
                  context: context,
                  icon: UniversalImage(IconAssets.failed),
                  title:
                      isTicketShareableResult.errorMessage ?? "Unknown Error",
                  content: "",
                  showCloseButton: true,
                  actions: <AdaptiveAlertDialogAction>[
                    AdaptiveAlertDialogAction(
                      title: "Done",
                      onPressed: () async {
                        await Navigator.of(context).maybePop();
                      },
                      isPrimary: true,
                    ),
                  ],
                );
                await Navigation().navToHomeScreen(context);
              }
            } else {
              return eventBookingDetailsResult;
            }
          }
        },
        onLoading: (context) {
          return Material(
            child: Center(
              child: AdaptiveProgressIndicator(),
            ),
          );
        },
        onSuccess: (context, snapshot) {
          final eventResponse = snapshot.data!.result;
          final dateTime = fromDateAndTimeSpan(
              eventResponse.occurrence!.startDate,
              eventResponse.occurrence!.startTime);
          return CustomDetailsScaffold(
            showArrowBG: true,
            background: UniversalImage.eventBackground(
              eventResponse.image,
              height: 175.0,
              width: double.infinity,
            ),
            body: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EventHeader(singleEventOccurrenceResponse: eventResponse),
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0.0,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    color: Colors.white,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: size.height * 0.75,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(size.height * .02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                EventHostedBy(
                                    singleEventOccurrenceResponse:
                                        eventResponse),
                                FavoriteEventButton(
                                  eventName: eventResponse.name,
                                  occurrenceId: eventResponse.occurrence!.id,
                                  initialIsFavorite: eventResponse.isFavorite,
                                  size: size.width * .085,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: EventCategoriesBar(
                                  singleEventOccurrenceResponse: eventResponse),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 0.0, 30.0, 0.0),
                              child: Divider(
                                indent: 16.0,
                                height: 1.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Event Details",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                eventResponse.description
                                        ?.replaceAll('\r', '') ??
                                    "",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontWeight: FontWeight.w300),
                              ),
                            ),
                            EventAction(
                              onPressed: () {},
                              icon: UniversalImage(IconAssets.clock),
                              content: [
                                Text(eventResponse.occurrence!
                                    .explainDateOnly()),
                                Text(
                                    "${eventResponse.occurrence!.startTime} To ${eventResponse.occurrence!.endTime}"),
                              ],
                            ),
                            if (eventResponse.occurrences.isNotEmpty &&
                                eventResponse.booking == null)
                              Center(
                                child: TextButton(
                                  onPressed: () async {
                                    await showScheduleDialog(
                                      context: context,
                                      occurrences: eventResponse.occurrences,
                                    );
                                  },
                                  child: Text(
                                    "View Full Schedule",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            EventAction(
                              icon: UniversalImage(IconAssets.direction),
                              content: [
                                Text(
                                    "${eventResponse.location.area}, ${eventResponse.location.city.name}"),
                                if (eventResponse.location.description != null)
                                  Text(eventResponse.location.description!),
                              ],
                              onPressed: () => launchMaps(
                                eventResponse.location.latitude,
                                eventResponse.location.longitude,
                              ),
                            ),
                            if (eventResponse.phoneNumber != null)
                              EventAction(
                                icon: UniversalImage(IconAssets.phone_event),
                                content: [
                                  Text(eventResponse.phoneNumber!),
                                ],
                                onPressed: () =>
                                    launchTelephone(eventResponse.phoneNumber!),
                              ),
                            if (eventResponse.email != null)
                              EventAction(
                                icon: UniversalImage(IconAssets.mail),
                                content: [
                                  Text(eventResponse.email!),
                                ],
                                onPressed: () =>
                                    launchMail(eventResponse.email!),
                              ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            //TODO: review this if state
                            if (eventResponse.booking != null &&
                                ticketId == null &&
                                ticketIdFromShared == null)
                              EventAction(
                                icon: UniversalImage(IconAssets.tickets),
                                content: [
                                  Text(eventResponse.booking!.quantity
                                      .toString()),
                                ],
                              ),
                            if (eventResponse.booking != null &&
                                ticketId == null &&
                                ticketIdFromShared == null)
                              EventAction(
                                icon: UniversalImage(IconAssets.money),
                                content: [
                                  Text(
                                      "${eventResponse.booking!.totalAmount.toString()}  ${eventResponse.booking!.currency}"),
                                ],
                              ),
                            if (eventResponse.occurrence!.packages.isNotEmpty &&
                                eventResponse.booking == null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Pricing",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                            const SizedBox(height: 8.0),
                            if (eventResponse.occurrence!.packages.isNotEmpty &&
                                eventResponse.booking == null)
                              EventPackages(
                                packages: eventResponse.occurrence!.packages,
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (eventResponse.facebookLink != null)
                                  CustomSocialMediaButton(
                                    url: eventResponse.facebookLink!,
                                    icon: FaIcon(
                                      FontAwesomeIcons.facebookF,
                                      color: Colors.white,
                                      size: 15.0,
                                    ),
                                  ),
                                if (eventResponse.youtubeLink != null)
                                  CustomSocialMediaButton(
                                    url: eventResponse.youtubeLink!,
                                    icon: FaIcon(
                                      FontAwesomeIcons.youtube,
                                      color: Colors.white,
                                      size: 15.0,
                                    ),
                                  ),
                                if (eventResponse.instagramLink != null)
                                  CustomSocialMediaButton(
                                    url: eventResponse.instagramLink!,
                                    icon: FaIcon(
                                      FontAwesomeIcons.instagram,
                                      color: Colors.white,
                                      size: 15.0,
                                    ),
                                  ),
                                if (eventResponse.webpageLink != null)
                                  CustomSocialMediaButton(
                                    url: eventResponse.webpageLink!,
                                    icon: FaIcon(
                                      FontAwesomeIcons.link,
                                      color: Colors.white,
                                      size: 15.0,
                                    ),
                                  ),
                              ],
                            ),
                            if (eventResponse.occurrence!.packages.isNotEmpty &&
                                eventResponse.booking == null)
                              const SizedBox(height: 30.0),
                            if (eventResponse.booking != null &&
                                eventResponse.booking!.status.value !=
                                    PaymentStatus.rejected.value)
                              EventTickets(
                                singleEventOccurrenceResponse: eventResponse,
                                ticketId: ticketId,
                                ticketIdFromShared: ticketIdFromShared,
                                refreshNotifier: refreshNotifier,
                              ),
                            const SizedBox(height: 10.0),
                            if (eventResponse.booking != null &&
                                dateTime.isAfter(DateTime.now()) &&
                                eventResponse.booking!.status !=
                                    PaymentStatus.cancelled &&
                                eventResponse.booking!.status !=
                                    PaymentStatus.declined &&
                                eventResponse.booking!.status.value !=
                                    PaymentStatus.rejected.value)
                              SetAReminderButton(
                                ticketId: ticketId,
                                ticketIdFromShared: ticketIdFromShared,
                                refreshNotifier: refreshNotifier,
                                eventBookingSummaryResponse:
                                    eventResponse.booking!,
                              ),
                            if (eventResponse.booking != null &&
                                eventResponse.booking!.status !=
                                    PaymentStatus.cancelled &&
                                eventResponse.booking!.status !=
                                    PaymentStatus.declined &&
                                eventResponse.booking!.status.value !=
                                    PaymentStatus.rejected.value)
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: size.height * .06),
                                child: BookAgainButton(
                                  singleEventOccurrenceResponse: eventResponse,
                                ),
                              ),
                            if (eventResponse.booking == null)
                              Container(
                                width: double.maxFinite,
                                height: 40.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shadowColor:
                                          Theme.of(context).primaryColor),
                                  child: Text(
                                    "Book Ticket",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    await Navigation().navToBookEvent(context,
                                        singleEventOccurrenceResponse:
                                            eventResponse);
                                    refreshNotifier.refresh();
                                  },
                                ),
                              ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class EventHeader extends StatelessWidget {
  final SingleEventOccurrenceResponse singleEventOccurrenceResponse;

  const EventHeader({
    Key? key,
    required this.singleEventOccurrenceResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 45.0,
                    height: 45.0,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          singleEventOccurrenceResponse.location.distance
                              .toStringAsFixed(0),
                          style: TextStyle(
                            height: 1.0,
                            fontSize: 15.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "KM",
                          style: TextStyle(
                            fontSize: 15.0,
                            height: 1.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Tooltip(
                        message: singleEventOccurrenceResponse.name,
                        child: Text(
                          singleEventOccurrenceResponse.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Tooltip(
                        message:
                            "${singleEventOccurrenceResponse.location.area}, ${singleEventOccurrenceResponse.location.city.name}",
                        child: Text(
                          "${singleEventOccurrenceResponse.location.area}, ${singleEventOccurrenceResponse.location.city.name}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ShareEventButton(
            eventName: singleEventOccurrenceResponse.name,
            occurrenceId: singleEventOccurrenceResponse.occurrence!.id,
            eventDescription: singleEventOccurrenceResponse.description,
            eventImageUrl: singleEventOccurrenceResponse.image,
          ),
        ],
      ),
    );
  }
}

class EventHostedBy extends StatelessWidget {
  final SingleEventOccurrenceResponse singleEventOccurrenceResponse;

  const EventHostedBy({
    Key? key,
    required this.singleEventOccurrenceResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UniversalImage.venue(
          singleEventOccurrenceResponse.venue.logo,
          width: size.width * .2,
          height: size.height * .15,
        ),
        const SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Text(
              "Hosted by",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: size.width * .45,
              child: Text(singleEventOccurrenceResponse.venue.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ],
    );
  }
}

class EventCategoriesBar extends StatelessWidget {
  final SingleEventOccurrenceResponse singleEventOccurrenceResponse;

  const EventCategoriesBar({
    Key? key,
    required this.singleEventOccurrenceResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, right: 16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 3.0,
        children: [
          for (var item in singleEventOccurrenceResponse.categories)
            CustomCategoryEventChip(categoryResponse: item),
        ],
      ),
    );
  }
}

class CustomCategoryEventChip extends StatelessWidget {
  final CategoryResponse categoryResponse;

  const CustomCategoryEventChip({
    Key? key,
    required this.categoryResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(3.0),
          topRight: Radius.circular(3.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            UniversalImage.category(
              categoryResponse.icon,
              selected: true,
              width: 15,
              height: 15,
            ),
            const SizedBox(width: 10),
            Text(
              categoryResponse.name,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

class EventPackages extends StatelessWidget {
  final List<EventPackageResponse> packages;

  const EventPackages({
    Key? key,
    required this.packages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        for (var package in packages)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 10.0,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 10),
                Container(
                  width: size.width * 0.75,
                  child: Text(
                    "AED ${package.price} - ${package.title}",
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class EventTickets extends StatefulWidget {
  final SingleEventOccurrenceResponse singleEventOccurrenceResponse;
  final String? ticketId;
  final String? ticketIdFromShared;
  final RefreshNotifier refreshNotifier;

  const EventTickets({
    Key? key,
    required this.singleEventOccurrenceResponse,
    this.ticketId,
    required this.refreshNotifier,
    this.ticketIdFromShared,
  }) : super(key: key);

  @override
  _EventTicketsState createState() => _EventTicketsState();
}

class _EventTicketsState extends State<EventTickets> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final myAccountProvider = context.watch<MyAccountProvider>();
    return Column(
      children: [
        const SizedBox(height: 40.0),
        Center(
          child: DottedLine(
            dashLength: 10,
            dashGapLength: 5,
            dashColor: Colors.grey,
            lineLength: size.width * 0.7,
          ),
        ),
        const SizedBox(height: 20.0),
        Center(
          child: Text(
            AppStrings.qrCodeEnter,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TicketImageView(
                  ticketResponse: widget
                      .singleEventOccurrenceResponse.booking!.tickets.first,
                  onPressed: () async {
                    widget.refreshNotifier.refresh();
                    Navigation().navToTicketsScreen(
                      context,
                      eventDetailsRefreshNotifier: widget.refreshNotifier,
                      ticketIdFromShared: widget.ticketIdFromShared,
                      ticketId: widget.ticketId,
                      singleEventOccurrenceResponse:
                          widget.singleEventOccurrenceResponse,
                      carouselSliderIndex: 0,
                    );
                  },
                ),
                Column(
                  children: [
                    ElevatedButton(
                      child: widget.singleEventOccurrenceResponse.booking!
                              .tickets.first.isRedeemed
                          ? Text("Redeemed")
                          : Text("Redeem"),
                      onPressed: widget.singleEventOccurrenceResponse.booking!
                              .tickets.first.isRedeemed
                          ? null
                          : () async {
                              widget.refreshNotifier.refresh();
                              var redeemed =
                                  await Navigation().navToTicketRedeemScreen(
                                context,
                                refreshNotifier: widget.refreshNotifier,
                                ticketResponse: widget
                                    .singleEventOccurrenceResponse
                                    .booking!
                                    .tickets
                                    .first,
                              );
                              if (redeemed) {
                                setState(() {
                                  widget
                                      .singleEventOccurrenceResponse
                                      .booking!
                                      .tickets
                                      .first
                                      .redemptionDate = DateTime.now().toUtc();
                                });
                              }
                            },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      child: Text("Share"),
                      onPressed: () async {
                        var result = await showFutureProgressDialog<
                            BooleanOperationResult>(
                          context: context,
                          initFuture: () async {
                            final request = new ShareTicketRequest()
                              ..ticketId = widget.singleEventOccurrenceResponse
                                  .booking!.tickets.first.id
                              ..ticketSecret = widget
                                  .singleEventOccurrenceResponse
                                  .booking!
                                  .tickets
                                  .first
                                  .secret;

                            return await ApiRepo()
                                .eventClient
                                .isTicketShareable(request);
                          },
                        );
                        if (result != null && result.status) {
                          await showFutureProgressDialog(
                            context: context,
                            initFuture: () async {
                              final link = await createDynamicLink(
                                relativeUrl: widget
                                    .singleEventOccurrenceResponse
                                    .booking!
                                    .tickets
                                    .first
                                    .qrCodeRelativeUrl(myAccountProvider
                                        .applicationUserResponse.id),
                                title:
                                    widget.singleEventOccurrenceResponse.name,
                                description: "Redeem Your Ticket On OutOut",
                                imageUrl:
                                    widget.singleEventOccurrenceResponse.image,
                                short: true,
                              );
                              await share(link);
                            },
                          );
                        } else {
                          await showAdaptiveErrorDialog(
                            context: context,
                            title: "Error",
                            content: result?.errorMessage ?? "Unknown Error",
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (widget.singleEventOccurrenceResponse.booking!.tickets.length > 1)
          for (int i = 1;
              i < widget.singleEventOccurrenceResponse.booking!.tickets.length;
              i++)
            TicketItem(
              ticketIdFromShared: widget.ticketIdFromShared,
                ticketId: widget.ticketId,
                refreshNotifier: widget.refreshNotifier,
                singleEventOccurrenceResponse:
                    widget.singleEventOccurrenceResponse,
                index: i),
      ],
    );
  }
}

class SetAReminderButton extends StatelessWidget {
  final RefreshNotifier refreshNotifier;
  final String? ticketId;
  final EventBookingMiniSummaryResponse eventBookingSummaryResponse;
  final String? ticketIdFromShared;
  final _formKey = GlobalKey<FormBuilderState>();

  SetAReminderButton({
    required this.eventBookingSummaryResponse,
    required this.refreshNotifier,
    Key? key,
    this.ticketId,
    this.ticketIdFromShared,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
            child: Text("Set A Reminder"),
            onPressed: () async {
              await showAdaptiveBottomSheet(
                showCloseButton: true,
                context: context,
                content: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.alarm,
                            color: Theme.of(context).primaryColor,
                            size: 35.0,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            "Set A Reminder",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      CustomCheckBoxGroupFormField<ReminderType>(
                        name: "reminders_list",
                        initialValue: eventBookingSummaryResponse.reminders,
                        options: [
                          for (var option in ReminderType.availableOptions)
                            FormBuilderFieldOption<ReminderType>(
                              value: option,
                              child: Text(option.name),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <AdaptiveBottomSheetAction>[
                  AdaptiveBottomSheetAction(
                    title: "Done",
                    onPressed: () async {
                      var formState = _formKey.currentState;
                      if (formState == null) return;
                      if (!formState.saveAndValidate()) {
                        return;
                      }
                      var result = await showFutureProgressDialog<
                          BooleanOperationResult>(
                        context: context,
                        initFuture: () async {
                          final request = new BookingReminderRequest()
                            ..bookingId = eventBookingSummaryResponse.id
                            ..reminderTypes = formState.value["reminders_list"]
                                as List<ReminderType>;
                          if (ticketId != null || ticketIdFromShared != null) {
                            return await ApiRepo()
                                .eventClient
                                .setSharedBookingReminder(request);
                          } else {
                            return await ApiRepo()
                                .eventClient
                                .setBookingReminder(request);
                          }
                        },
                      );
                      if (result != null && result.status) {
                        await showAdaptiveAlertDialog(
                          context: context,
                          icon: UniversalImage(IconAssets.done),
                          content: "",
                          title: "Reminder has been set successfully.",
                          showCloseButton: false,
                        );
                        refreshNotifier.refresh();
                      } else {
                        await showAdaptiveErrorDialog(
                          context: context,
                          title: "Error",
                          content: result?.errorMessage ?? "Unknown Error",
                        );
                      }
                      await Navigator.of(context).maybePop();
                      await Navigator.of(context).maybePop();
                    },
                    isPrimary: true,
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

class BookAgainButton extends StatelessWidget {
  final SingleEventOccurrenceResponse singleEventOccurrenceResponse;

  BookAgainButton({
    required this.singleEventOccurrenceResponse,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: OutlinedButton(
            child: Text("Book Again"),
            onPressed: () async {
              Navigation().navToBookEvent(context,
                  singleEventOccurrenceResponse: singleEventOccurrenceResponse);
            },
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
