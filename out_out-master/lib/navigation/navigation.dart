import 'package:flutter/material.dart';
import 'package:out_out/data/memory/providers/bottom_navigation_bar_provider.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/data/models/enums/payment_status.dart';
import 'package:out_out/data/view_models/event/single_event_occurrence_response.dart';
import 'package:out_out/data/view_models/event_booking/ticket_response.dart';
import 'package:out_out/data/view_models/home/home_page_filteration_request.dart';
import 'package:out_out/data/view_models/venue/venue_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_response.dart';
import 'package:out_out/navigation/deep_link_navigation.dart';
import 'package:out_out/views/auth/forget_password/forget_password_screen.dart';
import 'package:out_out/views/auth/forget_password/reset_password_screen.dart';
import 'package:out_out/views/auth/forget_password/verify_reset_password_screen.dart';
import 'package:out_out/views/auth/login_screen.dart';
import 'package:out_out/views/auth/register/register_screen.dart';
import 'package:out_out/views/auth/register/set_password_screen.dart';
import 'package:out_out/views/auth/register/terms_and_conditions_screen.dart';
import 'package:out_out/views/auth/register/verify_screen.dart';
import 'package:out_out/views/auth/splash_screen.dart';
import 'package:out_out/views/common/full_image_screen.dart';
import 'package:out_out/views/common/gallery_screen.dart';
import 'package:out_out/views/event/screens/event_details_screen.dart';
import 'package:out_out/views/event/screens/events_categories_screen.dart';
import 'package:out_out/views/event/screens/events_screen.dart';
import 'package:out_out/views/event_booking/screens/make_a_booking_event_screen.dart';
import 'package:out_out/views/event_booking/screens/payment_screen.dart';
import 'package:out_out/views/event_booking/screens/ticket_redeem_screen.dart';
import 'package:out_out/views/event_booking/screens/tickets_screen.dart';
import 'package:out_out/views/home/change_location_screen.dart';
import 'package:out_out/views/home/home_screen.dart';
import 'package:out_out/views/home/notifications_screen.dart';
import 'package:out_out/views/home/search_filter_results_screen.dart';
import 'package:out_out/views/event_booking/screens/telr_payment_screen.dart';
import 'package:out_out/views/profile/account/edit_my_account_screen.dart';
import 'package:out_out/views/profile/account/my_account_screen.dart';
import 'package:out_out/views/profile/booking/my_bookings_screen.dart';
import 'package:out_out/views/profile/change_password_screen.dart';
import 'package:out_out/views/profile/customer_service_screen.dart';
import 'package:out_out/views/profile/faq_screen.dart';
import 'package:out_out/views/profile/my_favourites_screen.dart';
import 'package:out_out/views/profile/my_loyalty_screen.dart';
import 'package:out_out/views/profile/my_profile_screen.dart';
import 'package:out_out/views/profile/my_shared_tickets/screens/my_event_shared_tickets_screen.dart';
import 'package:out_out/views/profile/offers/my_offers_screen.dart';
import 'package:out_out/views/profile/settings_screen.dart';
import 'package:out_out/views/venue/screens/venue_details_screen.dart';
import 'package:out_out/views/venue/screens/venues_categories_screen.dart';
import 'package:out_out/views/venue/screens/venues_screen.dart';
import 'package:out_out/views/venue_booking/screens/make_a_booking_venue_screen.dart';
import 'package:out_out/views/venue_deal/screens/all_deals_screen.dart';
import 'package:out_out/views/venue_deal/screens/redeem_venue_deal_screen.dart';
import 'package:out_out/views/venue_loyalty/pages/my_loyalty_history_page.dart';
import 'package:out_out/views/venue_loyalty/pages/my_loyalty_recent_page.dart';
import 'package:out_out/views/venue_loyalty/screens/redeem_venue_loyalty_screen.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:provider/provider.dart';

class Navigation {
  static final Navigation _singleton = Navigation._internal();

