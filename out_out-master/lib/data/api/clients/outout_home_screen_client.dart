import 'package:dio/dio.dart';
import 'package:out_out/data/view_models/home/home_page_filteration_request.dart';
import 'package:out_out/data/view_models/home/home_page_response_operation_result.dart';
import 'package:retrofit/retrofit.dart';

part 'outout_home_screen_client.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class OutOutHomeScreenClient {
  factory OutOutHomeScreenClient(Dio dio, {String baseUrl}) = _OutOutHomeScreenClient;

  @POST("/HomeScreen/HomeSearchFilter")
  Future<HomePageResponseOperationResult> homeSearchFilter(@Body() HomePageFilterationRequest request);
}
