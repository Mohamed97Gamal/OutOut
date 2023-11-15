import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'outout_payment_client.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class OutOutPaymentClient {
  factory OutOutPaymentClient(Dio dio, {String baseUrl}) = _OutOutPaymentClient;

  @GET("/Payment/Paid")
  Future<String> paid(
    @Query("id") String id,
  );

  @GET("/Payment/Cancelled")
  Future<String> cancelled(
    @Query("id") String id,
  );

  @GET("/Payment/Declined")
  Future<String> declined(
    @Query("id") String id,
  );
}
