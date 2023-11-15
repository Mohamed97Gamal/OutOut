// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AuthClient implements AuthClient {
  _AuthClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginResponseOperationResult> login(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginResponseOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Auth/Login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginResponseOperationResult> refreshAccessToken(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginResponseOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Auth/RefreshAccessToken',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApplicationUserResponseOperationResult> register(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApplicationUserResponseOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Auth/Register',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ApplicationUserResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginResponseOperationResult> verifyAccount(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginResponseOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Auth/VerifyAccount',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginResponseOperationResult> externalAuthentication(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginResponseOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Auth/ExternalAuthentication',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponseOperationResult.fromJson(_result.data!);
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
