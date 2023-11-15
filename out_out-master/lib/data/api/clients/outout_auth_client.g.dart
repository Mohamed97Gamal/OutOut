// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outout_auth_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OutOutAuthClient implements OutOutAuthClient {
  _OutOutAuthClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<BooleanOperationResult> changePassword(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Auth/ChangePassword',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> forgetPassword(email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'email': email};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Auth/ForgetPassword',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StringOperationResult> verifyResetPassword(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StringOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Auth/VerifyResetPassword',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StringOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> resetPassword(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Auth/ResetPassword',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> resendVerificationEmail(email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'email': email};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Auth/ResendVerificationEmail',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OTPVerificationTimeLeftResponseOperationResult> timeLeftVerification(
      email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'email': email};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OTPVerificationTimeLeftResponseOperationResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Auth/TimeLeftVerification',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        OTPVerificationTimeLeftResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> logout(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Auth/Logout',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
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
