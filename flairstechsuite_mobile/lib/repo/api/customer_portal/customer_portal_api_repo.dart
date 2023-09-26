import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flairstechsuite_mobile/config.dart';
import 'package:flairstechsuite_mobile/repo/api/customer_portal/clients/auth/auth_client.dart';
import 'package:flairstechsuite_mobile/repo/api/customer_portal/clients/client_profile_appointment/client_profile_appointment_client.dart';
import 'package:flairstechsuite_mobile/repo/auth_interceptor.dart';

class CustomerPortalApiRepo {
  static final CustomerPortalApiRepo _singleton = CustomerPortalApiRepo._internal();

  factory CustomerPortalApiRepo() {
    return _singleton;
  }

  CustomerPortalApiRepo._internal() {
    final options = BaseOptions(
      connectTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 120),
      receiveTimeout: Duration(seconds: 60),
      validateStatus: (_) => true,
      receiveDataWhenStatusError: true,
      baseUrl: customerPortalBaseUrl,
    );
    dio = Dio(options);

    dio!.interceptors.addAll(
      [
        LogInterceptor(
          request: true,
          requestBody: true,
          responseBody: true,
        ),
        AuthInterceptor(dio!),
      ],
    );

    if (kEnvironment != Environment.production) {
      (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }

    authClient = AuthClient(dio: dio);
    clientProfileAppointmentClient = ClientProfileAppointmentClient(dio: dio);
  }

  Dio? dio;
  late ClientProfileAppointmentClient clientProfileAppointmentClient;
  late AuthClient authClient;
}
