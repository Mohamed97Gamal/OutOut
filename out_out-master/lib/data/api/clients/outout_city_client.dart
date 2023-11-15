import 'package:dio/dio.dart';
import 'package:out_out/data/view_models/city/city_response_list_operation_result.dart';
import 'package:out_out/data/view_models/city/city_response_operation_result.dart';
import 'package:retrofit/retrofit.dart';

part 'outout_city_client.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class OutOutCityClient {
  factory OutOutCityClient(Dio dio, {String baseUrl}) = _OutOutCityClient;

  @GET("/City/GetCity")
  Future<CityResponseOperationResult> getCity(@Query("cityId") String cityId);

  @GET("/City/GetAllCities")
  Future<CityResponseListOperationResult> getAllCities();

  @GET("/City/GetActiveCities")
  Future<CityResponseListOperationResult> getActiveCities();
}
