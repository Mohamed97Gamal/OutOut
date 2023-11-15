import 'package:dio/dio.dart';
import 'package:out_out/data/view_models/faq/faq_filteration_request.dart';
import 'package:out_out/data/view_models/faq/faq_response_page_operation_result.dart';
import 'package:retrofit/retrofit.dart';

part 'outout_faq_client.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class OutOutFAQClient {
  factory OutOutFAQClient(Dio dio, {String baseUrl}) = _OutOutFAQClient;

  @POST("/FAQ/GetAllFAQ")
  Future<FAQResponsePageOperationResult> getAllFAQ(
    @Body() FAQFilterationRequest request,
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
  );
}
