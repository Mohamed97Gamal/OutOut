// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outout_category_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OutOutCategoryClient implements OutOutCategoryClient {
  _OutOutCategoryClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CategoryResponseListOperationResult> getActiveCategories(
      typeFor) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'TypeFor': typeFor};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CategoryResponseListOperationResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Category/GetActiveCategories',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CategoryResponseListOperationResult.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
