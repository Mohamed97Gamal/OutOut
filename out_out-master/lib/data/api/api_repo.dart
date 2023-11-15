import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:out_out/config.dart';
import 'package:out_out/data/api/clients/faq/outout_faq_client.dart';
import 'package:out_out/data/api/clients/outout_auth_client.dart';
import 'package:out_out/data/api/clients/outout_category_client.dart';
import 'package:out_out/data/api/clients/outout_city_client.dart';
import 'package:out_out/data/api/clients/outout_customer_support_client.dart';
import 'package:out_out/data/api/clients/outout_customers_client.dart';
import 'package:out_out/data/api/clients/outout_event_client.dart';
import 'package:out_out/data/api/clients/outout_home_screen_client.dart';
import 'package:out_out/data/api/clients/outout_loyalty_client.dart';
import 'package:out_out/data/api/clients/outout_offer_client.dart';
import 'package:out_out/data/api/clients/outout_payment_client.dart';
import 'package:out_out/data/api/clients/outout_venue_client.dart';
import 'package:out_out/data/api/clients/token/auth_client.dart';
import 'package:out_out/data/api/interceptors/auth_interceptor.dart';
import 'package:out_out/data/api/interceptors/error_interceptor.dart';

class ApiRepo {
  static final ApiRepo _singleton = ApiRepo._internal();

  factory ApiRepo() => _singleton;

  late OutOutAuthClient authClient;
  late OutOutCustomersClient customersClient;
  late OutOutFAQClient faqClient;
  late OutOutCustomerSupportClient customerSupportClient;
  late AuthClient tokenClient;
  late OutOutVenueClient venueClient;
  late OutOutCategoryClient categoryClient;
  late OutOutOfferClient offerClient;
  late OutOutLoyaltyClient loyaltyClient;
  late OutOutEventClient eventClient;
  late OutOutHomeScreenClient homeScreenClient;
  late OutOutCityClient cityClient;
  late OutOutPaymentClient paymentClient;

  ApiRepo._internal() {
    final dio = Dio();
    final authDio = Dio();

    if (kEnvironment == Environment.production) {
      dio.options.connectTimeout = Duration(seconds: 30);
      dio.options.sendTimeout = Duration(seconds: 120);
      dio.options.receiveTimeout = Duration(seconds: 30);
      authDio.options.connectTimeout = Duration(seconds: 30);
      dio.options.sendTimeout = Duration(seconds: 120);
      dio.options.receiveTimeout = Duration(seconds: 30);
    }
    if (kEnvironment == Environment.staging) {
      dio.options.connectTimeout = Duration(seconds: 60);
      dio.options.sendTimeout = Duration(seconds: 60);
      dio.options.receiveTimeout = Duration(seconds: 60);
      authDio.options.connectTimeout = Duration(seconds: 60);
      dio.options.sendTimeout = Duration(seconds: 60);
      dio.options.receiveTimeout = Duration(seconds: 60);
    }

    dio.options.validateStatus = (_) => true;
    dio.options.receiveDataWhenStatusError = true;

    if (!kReleaseMode) {
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ),
      );
      authDio.interceptors.add(
        LogInterceptor(
          request: false,
          requestBody: true,
          requestHeader: false,
          responseHeader: false,
          responseBody: true,
          error: true,
        ),
      );
    }

    dio.interceptors.add(AuthInterceptor(dio));

    dio.interceptors.add(ErrorInterceptor());
    authDio.interceptors.add(ErrorInterceptor());

    if (kEnvironment != Environment.production) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };

      (authDio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    authClient = OutOutAuthClient(dio, baseUrl: apiBaseUrl);
    customersClient = OutOutCustomersClient(dio, baseUrl: apiBaseUrl);
    faqClient = OutOutFAQClient(dio, baseUrl: apiBaseUrl);
    customerSupportClient = OutOutCustomerSupportClient(dio, baseUrl: apiBaseUrl);
    venueClient = OutOutVenueClient(dio, baseUrl: apiBaseUrl);
    categoryClient = OutOutCategoryClient(dio, baseUrl: apiBaseUrl);
    offerClient = OutOutOfferClient(dio, baseUrl: apiBaseUrl);
    loyaltyClient = OutOutLoyaltyClient(dio, baseUrl: apiBaseUrl);
    eventClient = OutOutEventClient(dio, baseUrl: apiBaseUrl);
    homeScreenClient = OutOutHomeScreenClient(dio, baseUrl: apiBaseUrl);
    cityClient = OutOutCityClient(dio, baseUrl: apiBaseUrl);
    paymentClient = OutOutPaymentClient(dio, baseUrl: apiBaseUrl);
    tokenClient = AuthClient(authDio, baseUrl: apiBaseUrl);
  }

  Future ensureInitialized() async => true;
}
