import 'package:dio/dio.dart';
import 'package:out_out/data/view_models/base/operation_result.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final data = err.response?.data;
    if (data == null) {
      if (err.type == DioErrorType.connectionTimeout ||
          err.type == DioErrorType.sendTimeout ||
          err.type == DioErrorType.receiveTimeout ||err.type == DioErrorType.unknown) {
        final networkOperationResult = new OperationResult()
          ..status = false
          ..errorCode=0
          ..errors=<String>[]
          ..errorMessage = "Network error please check your internet connection";
        final networkErrorResponse = Response(
          requestOptions: err.requestOptions,
          data: networkOperationResult.toJson(),
          statusCode: 200,
        );
        return handler.resolve(networkErrorResponse);
      }
      return handler.next(err);
    }
    if (err.response != null && err.response!.data is Map<String, dynamic>) {
      final operationResult = OperationResult.fromJson(err.response!.data);
      //print("Operation Result Error Message: " + operationResult.errorMessage!);
      var response = Response(
        requestOptions: err.requestOptions,
        data: operationResult.toJson(),
        statusCode: 200,
      );
      return handler.resolve(response);
    }

    return handler.next(err);
  }
}