  factory Navigation() {
    return _singleton;
  }

  Navigation._internal();

  Future navToSplashScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().clearAndHide();
    context.read<SearchProvider>().stack();
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => SplashScreen(),
      ),
      (route) => false,
    );
  }

  Future navToLoginScreen(BuildContext context,
      {String? initialEmail, String? initialPassword}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().clearAndHide();
    context.read<SearchProvider>().stack();
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LoginScreen(
          initialEmail: initialEmail,
          initialPassword: initialPassword,
        ),
      ),
      (route) => false,
    );
  }

  Future navToRegisterScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().clearAndHide();
    context.read<SearchProvider>().stack();
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
      (route) => false,
    );
  }

  Future navToTermsAndConditionsScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().hide();
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TermsAndConditionsScreen(),
      ),
    );
  }

  Future navToVerifyScreen(BuildContext context,
      {required String email}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().hide();
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerifyScreen(email: email),
      ),
    );
  }

  Future navToForgetPasswordScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().hide();
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ForgetPasswordScreen(),
      ),
    );
  }

  Future navToVerifyResetPasswordScreen(BuildContext context,
      {required String email}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().hide();
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerifyResetPasswordScreen(email: email),
      ),
    );
  }

  Future navToResetPasswordScreen(BuildContext context,
      {required String email, required String hashedOtp}) async {
    FocusScope.of(context).unfocus();
    //context.read<BottomNavigationBarProvider>().hide();
    //context.read<SearchProvider>().stack();
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            ResetPasswordScreen(email: email, hashedOtp: hashedOtp),
      ),
    );
  }

  Future navToSetPasswordScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().hide();
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPasswordScreen(),
      ),
    );
  }

  Future navToHomeScreen(BuildContext context,
      {bool notificationNavigation = false}) async {
    FocusScope.of(context).unfocus();
    context
        .read<BottomNavigationBarProvider>()
        .clearAndSelect(NavigationItem.Home);
    context.read<SearchProvider>().stack();
    Future<dynamic> future;
    if (notificationNavigation)
      future = await notificationNavigationScreen(context, HomeScreen());
    else
      future = Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
      (route) => false,
    );
    if (DeepLinkNavigation.initialLink != null) {
      DeepLinkNavigation.navToLink(context,
          link: DeepLinkNavigation.initialLink!);
      DeepLinkNavigation.initialLink = null;
    }
    await future;
  }

  Future navToTabsViewScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Profile);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyBookingsScreen(),
      ),
    );
  }
  Future navToMyOffersScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Profile);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyOffersHistoryScreen(),
      ),
    );
  }

  Future navToSettingsScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Profile);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingsScreen(),
      ),
    );
  }

  Future navToFAQScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Profile);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FAQScreen(),
      ),
    );
  }

  Future navToChangePasswordScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Profile);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangePasswordScreen(),
      ),
    );
  }

  Future navToNotificationsScreen(BuildContext context,
      {bool notificationNavigation = false}) async {
    FocusScope.of(context).unfocus();
    context
        .read<BottomNavigationBarProvider>()
        .select(NavigationItem.Notifications);
    context.read<SearchProvider>().stack();
     if (notificationNavigation)
      await notificationNavigationScreen(context, NotificationsScreen());
    else
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NotificationsScreen(),
      ),
    );
  }

  Future navToChangeLocationScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().hide();
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangeLocationScreen(),
      ),
    );
  }

  Future navToMyProfileScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Profile);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyProfileScreen(),
      ),
    );
  }

  Future navToMyAccountScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Profile);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyAccountScreen(),
      ),
    );
  }

  Future navToEventDetailsScreen(BuildContext context,
      {required String occurrenceId,
      bool notificationNavigation = false}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Events);
    context.read<SearchProvider>().stack();
     if (notificationNavigation)
      await notificationNavigationScreen(
          context, EventDetailsScreen(occurrenceId: occurrenceId));
    else
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EventDetailsScreen(occurrenceId: occurrenceId),
      ),
    );
  }

  Future navToEventBookingDetailsScreen(BuildContext context,
      {required String eventBookingId,
      bool notificationNavigation = false}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Events);
    context.read<SearchProvider>().stack();
      if (notificationNavigation)
      await notificationNavigationScreen(
          context, EventDetailsScreen(eventBookingId: eventBookingId));
    else
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            EventDetailsScreen(eventBookingId: eventBookingId),
      ),
    );
  }

  Future navToVenueDetailsScreen(BuildContext context,
      {required String venueId, bool notificationNavigation = false}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Venues);
    context.read<SearchProvider>().stack();
      if (notificationNavigation)
      await notificationNavigationScreen(
          context, VenueDetailsScreen(venueId: venueId));
    else
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VenueDetailsScreen(venueId: venueId),
      ),
    );
  }

  Future navToVenueBookingDetailsScreen(BuildContext context,
      {required String venueBookingId,
      bool notificationNavigation = false}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Venues);
    context.read<SearchProvider>().stack();
    if (notificationNavigation)
      await notificationNavigationScreen(
          context, VenueDetailsScreen(venueBookingId: venueBookingId));
    else
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              VenueDetailsScreen(venueBookingId: venueBookingId),
        ),
      );
  }

  Future navToBookEvent(BuildContext context,
      {required SingleEventOccurrenceResponse
          singleEventOccurrenceResponse}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Events);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MakeABookingEventScreen(
          singleEventOccurrenceResponse: singleEventOccurrenceResponse,
        ),
      ),
    );
  }

  Future navToBookVenue(BuildContext context,
      {required VenueResponse venueResponse}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Venues);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            MakeABookingVenueScreen(venueResponse: venueResponse),
      ),
    );
  }

  Future navToPaymentScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Events);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentScreen(),
      ),
    );
  }

  // Future navToBookingEventConfirmationScreen(BuildContext context,
  //     {required SingleEventOccurrenceResponse singleEventOccurrenceResponse}) async {
  //   FocusScope.of(context).unfocus();
  //   context.read<BottomNavigationBarProvider>().select(NavigationItem.Events);
  //   context.read<SearchProvider>().stack();
  //   await Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) =>
  //           EventBookingConfirmationScreen(singleEventOccurrenceResponse: singleEventOccurrenceResponse),
  //     ),
  //   );
  // }

  Future navToTicketsScreen(
    BuildContext context, {
      String? ticketIdFromShared,
      String? ticketId,
      required RefreshNotifier eventDetailsRefreshNotifier,
    required SingleEventOccurrenceResponse singleEventOccurrenceResponse,
    required int carouselSliderIndex,
  }) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Events);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TicketsScreen(
          eventDetailsRefreshNotifier: eventDetailsRefreshNotifier,
          singleEventOccurrenceResponse: singleEventOccurrenceResponse,
          ticketIdFromShared:ticketIdFromShared,
          ticketId:ticketId,
          initialCarouselSliderIndex: carouselSliderIndex,
        ),
      ),
    );
  }

  Future navToEventsCategoriesScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Events);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EventsCategoriesScreen(),
      ),
    );
  }

  Future navToVenuesCategoriesScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Venues);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VenuesCategoriesScreen(),
      ),
    );
  }

  Future navToEditMyProfileScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Profile);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditMyAccountScreen(),
      ),
    );
  }

  Future navToCustomerServiceScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Profile);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CustomerServiceScreen(),
      ),
    );
  }

  Future navToEventsScreen(BuildContext context,
      {List<String>? initialFilterCategoriesIds}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Events);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EventsScreen(
            initialFilterCategoriesIds: initialFilterCategoriesIds),
      ),
    );
  }

  Future navToVenuesScreen(BuildContext context,
      {List<String>? initialFilterCategoriesIds}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Venues);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VenuesScreen(
            initialFilterCategoriesIds: initialFilterCategoriesIds),
      ),
    );
  }

  Future navToMyFavouritesScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Profile);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyFavouritesScreen(),
      ),
    );
  }

  Future navToMyEventSharedTicketsScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Profile);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyEventSharedTicketsScreen(),
      ),
    );
  }

  Future navToMyLoyaltyScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Profile);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyLoyaltyScreen(
          items: [
            MyLoyaltyRecentPage(),
            MyLoyaltyHistoryPage(),
          ],
        ),
      ),
    );
  }

  Future navToVenueTermsScreen(BuildContext context,
      {required String venueId}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Venues);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VenueTermsAndConditionsScreen(venueId: venueId),
      ),
    );
  }

  Future navToReceiveSharedTicketScreen(BuildContext context,
      {required String ticketId, required String secret}) async {
    FocusScope.of(context).unfocus();
    // context.read<BottomNavigationBarProvider>().hide();
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EventDetailsScreen(
          ticketId: ticketId,
          secret: secret,
        ),
      ),
    );
  }

  Future navToEventDetailsScreenFromMySharedTickets(BuildContext context,
      {required String ticketId, required String secret}) async {
    FocusScope.of(context).unfocus();
    // context.read<BottomNavigationBarProvider>().hide();
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EventDetailsScreen(
          ticketIdFromShared: ticketId,
          secretFromShared: secret,
        ),
      ),
    );
  }

  Future navToFullImageScreen(BuildContext context,
      {required String imageUri}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().hide();
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullImageScreen(imageUri),
      ),
    );
  }

  Future navToAllDealsScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Venues);
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AllDealsScreen(),
      ),
    );
  }

  Future<bool> navToRedeemVenueLoyaltyScreen(
    BuildContext context, {
    required String loyaltyVenueId,
  }) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Venues);
    context.read<SearchProvider>().stack();
    return await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                RedeemVenueLoyaltyScreen(loyaltyVenueId: loyaltyVenueId),
          ),
        ) ??
        false;
  }

  Future<bool> navToRedeemVenueDealScreen(BuildContext context,
      {required OfferResponse offerResponse}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Venues);
    context.read<SearchProvider>().stack();
    return await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                RedeemVenueDealScreen(offerResponse: offerResponse),
          ),
        ) ??
        false;
  }

  Future<bool> navToTicketRedeemScreen(BuildContext context,
      {required TicketResponse ticketResponse, required RefreshNotifier refreshNotifier}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Events);
    context.read<SearchProvider>().stack();
    return await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                TicketRedeemScreen(ticketResponse: ticketResponse,refreshNotifier: refreshNotifier,),
          ),
        ) ??
        false;
  }

  Future navToGalleryScreen(
    BuildContext context, {
    required List<String> imagesUris,
    required int initialPage,
  }) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().hide();
    context.read<SearchProvider>().stack();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GalleryScreen(
          imagesUris,
          initialPage: initialPage,
        ),
      ),
    );
  }

  Future navToSearchFilterScreen(
    BuildContext context, {
    required HomePageFilterationRequest homePageFilterationRequest,
    required DateTime dateTime,
  }) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().select(NavigationItem.Home);
    context.read<SearchProvider>().controller.text = "";
    context.read<SearchProvider>().stack();
    context.read<SearchProvider>().controller.text =
        homePageFilterationRequest.searchQuery ?? "";
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchFilterResultScreen(
            homePageFilterationRequest: homePageFilterationRequest,
            dateTime: dateTime),
      ),
    );
  }

  Future<PaymentStatus> navToTelrPaymentScreen(BuildContext context,
      {required String url, required String bookingId}) async {
    FocusScope.of(context).unfocus();
    context.read<BottomNavigationBarProvider>().hide();
    context.read<SearchProvider>().stack();
    return await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                TelrPaymentScreen(url: url, bookingId: bookingId),
          ),
        ) ??
        PaymentStatus.cancelled;
  }

  Future notificationNavigationScreen(
      BuildContext context, Widget screen) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
