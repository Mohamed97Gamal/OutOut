// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outout_event_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OutOutEventClient implements OutOutEventClient {
  _OutOutEventClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<EventSummaryResponsePageOperationResult> getEvents(
      request, pageNumber, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'PageNumber': pageNumber,
      r'PageSize': pageSize
    };
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EventSummaryResponsePageOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Event/GetEvents',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        EventSummaryResponsePageOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleEventOccurrenceResponseOperationResult> getEventDetails(
      eventOccurrenceId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'eventOccurrenceId': eventOccurrenceId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleEventOccurrenceResponseOperationResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Event/GetEventDetails',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        SingleEventOccurrenceResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> favoriteEvent(eventOccurrenceId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'eventOccurrenceId': eventOccurrenceId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Event/FavoriteEvent',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> unFavoriteEvent(eventOccurrenceId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'eventOccurrenceId': eventOccurrenceId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Event/UnfavoriteEvent',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TelrBookingResponseOperationResult> makeATelrBooking(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TelrBookingResponseOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/EventBooking/MakeATelrBooking',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TelrBookingResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StringOperationResult> checkTelrPaymentStatus(
      request, eventBookingId, paymentToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'eventBookingId': eventBookingId,
      r'paymentToken': paymentToken
    };
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StringOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/EventBooking/CheckTelrPaymentStatus',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StringOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EventBookingSummaryResponseOperationResult> bookingConfirmation(
      eventBookingId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'eventBookingId': eventBookingId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EventBookingSummaryResponseOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/EventBooking/BookingConfirmation',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        EventBookingSummaryResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> setBookingReminder(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/EventBooking/SetBookingReminder',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> redeemTicket(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/EventBooking/RedeemTicket',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleEventOccurrenceResponseOperationResult> getBookingDetails(
      eventBookingId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'eventBookingId': eventBookingId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleEventOccurrenceResponseOperationResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/EventBooking/GetBookingDetails',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        SingleEventOccurrenceResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> AbortPayment(eventBookingId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'eventBookingId': eventBookingId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/EventBooking/AbortPayment',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<SingleEventOccurrenceResponseOperationResult> getSharedTicketDetails(
      ticketId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ticketId': ticketId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleEventOccurrenceResponseOperationResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/EventBooking/GetSharedTicketDetails',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        SingleEventOccurrenceResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> addToSharedTickets(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/EventBooking/AddToSharedTickets',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> setSharedBookingReminder(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/EventBooking/SetSharedBookingReminder',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> isTicketShareable(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/EventBooking/IsTicketShareable',
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
