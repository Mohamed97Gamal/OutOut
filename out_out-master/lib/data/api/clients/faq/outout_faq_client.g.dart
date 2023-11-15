// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outout_faq_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OutOutFAQClient implements OutOutFAQClient {
  _OutOutFAQClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<FAQResponsePageOperationResult> getAllFAQ(
      request, pageNumber, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'PageNumber': pageNumber,
      r'PageSize': pageSize
    };
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FAQResponsePageOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/FAQ/GetAllFAQ',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FAQResponsePageOperationResult.fromJson(_result.data!);
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
