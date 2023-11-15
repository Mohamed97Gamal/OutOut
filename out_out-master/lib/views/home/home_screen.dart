import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/api/geocoding_repo.dart';
import 'package:out_out/data/disk/disk_repo.dart';
import 'package:out_out/data/memory/providers/bottom_navigation_bar_provider.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/models/enums/event_filter.dart';
import 'package:out_out/data/models/enums/type_for.dart';
import 'package:out_out/data/models/enums/venue_time_filter.dart';
import 'package:out_out/data/view_models/category/category_response_list_operation_result.dart';
import 'package:out_out/data/view_models/event/event_filteration_request.dart';
import 'package:out_out/data/view_models/event/event_summary_response.dart';
import 'package:out_out/data/view_models/home/home_page_filteration_request.dart';
import 'package:out_out/data/view_models/notification/notification_navigator.dart';
import 'package:out_out/data/view_models/user_location_request.dart';
import 'package:out_out/data/view_models/venue/venue_filteration_request.dart';
import 'package:out_out/data/view_models/venue/venue_summary_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_filteration_request.dart';
import 'package:out_out/data/view_models/venue_deal/offer_with_venue_response.dart';
import 'package:out_out/navigation/deep_link_navigation.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/utils/constants.dart';
import 'package:out_out/utils/location_utils.dart';
import 'package:out_out/views/event/items/event_near_you_carousel_item.dart';
import 'package:out_out/views/event/items/featured_event_carousel_item.dart';
import 'package:out_out/views/home/home_sheet_filter.dart';
import 'package:out_out/views/venue/items/venue_card_item.dart';
import 'package:out_out/views/venue/screens/venue_details_screen.dart';
import 'package:out_out/views/venue_deal/items/deal_near_you_carousel_item.dart';
import 'package:out_out/widgets/containers/custom_flat_scaffold.dart';
import 'package:out_out/widgets/custom_carousel.dart';
import 'package:out_out/widgets/custom_chip.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool firstTimeopenHome = false;
    NotificationNavigator notificationNavigator = NotificationNavigator();

  @override
  void dispose() {
    firstTimeopenHome = false;

    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    notificationNavigator.appLifecycleStateHandler(state);
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null &&
        notificationNavigator.database!.get("isDetached") == true) {
      _handleMessage(initialMessage);
      notificationNavigator.database!.put("isDetached", false);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation(context).then((locationData) {
      setState(() {
        myLatLng = locationData;
        selectedLatLng=myLatLng??selectedLatLng;
      });
    });
    notificationNavigator.init();
    firstTimeopenHome = true;
    WidgetsBinding.instance.addObserver(this);
    if (context.read<MyAccountProvider>().firstTimeLogin) {
      context.read<MyAccountProvider>().firstTimeLogin = false;
      scheduleMicrotask(() {
        Navigation().navToChangeLocationScreen(context);
      });
    }
    else {
      var myAccountProvider = context.read<MyAccountProvider>();
      final location = myAccountProvider.applicationUserResponse.location;

      selectedName = location.description;

    }

    FirebaseDynamicLinks.instance.onLink.listen(
      (dynamicLink) async {
        final link = dynamicLink.link.toString();
        DeepLinkNavigation.navToLink(context, link: link);
      },
    );
    setupInteractedMessage();
  }

  bool changing = false;
  late String selectedName;
  late LatLng selectedLatLng;
   LatLng? myLatLng;

  // GoogleMapController? mapController;
  @override
  Widget build(BuildContext context) {
    final userId = context.read<MyAccountProvider>().applicationUserResponse.id;
    FirebaseCrashlytics.instance.setUserIdentifier(userId);

    return Refreshable(
      refreshNotifier: context.read<MyAccountProvider>().refreshNotifier,
      child: CustomFlatScaffold(
        onSearchFieldSubmitted: (value) {
          final request = new HomePageFilterationRequest()..searchQuery = value;
          Navigation().navToSearchFilterScreen(
            context,
            dateTime: request.from ?? DateTime.now(),
            homePageFilterationRequest: request,
          );
        },
        showBackButton: false,
        searchFieldText: "Search for Venues and Events",
        onFilterPressed: () async {
          await showFilterBottomSheet(context);
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText("Events Categories"),
                  TextButton(
                    child: Text("View All"),
                    onPressed: () =>
                        Navigation().navToEventsCategoriesScreen(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 30.0,
              child: CustomFutureBuilder<CategoryResponseListOperationResult>(
                initFuture: () => ApiRepo()
                    .categoryClient
                    .getActiveCategories(TypeFor.event.value),
                onSuccess: (context, snapshot) {
                  final result = snapshot.data?.result ?? [];
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: result.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8.0),
                    itemBuilder: (context, index) {
                      final item = result[index];
                      return CustomChip(
                        label: Text(item.name),
                        avatar: UniversalImage.category(
                          item.icon,
                          selected: false,
                        ),
                        selected: false,
                        onSelected: (newSelected) {
                          Navigation().navToEventsScreen(
                            context,
                            initialFilterCategoriesIds: [item.id],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText(AppStrings.venueCategories),
                  TextButton(
                    child: Text("View All"),
                    onPressed: () =>
                        Navigation().navToVenuesCategoriesScreen(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 30.0,
              child: CustomFutureBuilder<CategoryResponseListOperationResult>(
                initFuture: () => ApiRepo()
                    .categoryClient
                    .getActiveCategories(TypeFor.venue.value),
                onSuccess: (context, snapshot) {
                  final result = snapshot.data?.result ?? [];
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: result.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8.0),
                    itemBuilder: (context, index) {
                      final item = result[index];
                      return CustomChip(
                        label: Text(item.name),
                        avatar: UniversalImage.category(
                          item.icon,
                          selected: false,
                        ),
                        selected: false,
                        onSelected: (newSelected) {
                          Navigation().navToVenuesScreen(
                            context,
                            initialFilterCategoriesIds: [item.id],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText("Deals Near You"),
                  TextButton(
                    child: Text("All Deals"),
                    onPressed: () {
                      Navigation().navToAllDealsScreen(context);
                    },
                  ),
                ],
              ),
            ),
            CustomFutureBuilder<List<OfferWithVenueResponse>>(
              initFuture: () async {
                final request = new OfferFilterationRequest();
                final offerResults = await ApiRepo()
                    .offerClient
                    .getActiveNonExpiredOffers(request, 0, 5);
                return offerResults.result.records;
              },
              onSuccess: (context, snapshot) {
                final result = snapshot.data!;
                if (result.isEmpty) {
                  return Center(
                    child: Text("There are no deals near you."),
                  );
                }
                return CustomCarousel(
                  aspectRatio: 2.5,
                  borderRadius: 10.0,
                  showIndicator: false,
                  items: [
                    for (final offerWithVenueResponse in result)
                      DealNearYouCarouselItem(
                          offerWithVenueResponse: offerWithVenueResponse),
                  ],
                );
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: TitleText("Featured Events"),
            ),
            CustomFutureBuilder<List<EventSummaryResponse>>(
              initFuture: () async {
                final request = new EventFilterationRequest()
                  ..searchQuery = ""
                  ..eventFilter = EventFilter.featuredEvents;
                var eventsResult = await ApiRepo()
                    .eventClient
                    .getEvents(request, 0, 2147483647);
                return eventsResult.result.records;
              },
              onSuccess: (context, snapshot) {
                final result = snapshot.data!;
                if (result.isEmpty) {
                  return Center(
                    child: Text("There are no featured events."),
                  );
                }
                return CustomCarousel(
                  aspectRatio: 2.5,
                  borderRadius: 10.0,
                  showIndicator: true,
                  items: [
                    if (result.length >= 5)
                      for (var i = 0; i < 5; i++)
                        FeaturedEventCarouselItem(
                            eventSummaryResponse: result[i])
                    else
                      for (EventSummaryResponse eventSummaryResponse in result)
                        FeaturedEventCarouselItem(
                            eventSummaryResponse: eventSummaryResponse),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText("Venues Near You"),
                  TextButton(
                    child: Text("All Venues"),
                    onPressed: () => Navigation().navToVenuesScreen(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomFutureBuilder<List<VenueSummaryResponse>>(
                initFuture: () async {
                  final request = new VenueFilterationRequest()
                    ..searchQuery = ""
                    ..timeFilter = VenueTimeFilter.near_you;
                  var venuesResult =
                      await ApiRepo().venueClient.getVenues(request, 0, 5);
                  return venuesResult.result.records;
                },
                onSuccess: (context, snapshot) {
                  final result = snapshot.data!;
                  if (result.isEmpty) {
                    return Center(
                      child: Text("There are no venues near you."),
                    );
                  }
                  return Column(
                    children: [
                      for (final venueSummaryResponse in result)
                        VenueCardItem(
                            venueSummaryResponse: venueSummaryResponse),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText("Events Near You"),
                  TextButton(
                    child: Text("All Events"),
                    onPressed: () {
                      Navigation().navToEventsScreen(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            CustomFutureBuilder<List<EventSummaryResponse>>(
                initFuture: () async {
              final request = new EventFilterationRequest()
                ..searchQuery = ""
                ..eventFilter = EventFilter.nearYou;
              var eventsResult =
                  await ApiRepo().eventClient.getEvents(request, 0, 5);
              if (this.mounted && firstTimeopenHome) {
                await _handleCurrentLocation(context);
                firstTimeopenHome = false;
              }
              return eventsResult.result.records;
            }, onSuccess: (context, snapshot) {
              final result = snapshot.data!;
              if (result.isEmpty) {
                return Center(
                  child: Text("There are no events near you."),
                );
              }
              return CustomCarousel(
                aspectRatio: 2.5,
                borderRadius: 10.0,
                showIndicator: false,
                items: [
                  for (var eventSummaryResponse in result)
                    EventNearYouCarouselItem(
                        eventSummaryResponse: eventSummaryResponse),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  _handleCurrentLocation(BuildContext context) async {
    if (changing) return;
    changing = true;
    try {
      LatLng? latlng;
      latlng = await getCurrentLocation(
        context,
        locationAccuracy: LocationAccuracy.high,
      );
      if (latlng == null) return null;

      var addressNameFuture =
          GeoCodingRepo().getAddressName(latlng.latitude, latlng.longitude);

      await Future.wait(
        [
          addressNameFuture,
          Future.delayed(Duration(milliseconds: 600)),
        ],
      );
      final String? addressName = await addressNameFuture;
      if (latlng == null) {
        return;
      }

      if (addressName == null) {
        await showAdaptiveErrorDialog(
          context: context,
          title: "Unsupported Location",
          content: "Please select a location in 'United Arab Emirates'.",
        );
        return;
      } else {
        var myAccountProvider = context.read<MyAccountProvider>();
        selectedName=addressName;
        final request = new UserLocationRequest()
          ..latitude = selectedLatLng.latitude
          ..longitude = selectedLatLng.longitude
          ..description = selectedName;
        var userInfoResult =
            await ApiRepo().customersClient.updateUserLocation(request);
        if (userInfoResult != null && userInfoResult.status) {
          myAccountProvider.update(userInfoResult.result);
        }
      }

      selectedName = addressName;
      selectedLatLng = latlng;
    } finally {
      changing = false;
    }
  }

  Future<void> _handleMessage(RemoteMessage message) async {
    final notificationAction = int.parse(message.data["payload"]);
    String id = message.data["payload_parameter"];
    notificationNavigator.navigationHandler(id, notificationAction, context);
  }
}
