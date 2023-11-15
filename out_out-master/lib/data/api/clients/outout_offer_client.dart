import 'package:dio/dio.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/data/view_models/notification/activated_offer.dart';
import 'package:out_out/data/view_models/venue_deal/offer_filteration_request.dart';
import 'package:out_out/data/view_models/venue_deal/offer_response_page_operation_result.dart';
import 'package:out_out/data/view_models/venue_deal/offer_type_summary_response_list_operation_result.dart';
import 'package:out_out/data/view_models/venue_deal/offer_with_venue_response_page_operation_result.dart';
import 'package:retrofit/retrofit.dart';

part 'outout_offer_client.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class OutOutOfferClient {
  factory OutOutOfferClient(Dio dio, {String baseUrl}) = _OutOutOfferClient;

  @GET("/Offer/GetOfferTypes")
  Future<OfferTypeSumamryResponseListOperationResult> getOfferTypes();

  @GET("/Offer/IsOfferExpired")
  Future<ActivatedOffer> isExpiredOffer(@Query("offerId") String offerId);

  @POST("/Offer/GetActiveNonExpiredOffers")
  Future<OfferWithVenueResponsePageOperationResult> getActiveNonExpiredOffers(
    @Body() OfferFilterationRequest request,
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
  );

    @POST("/Offer/GetActiveNonExpiredUpcomingOffers")
  Future<OfferWithVenueResponsePageOperationResult>
      getActiveNonExpiredUpcomingOffers(
    @Body() OfferFilterationRequest request,
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
  );

  @POST("/Offer/GetMyOffers")
  Future<OfferResponsePageOperationResult> getAllUpcomingOffers(
    @Body() OfferFilterationRequest request,
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
  );


  @POST("/Offer/RedeemOffer")
  Future<BooleanOperationResult> redeemOffer(
    @Query("offerId") String offerId,
    @Query("pinCode") String pinCode,
  );
}
