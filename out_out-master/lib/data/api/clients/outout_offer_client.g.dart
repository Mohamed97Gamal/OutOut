// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outout_offer_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OutOutOfferClient implements OutOutOfferClient {
  _OutOutOfferClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<OfferTypeSumamryResponseListOperationResult> getOfferTypes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OfferTypeSumamryResponseListOperationResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Offer/GetOfferTypes',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        OfferTypeSumamryResponseListOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ActivatedOffer> isExpiredOffer(offerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'offerId': offerId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ActivatedOffer>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Offer/IsOfferExpired',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ActivatedOffer.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OfferWithVenueResponsePageOperationResult> getActiveNonExpiredOffers(
      request, pageNumber, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'PageNumber': pageNumber,
      r'PageSize': pageSize
    };
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OfferWithVenueResponsePageOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Offer/GetActiveNonExpiredOffers',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        OfferWithVenueResponsePageOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OfferWithVenueResponsePageOperationResult>
      getActiveNonExpiredUpcomingOffers(request, pageNumber, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'PageNumber': pageNumber,
      r'PageSize': pageSize
    };
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OfferWithVenueResponsePageOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(
                    _dio.options, '/Offer/GetActiveNonExpiredUpcomingOffers',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        OfferWithVenueResponsePageOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OfferResponsePageOperationResult> getAllUpcomingOffers(
      request, pageNumber, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'PageNumber': pageNumber,
      r'PageSize': pageSize
    };
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OfferResponsePageOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Offer/GetMyOffers',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OfferResponsePageOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> redeemOffer(offerId, pinCode) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offerId': offerId,
      r'pinCode': pinCode
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Offer/RedeemOffer',
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
