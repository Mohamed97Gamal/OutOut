import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/models/enums/reminder_type.dart';
import 'package:out_out/data/models/enums/venue_booking_status.dart';
import 'package:out_out/data/view_models/available_time_response.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/data/view_models/category/category_response.dart';
import 'package:out_out/data/view_models/time_span.dart';
import 'package:out_out/data/view_models/venue/terms_and_conditions_response.dart';
import 'package:out_out/data/view_models/venue/venue_details_date_filteration.dart';
import 'package:out_out/data/view_models/venue/venue_response.dart';
import 'package:out_out/data/view_models/venue/venue_response_operation_result.dart';
import 'package:out_out/data/view_models/venue_booking/venue_booking_reminder_request.dart';
import 'package:out_out/data/view_models/venue_booking/venue_booking_summary_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/utils/constants.dart';
import 'package:out_out/utils/date_utils.dart';
import 'package:out_out/utils/url_launcher_utils.dart';
import 'package:out_out/views/event/items/event_card_item.dart';
import 'package:out_out/views/venue/action_buttons/favorite_venue_button.dart';
import 'package:out_out/views/venue/action_buttons/share_venue_button.dart';
import 'package:out_out/views/venue/items/offers_component.dart';
import 'package:out_out/views/venue/venue_action.dart';
import 'package:out_out/views/venue_deal/items/venue_deal_carousel_item.dart';
import 'package:out_out/views/venue_loyalty/items/venue_loyalty_item.dart';
import 'package:out_out/widgets/containers/custom_details_scaffold.dart';
import 'package:out_out/widgets/containers/custom_flat_scaffold.dart';
import 'package:out_out/widgets/custom_carousel.dart';
import 'package:out_out/widgets/custom_social_media_button.dart';
import 'package:out_out/widgets/fields/custom_checkboxgroup_form_field.dart';
import 'package:out_out/widgets/loading/adaptive_progress_indicator.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_bottom_sheet.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class VenueDetailsScreen extends StatelessWidget {
  final refreshNotifier = RefreshNotifier();
  final String? venueId;
  final String? venueBookingId;
  AvailableTimeResponse _availableTimeResponse = AvailableTimeResponse();
  VenueDetailsScreen({
    this.venueId,
    this.venueBookingId,
    Key? key,
  })  : assert(venueId != null || venueBookingId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Refreshable(
      refreshNotifier: refreshNotifier,
      child: CustomFutureBuilder<VenueResponseOperationResult>(
        initFuture: () async {
          if (venueId != null) {
            final venueDetailsResult =
                await ApiRepo().venueClient.getVenueDetails(venueId!);
            return venueDetailsResult;
          } else {
            final venueBookingDetailsResult =
                await ApiRepo().venueClient.getBookingDetails(venueBookingId!);
            return venueBookingDetailsResult;
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
          final venueResponse = snapshot.data!.result;
          final venueId = venueResponse.id;
          final Map<String, MapEntry> dateFilterResult =
              VenueDetailsDateFilteration()
                  .dateFilterationVenueDetails(venueResponse);
          return CustomDetailsScaffold(
            showArrowBG: true,
            background: UniversalImage.venueBackground(
              venueResponse.background,
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
                  VenueHeader(venueResponse: venueResponse),
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
                        minHeight: MediaQuery.of(context).size.height * 0.75,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * .02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UniversalImage.venue(
                                  venueResponse.detailsLogo,
                                  width: MediaQuery.of(context).size.width * .3,
                                  height:
                                      MediaQuery.of(context).size.height * .15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FavoriteVenueButton(
                                    venueId: venueResponse.id,
                                    venueName: venueResponse.name,
                                    initialIsFavorite: venueResponse.isFavorite,
                                    size: 30.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          VenueCategoriesBar(venueResponse: venueResponse),
                          const SizedBox(height: 12.0),
                          HorizontallyPaddedTitleText("Venue Details"),
                          const SizedBox(height: 8.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 4.0),
                            child: Text(
                              venueResponse.description?.replaceAll('\r', '') ??
                                  "",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(fontWeight: FontWeight.w300),
                            ),
                          ),
                          VenueAction(
                            icon: UniversalImage(IconAssets.clock),
                            content: [
                              for (var i = 0;
                                  i < dateFilterResult.keys.length;
                                  i++)
                                Text(
                                    "${dateFilterResult.keys.map((String e) => e).toList()[i]} from ${dateFilterResult.values.map((e) => e.key).toList()[i]} to ${dateFilterResult.values.map((e) => e.value).toList()[i]}"),
                              // for (var openTime in venueResponse.openTimes)
                              //   Text(
                              //       "${openTime.days.explain()} from ${openTime.from} to ${openTime.to}"),
                            ],
                          ),
                          VenueAction(
                            icon: UniversalImage(IconAssets.direction),
                            content: [
                              Text(
                                  "${venueResponse.location.area}, ${venueResponse.location.city.name}"),
                              if (venueResponse.location.description != null)
                                Text(
                                  venueResponse.location.description!,
                                  style: TextStyle(fontSize: 11.0),
                                ),
                            ],
                            onPressed: () => launchMaps(
                              venueResponse.location.latitude,
                              venueResponse.location.longitude,
                            ),
                          ),
                          if (venueResponse.phoneNumber != null)
                            VenueAction(
                              icon: UniversalImage(IconAssets.phone_event),
                              content: [
                                Text(venueResponse.phoneNumber!),
                              ],
                              onPressed: () =>
                                  launchTelephone(venueResponse.phoneNumber!),
                            ),
                          if (venueResponse.menu != null &&
                              venueResponse.menu!.isNotEmpty)
                            VenueAction(
                              icon: UniversalImage(IconAssets.menu),
                              content: [
                                Text("View Menu"),
                              ],
                              onPressed: () => launchURL(venueResponse.menu!),
                            ),
                          VenueAction(
                            icon: UniversalImage(IconAssets.terms),
                            content: [
                              Text("Terms & Conditions"),
                            ],
                            onPressed: () {
                              Navigation().navToVenueTermsScreen(context,
                                  venueId: venueId);
                            },
                          ),
                          const SizedBox(height: 12.0),
                          if (venueResponse.booking != null)
                            VenueBookingDetails(
                              venueBookingSummaryResponse:
                                  venueResponse.booking!,
                            ),
                            const SizedBox(height: 12.0),
                         if(venueResponse.offers.isNotEmpty) OffersComponent(
                            offers: venueResponse.offers,
                            refreshNotifier: refreshNotifier,
                            titleText: "Offers",
                            emptyOffersText: AppStrings.noOffers,
                          ),
                          const SizedBox(height: 12.0),
                          OffersComponent(
                            offers: venueResponse.upcomingOffers,
                            refreshNotifier: refreshNotifier,
                            isUpcomingOffers: true,
                            titleText: "Upcoming Offers",
                            emptyOffersText: AppStrings.noUpcomingOffers,
                          ),
                          // HorizontallyPaddedTitleText("Offers"),
                          // const SizedBox(height: 8.0),
                          // venueResponse.offers.isEmpty
                          //     ? Align(
                          //         alignment: Alignment.center,
                          //         child: Container(
                          //           padding:
                          //               EdgeInsets.symmetric(horizontal: 50.0),
                          //           child: Text(
                          //             AppStrings.noOffers,
                          //             textAlign: TextAlign.center,
                          //           ),
                          //         ),
                          //       )
                          //     : CustomCarousel(
                          //         aspectRatio: 2.5,
                          //         withCards: false,
                          //         showIndicator: false,
                          //         items: [
                          //           for (final offerResponse
                          //               in venueResponse.offers)
                          //             VenueDealCarouselItem(
                          //               offerResponse: offerResponse,
                          //               onRedeem: () =>
                          //                   refreshNotifier.refresh(),
                          //             ),
                          //         ],
                          //       ),
                          const SizedBox(height: 12.0),
                          HorizontallyPaddedTitleText("Loyalty"),
                          const SizedBox(height: 8.0),
                          if (venueResponse.loyalty == null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                    "There is no Loyalty to be displayed."),
                              ),
                            )
                          else if (venueResponse.loyalty != null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: VenueLoyaltyItem(
                                venueLoyaltySummaryResponse:
                                    venueResponse.loyalty!,
                                onRedeem: () => refreshNotifier.refresh(),
                              ),
                            ),
                          const SizedBox(height: 12.0),
                          HorizontallyPaddedTitleText(AppStrings.upcomingEvent),
                          const SizedBox(height: 8.0),
                          (venueResponse.upcomingEvent!.isNotEmpty)
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width * .25,
                                    // width: 100,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          venueResponse.upcomingEvent!.length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return ConstrainedBox(
                                            constraints: BoxConstraints(
                                                // maxHeight: 30,
                                                // minHeight: 20,
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .95),
                                            child: EventCardItem(
                                                eventSummaryResponse:
                                                    venueResponse
                                                        .upcomingEvent![i]));
                                      },
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                        "There are currently no Upcoming Events in this venue."),
                                  ),
                                ),
                          const SizedBox(height: 12.0),
                          VenueGallery(
                            gallery: venueResponse.gallery,
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (venueResponse.facebookLink != null)
                                CustomSocialMediaButton(
                                  url: venueResponse.facebookLink!,
                                  icon: FaIcon(
                                    FontAwesomeIcons.facebookF,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ),
                              if (venueResponse.youtubeLink != null)
                                CustomSocialMediaButton(
                                  url: venueResponse.youtubeLink!,
                                  icon: FaIcon(
                                    FontAwesomeIcons.youtube,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ),
                              if (venueResponse.instagramLink != null)
                                CustomSocialMediaButton(
                                  url: venueResponse.instagramLink!,
                                  icon: FaIcon(
                                    FontAwesomeIcons.instagram,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ),
                              if (venueResponse.webpageLink != null)
                                CustomSocialMediaButton(
                                  url: venueResponse.webpageLink!,
                                  icon: FaIcon(
                                    FontAwesomeIcons.link,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          if (venueResponse.booking == null)
                            ReserveATableButton(
                              venueResponse: venueResponse,
                            ),
                          if (venueResponse.booking != null &&
                              venueResponse.booking!.date
                                  .isAfter(DateTime.now()) &&
                              venueResponse.booking!.status !=
                                  VenueBookingStatus.cancelled &&
                              venueResponse.booking!.status !=
                                  VenueBookingStatus.rejected)
                            SetAReminderButton(
                              refreshNotifier: refreshNotifier,
                              venueBookingSummaryResponse:
                                  venueResponse.booking!,
                            ),
                          if (venueResponse.booking != null &&
                              venueResponse.booking!.date
                                  .isAfter(DateTime.now()) &&
                              venueResponse.booking!.status !=
                                  VenueBookingStatus.cancelled &&
                              venueResponse.booking!.status !=
                                  VenueBookingStatus.rejected)
                            CancelBookingButton(
                              refreshNotifier: refreshNotifier,
                              venueBookingSummaryResponse:
                                  venueResponse.booking!,
                            ),
                        ],
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

class VenueHeader extends StatelessWidget {
  final VenueResponse venueResponse;

  const VenueHeader({
    Key? key,
    required this.venueResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          venueResponse.location.distance.toStringAsFixed(0),
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
                        message: venueResponse.name,
                        child: Text(
                          venueResponse.name,
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
                            "${venueResponse.location.area}, ${venueResponse.location.city.name}",
                        child: Text(
                          "${venueResponse.location.area}, ${venueResponse.location.city.name}",
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
          ShareVenueButton(
            venueId: venueResponse.id,
            venueName: venueResponse.name,
            venueDescription: venueResponse.description,
            venueImageUrl: venueResponse.logo,
          ),
        ],
      ),
    );
  }
}

class VenueCategoriesBar extends StatelessWidget {
  final VenueResponse venueResponse;

  const VenueCategoriesBar({
    Key? key,
    required this.venueResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, left: 16.0, right: 16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 3.0,
        children: [
          for (var item in venueResponse.categories)
            VenueDetailsCategoryChip(categoryResponse: item),
        ],
      ),
    );
  }
}

class VenueDetailsCategoryChip extends StatelessWidget {
  final CategoryResponse categoryResponse;

  const VenueDetailsCategoryChip({
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
        padding: const EdgeInsets.all(3.0),
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
            Container(
              width: categoryResponse.name.length <= 12
                  ? MediaQuery.of(context).size.width * .17
                  : categoryResponse.name.length < 20 &&
                          categoryResponse.name.length > 12
                      ? MediaQuery.of(context).size.width * .24
                      : MediaQuery.of(context).size.width * .55,
              child: Text(
                categoryResponse.name,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

class VenueGallery extends StatelessWidget {
  final List<String> gallery;

  const VenueGallery({
    Key? key,
    required this.gallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (gallery.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HorizontallyPaddedTitleText("Gallery"),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text("There are no Images to be displayed."),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HorizontallyPaddedTitleText("Gallery"),
        const SizedBox(height: 8.0),
        AspectRatio(
          aspectRatio: 3.5,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: gallery.length,
            itemBuilder: (context, index) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width / 2),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: GestureDetector(
                    child: UniversalImage(gallery[index]),
                    onTap: () => Navigation().navToGalleryScreen(
                      context,
                      imagesUris: gallery,
                      initialPage: index,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class VenueTermsAndConditionsScreen extends StatelessWidget {
  final String venueId;

  const VenueTermsAndConditionsScreen({
    Key? key,
    required this.venueId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFlatScaffold(
      showChangeLocation: false,
      title: TitleText("Terms & Conditions"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: CustomFutureBuilder<List<TermsAndConditionsResponse>>(
          initFuture: () async {
            var venueTermsConResult =
                await ApiRepo().venueClient.getTermsAndConditions(venueId);
            return venueTermsConResult.result;
          },
          onSuccess: (context, snapshot) {
            final termsCondResponse = snapshot.data!;
            if (termsCondResponse.isEmpty) {
              return Center(
                child:
                    Text("There are no terms and conditions for this venue."),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int x = 0; x < termsCondResponse.length; x++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 2.5,
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 10.0),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Text(
                            termsCondResponse[x].termCondition,
                            style: GoogleFonts.roboto(
                              color: Color(0xff646464),
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class VenueBookingDetails extends StatelessWidget {
  final VenueBookingSummaryResponse venueBookingSummaryResponse;

  VenueBookingDetails({
    required this.venueBookingSummaryResponse,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizontallyPaddedTitleText("Confirmation Details"),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Status : ${venueBookingSummaryResponse.status.name}",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 8.0),
              Text(
                "Date : ${BookingDateFormat.format(venueBookingSummaryResponse.date)}",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 8.0),
              Text(
                "Number of People : ${venueBookingSummaryResponse.peopleNumber}",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 8.0),
              Text(
                "Time : ${BookingTimeFormat.format(venueBookingSummaryResponse.date)}",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class ReserveATableButton extends StatelessWidget {
  final VenueResponse venueResponse;

  ReserveATableButton({
    required this.venueResponse,
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
          child: ElevatedButton(
            child: Text("Make a Reservation"),
            onPressed: () => Navigation()
                .navToBookVenue(context, venueResponse: venueResponse),
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

class SetAReminderButton extends StatelessWidget {
  final RefreshNotifier refreshNotifier;
  final VenueBookingSummaryResponse venueBookingSummaryResponse;
  final _formKey = GlobalKey<FormBuilderState>();

  SetAReminderButton({
    required this.venueBookingSummaryResponse,
    required this.refreshNotifier,
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
                        initialValue:
                            venueBookingSummaryResponse.remindersTypes,
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
                          final request = new VenueBookingReminderRequest()
                            ..bookingId = venueBookingSummaryResponse.id
                            ..reminderTypes = formState.value["reminders_list"]
                                as List<ReminderType>;
                          return await ApiRepo()
                              .venueClient
                              .setAReminder(request);
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

class CancelBookingButton extends StatelessWidget {
  final RefreshNotifier refreshNotifier;
  final VenueBookingSummaryResponse venueBookingSummaryResponse;

  CancelBookingButton({
    required this.refreshNotifier,
    required this.venueBookingSummaryResponse,
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
            child: Text("Cancel reservation"),
            onPressed: () async {
              await showAdaptiveBottomSheet(
                context: context,
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                    "Are you sure you want to cancel the booking?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                actions: <AdaptiveBottomSheetAction>[
                  AdaptiveBottomSheetAction(
                    title: "Yes",
                    onPressed: () async {
                      var request = await showFutureProgressDialog<
                          BooleanOperationResult>(
                        context: context,
                        initFuture: () async {
                          return await ApiRepo()
                              .venueClient
                              .cancelABooking(venueBookingSummaryResponse.id);
                        },
                      );
                      if (request != null && request.status) {
                        await showAdaptiveAlertDialog(
                          context: context,
                          icon: UniversalImage(IconAssets.done),
                          content: "",
                          title: "Venue Booking canceled successfully.",
                          showCloseButton: false,
                        );
                        refreshNotifier.refresh();
                        context
                            .read<MyAccountProvider>()
                            .venueBookingsRefreshNotifier
                            .refresh();
                      } else {
                        await showAdaptiveErrorDialog(
                          context: context,
                          title: "Error",
                          content: request?.errorMessage ?? "Unknown Error",
                        );
                      }
                      await Navigator.of(context).maybePop();
                    },
                    isPrimary: true,
                  ),
                  AdaptiveBottomSheetAction(
                    title: "No",
                    onPressed: () {
                      Navigator.of(context).maybePop();
                    },
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
