import 'package:dio/dio.dart';
import 'package:out_out/data/view_models/category/category_response_list_operation_result.dart';
import 'package:retrofit/retrofit.dart';

part 'outout_category_client.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class OutOutCategoryClient {
  factory OutOutCategoryClient(Dio dio, {String baseUrl}) = _OutOutCategoryClient;

  @GET("/Category/GetActiveCategories")
  Future<CategoryResponseListOperationResult> getActiveCategories(
    @Query("TypeFor") int typeFor,
  );
}
