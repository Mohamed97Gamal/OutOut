// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outout_venue_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OutOutVenueClient implements OutOutVenueClient {
  _OutOutVenueClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<VenueSummaryResponsePageOperationResult> getVenues(
      request, pageNumber, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'PageNumber': pageNumber,
      r'PageSize': pageSize
    };
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VenueSummaryResponsePageOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Venue/GetVenues',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        VenueSummaryResponsePageOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VenueResponseOperationResult> getVenueDetails(venueId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'venueId': venueId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VenueResponseOperationResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Venue/GetVenueDetails',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VenueResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TermsAndConditionsResponseListOperationResult> getTermsAndConditions(
      venueId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'venueId': venueId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TermsAndConditionsResponseListOperationResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Venue/GetVenueTermsAndConditions',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        TermsAndConditionsResponseListOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> favoriteVenue(venueId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'venueId': venueId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Venue/FavoriteVenue',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> unFavoriteVenue(venueId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'venueId': venueId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Venue/UnfavoriteVenue',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VenueBookingResponseOperationResult> makeABooking(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VenueBookingResponseOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/VenueBooking/MakeABooking',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VenueBookingResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VenueResponseOperationResult> getBookingDetails(venueBookingId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'bookingId': venueBookingId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VenueResponseOperationResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/VenueBooking/GetBookingDetails',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VenueResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> cancelABooking(venueBookingId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'bookingId': venueBookingId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/VenueBooking/CancelABooking',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> setAReminder(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/VenueBooking/SetBookingReminder',
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
