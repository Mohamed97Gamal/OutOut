import 'package:dio/dio.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/data/view_models/venue/terms_and_conditions_response_list_operation_result.dart';
import 'package:out_out/data/view_models/venue/venue_filteration_request.dart';
import 'package:out_out/data/view_models/venue/venue_response_operation_result.dart';
import 'package:out_out/data/view_models/venue/venue_summary_response_page_operation_result.dart';
import 'package:out_out/data/view_models/venue_booking/venue_booking_reminder_request.dart';
import 'package:out_out/data/view_models/venue_booking/venue_booking_request.dart';
import 'package:out_out/data/view_models/venue_booking/venue_booking_response_operation_result.dart';
import 'package:retrofit/retrofit.dart';

part 'outout_venue_client.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class OutOutVenueClient {
  factory OutOutVenueClient(Dio dio, {String baseUrl}) = _OutOutVenueClient;

  @POST("/Venue/GetVenues")
  Future<VenueSummaryResponsePageOperationResult> getVenues(
    @Body() VenueFilterationRequest request,
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
  );

  @GET("/Venue/GetVenueDetails")
  Future<VenueResponseOperationResult> getVenueDetails(@Query("venueId") String venueId);

  @GET("/Venue/GetVenueTermsAndConditions")
  Future<TermsAndConditionsResponseListOperationResult> getTermsAndConditions(@Query("venueId") String venueId);

  @POST("/Venue/FavoriteVenue")
  Future<BooleanOperationResult> favoriteVenue(@Query("venueId") String venueId);

  @POST("/Venue/UnfavoriteVenue")
  Future<BooleanOperationResult> unFavoriteVenue(@Query("venueId") String venueId);

  @POST("/VenueBooking/MakeABooking")
  Future<VenueBookingResponseOperationResult> makeABooking(@Body() VenueBookingRequest request);

  @GET("/VenueBooking/GetBookingDetails")
  Future<VenueResponseOperationResult> getBookingDetails(@Query("bookingId") String venueBookingId);

  @POST("/VenueBooking/CancelABooking")
  Future<BooleanOperationResult> cancelABooking(@Query("bookingId") String venueBookingId);

  @POST("/VenueBooking/SetBookingReminder")
  Future<BooleanOperationResult> setAReminder(@Body() VenueBookingReminderRequest request);
}
