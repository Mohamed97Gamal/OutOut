// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outout_payment_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OutOutPaymentClient implements OutOutPaymentClient {
  _OutOutPaymentClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<String> paid(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/Payment/Paid',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> cancelled(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/Payment/Cancelled',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> declined(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/Payment/Declined',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
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
