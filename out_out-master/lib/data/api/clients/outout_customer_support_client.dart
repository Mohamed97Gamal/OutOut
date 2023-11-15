import 'package:dio/dio.dart';
import 'package:out_out/data/view_models/profile/customer_support_request.dart';
import 'package:out_out/data/view_models/profile/customer_support_response_operation_result.dart';
import 'package:retrofit/retrofit.dart';

part 'outout_customer_support_client.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class OutOutCustomerSupportClient {
  factory OutOutCustomerSupportClient(Dio dio, {String baseUrl}) = _OutOutCustomerSupportClient;

  @POST("/CustomerSupport/PostNewRequest")
  Future<CustomerSupportResponseOperationResult> postNewRequest(@Body() CustomerSupportRequest request);
}
