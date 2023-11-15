import 'package:dio/dio.dart';
import 'package:out_out/data/view_models/venue_loyalty/loyalty_response_operation_result.dart';
import 'package:out_out/data/view_models/venue_loyalty/user_loyalty_request.dart';
import 'package:retrofit/retrofit.dart';

part 'outout_loyalty_client.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class OutOutLoyaltyClient {
  factory OutOutLoyaltyClient(Dio dio, {String baseUrl}) = _OutOutLoyaltyClient;

  @POST("/Loyalty/ApplyLoyalty")
  Future<LoyaltyResponseOperationResult> applyLoyalty(@Body() UserLoyaltyRequest request);
}
