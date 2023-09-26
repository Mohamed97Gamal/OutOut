import 'package:dio/dio.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/utils/common.dart';

BaseAPIResponse getErrorResponse(dynamic e) {
  if (e is DioError) {
    try {
      return BaseAPIResponse.fromJson(e.response!.data);
    } catch (_) {}
  }
  printIfDebug(e.toString());
  return BaseAPIResponse(status: false);
}
