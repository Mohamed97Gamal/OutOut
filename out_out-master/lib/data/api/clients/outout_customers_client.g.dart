// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outout_customers_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OutOutCustomersClient implements OutOutCustomersClient {
  _OutOutCustomersClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApplicationUserResponseOperationResult> getAccountInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApplicationUserResponseOperationResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Customers/GetAccountInfo',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ApplicationUserResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApplicationUserResponseOperationResult> verify() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApplicationUserResponseOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Customers/UpdateAccountInfo',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ApplicationUserResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApplicationUserResponseOperationResult> getUserLocation() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApplicationUserResponseOperationResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Customers/GetUserLocation',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ApplicationUserResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApplicationUserResponseOperationResult> updateUserLocation(
      request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApplicationUserResponseOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Customers/UpdateUserLocation',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ApplicationUserResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApplicationUserResponseOperationResult> updateNotificationsAllowed(
      request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApplicationUserResponseOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Customers/UpdateNotificationsAllowed',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ApplicationUserResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApplicationUserResponseOperationResult> updateRemindersAllowed(
      request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApplicationUserResponseOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Customers/UpdateRemindersAllowed',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ApplicationUserResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApplicationUserResponseOperationResult> updateAccountInfo(
      {required fullName,
      required phoneNumber,
      required gender,
      profileImage,
      required removeProfileImage}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.fields.add(MapEntry('FullName', fullName));
    _data.fields.add(MapEntry('PhoneNumber', phoneNumber));
    _data.fields.add(MapEntry('Gender', gender.toString()));
    if (profileImage != null) {
      _data.files.add(MapEntry(
          'ProfileImage',
          MultipartFile.fromFileSync(profileImage.path,
              filename: profileImage.path.split(Platform.pathSeparator).last)));
    }
    _data.fields
        .add(MapEntry('RemoveProfileImage', removeProfileImage.toString()));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApplicationUserResponseOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Customers/UpdateAccountInfo',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ApplicationUserResponseOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VenueSummaryResponsePageOperationResult> getFavoriteVenues(
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
                .compose(_dio.options, '/Customers/GetFavoriteVenues',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        VenueSummaryResponsePageOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoyaltyResponsePageOperationResult> getMyLoyalty(
      request, pageNumber, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'PageNumber': pageNumber,
      r'PageSize': pageSize
    };
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoyaltyResponsePageOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Customers/GetMyLoyalty',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoyaltyResponsePageOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EventSummaryResponsePageOperationResult> getFavoriteEvents(
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
                .compose(_dio.options, '/Customers/GetFavoriteEvents',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        EventSummaryResponsePageOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EventBookingSummaryResponsePageOperationResult> getMyEventsBookings(
      pageNumber, pageSize, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'PageNumber': pageNumber,
      r'PageSize': pageSize
    };
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EventBookingSummaryResponsePageOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Customers/GetMyEventBookings',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        EventBookingSummaryResponsePageOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<NotificationResponsePageOperationResult> getMyNotifications(
      pageNumber, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'PageNumber': pageNumber,
      r'PageSize': pageSize
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<NotificationResponsePageOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Customers/GetMyNotifications',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        NotificationResponsePageOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooleanOperationResult> markNotificationsAsRead(
      notificationIds) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'notificationIds': notificationIds
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooleanOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Customers/MarkNotificationsAsRead',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooleanOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VenueBookingResponsePageOperationResult> getMyVenueBookings(
      request, pageNumber, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'PageNumber': pageNumber,
      r'PageSize': pageSize
    };
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VenueBookingResponsePageOperationResult>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/Customers/GetMyVenueBookings',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        VenueBookingResponsePageOperationResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleEventBookingTicketSummaryResponsePageOperationResult>
      getMyEventSharedTickets(request, pageNumber, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'PageNumber': pageNumber,
      r'PageSize': pageSize
    };
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
            SingleEventBookingTicketSummaryResponsePageOperationResult>(
        Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/Customers/GetMyEventSharedTickets',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        SingleEventBookingTicketSummaryResponsePageOperationResult.fromJson(
            _result.data!);
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
