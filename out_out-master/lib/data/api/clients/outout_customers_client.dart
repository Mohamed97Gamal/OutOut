import 'dart:io';
import 'package:dio/dio.dart';
import 'package:out_out/data/view_models/auth/application_user_response_operation_result.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/data/view_models/event/event_summary_response_page_operation_result.dart';
import 'package:out_out/data/view_models/event/search_filteration_request.dart';
import 'package:out_out/data/view_models/event_booking/event_booking_summary_response_page_operation_result.dart';
import 'package:out_out/data/view_models/event_booking/single_event_booking_ticket_summary_response_page_operation_result.dart';
import 'package:out_out/data/view_models/notification/notification_is_read_request.dart';
import 'package:out_out/data/view_models/notification/notification_response_page_operation_result.dart';
import 'package:out_out/data/view_models/update_notifications_allowed_request.dart';
import 'package:out_out/data/view_models/update_reminders_allowed_request.dart';
import 'package:out_out/data/view_models/user_location_request.dart';
import 'package:out_out/data/view_models/venue/favorite_venue_filteration_request.dart';
import 'package:out_out/data/view_models/venue/venue_response_page_operation_result.dart';
import 'package:out_out/data/view_models/venue/venue_summary_response_page_operation_result.dart';
import 'package:out_out/data/view_models/venue_booking/my_booking_filteration_request.dart';
import 'package:out_out/data/view_models/venue_booking/venue_booking_response_page_operation_result.dart';
import 'package:out_out/data/view_models/venue_loyalty/loyalty_filteration_request.dart';
import 'package:out_out/data/view_models/venue_loyalty/loyalty_response_page_operation_result.dart';
import 'package:retrofit/retrofit.dart';

part 'outout_customers_client.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class OutOutCustomersClient {
  factory OutOutCustomersClient(Dio dio, {String baseUrl}) = _OutOutCustomersClient;

  @GET("/Customers/GetAccountInfo")
  Future<ApplicationUserResponseOperationResult> getAccountInfo();

  @POST("/Customers/UpdateAccountInfo")
  Future<ApplicationUserResponseOperationResult> verify();

  @GET("/Customers/GetUserLocation")
  Future<ApplicationUserResponseOperationResult> getUserLocation();

  @POST("/Customers/UpdateUserLocation")
  Future<ApplicationUserResponseOperationResult> updateUserLocation(@Body() UserLocationRequest request);

  @POST("/Customers/UpdateNotificationsAllowed")
  Future<ApplicationUserResponseOperationResult> updateNotificationsAllowed(
    @Body() UpdateNotificationsAllowedRequest request,
  );

  @POST("/Customers/UpdateRemindersAllowed")
  Future<ApplicationUserResponseOperationResult> updateRemindersAllowed(
    @Body() UpdateRemindersAllowedRequest request,
  );

  @POST("/Customers/UpdateAccountInfo")
  Future<ApplicationUserResponseOperationResult> updateAccountInfo({
    @Part(name: "FullName") required String fullName,
    @Part(name: "PhoneNumber") required String phoneNumber,
    @Part(name: "Gender") required int gender,
    @Part(name: "ProfileImage") File? profileImage,
    @Part(name: "RemoveProfileImage") required bool removeProfileImage,
  });

  @POST("/Customers/GetFavoriteVenues")
  Future<VenueSummaryResponsePageOperationResult> getFavoriteVenues(
    @Body() FavoriteVenueFilterationRequest request,
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
  );

  @POST("/Customers/GetMyLoyalty")
  Future<LoyaltyResponsePageOperationResult> getMyLoyalty(
    @Body() LoyaltyFilterationRequest request,
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
  );

  @POST("/Customers/GetFavoriteEvents")
  Future<EventSummaryResponsePageOperationResult> getFavoriteEvents(
    @Body() SearchFilterationRequest request,
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
  );

  @POST("/Customers/GetMyEventBookings")
  Future<EventBookingSummaryResponsePageOperationResult> getMyEventsBookings(
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
    @Body() MyBookingFilterationRequest request,
  );

  @POST("/Customers/GetMyNotifications")
  Future<NotificationResponsePageOperationResult> getMyNotifications(
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
  );
  @POST("/Customers/MarkNotificationsAsRead")
  Future<BooleanOperationResult> markNotificationsAsRead(
      @Query("notificationIds") List<String> notificationIds);
  @POST("/Customers/GetMyVenueBookings")
  Future<VenueBookingResponsePageOperationResult> getMyVenueBookings(
    @Body() MyBookingFilterationRequest request,
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
  );

  @POST("/Customers/GetMyEventSharedTickets")
  Future<SingleEventBookingTicketSummaryResponsePageOperationResult> getMyEventSharedTickets(
    @Body() MyBookingFilterationRequest request,
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
  );
}
