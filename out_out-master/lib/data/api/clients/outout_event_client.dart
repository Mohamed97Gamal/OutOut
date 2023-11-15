import 'package:dio/dio.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/data/view_models/basic/string_operation_result.dart';
import 'package:out_out/data/view_models/event/event_booking_request.dart';
import 'package:out_out/data/view_models/event/event_filteration_request.dart';
import 'package:out_out/data/view_models/event/event_summary_response_page_operation_result.dart';
import 'package:out_out/data/view_models/event/single_event_occurrence_response_operation_result.dart';
import 'package:out_out/data/view_models/event_booking/booking_reminder_request.dart';
import 'package:out_out/data/view_models/event_booking/event_booking_summary_response_operation_result.dart';
import 'package:out_out/data/view_models/event_booking/share_ticket_request.dart';
import 'package:out_out/data/view_models/event_booking/telr_booking_response_operation_result.dart';
import 'package:out_out/data/view_models/event_booking/ticket_redemption_request.dart';
import 'package:retrofit/retrofit.dart';

part 'outout_event_client.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class OutOutEventClient {
  factory OutOutEventClient(Dio dio, {String baseUrl}) = _OutOutEventClient;

  @POST("/Event/GetEvents")
  Future<EventSummaryResponsePageOperationResult> getEvents(
    @Body() EventFilterationRequest request,
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
  );

  @GET("/Event/GetEventDetails")
  Future<SingleEventOccurrenceResponseOperationResult> getEventDetails(
    @Query("eventOccurrenceId") String eventOccurrenceId,
  );

  @POST("/Event/FavoriteEvent")
  Future<BooleanOperationResult> favoriteEvent(@Query("eventOccurrenceId") String eventOccurrenceId);

  @POST("/Event/UnfavoriteEvent")
  Future<BooleanOperationResult> unFavoriteEvent(@Query("eventOccurrenceId") String eventOccurrenceId);

  @POST("/EventBooking/MakeATelrBooking")
  Future<TelrBookingResponseOperationResult> makeATelrBooking(@Body() EventBookingRequest request);

  @POST("/EventBooking/CheckTelrPaymentStatus")
  Future<StringOperationResult> checkTelrPaymentStatus(
    @Body() EventBookingRequest request,
    @Query("eventBookingId") String eventBookingId,
    @Query("paymentToken") String paymentToken,
  );

  @POST("/EventBooking/BookingConfirmation")
  Future<EventBookingSummaryResponseOperationResult> bookingConfirmation(
      @Query("eventBookingId") String eventBookingId);

  @POST("/EventBooking/SetBookingReminder")
  Future<BooleanOperationResult> setBookingReminder(@Body() BookingReminderRequest request);

  @POST("/EventBooking/RedeemTicket")
  Future<BooleanOperationResult> redeemTicket(@Body() TicketRedemptionRequest request);

  @GET("/EventBooking/GetBookingDetails")
  Future<SingleEventOccurrenceResponseOperationResult> getBookingDetails(
      @Query("eventBookingId") String eventBookingId);

  @POST("/EventBooking/AbortPayment")
  Future AbortPayment(@Query("eventBookingId") String eventBookingId);

  @GET("/EventBooking/GetSharedTicketDetails")
  Future<SingleEventOccurrenceResponseOperationResult> getSharedTicketDetails(@Query("ticketId") String ticketId);

  @POST("/EventBooking/AddToSharedTickets")
  Future<BooleanOperationResult> addToSharedTickets(@Body() ShareTicketRequest request);

  @POST("/EventBooking/SetSharedBookingReminder")
  Future<BooleanOperationResult> setSharedBookingReminder(@Body() BookingReminderRequest request);

  @POST("/EventBooking/IsTicketShareable")
  Future<BooleanOperationResult> isTicketShareable(@Body() ShareTicketRequest request);
}
