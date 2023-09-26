import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flairstechsuite_mobile/repo/urls.dart';
import 'package:flairstechsuite_mobile/main.dart';
import 'package:flairstechsuite_mobile/repo/auth_interceptor.dart';

class AppServiceClient {
  //Singleton
 static final AppServiceClient _singleton = AppServiceClient._internal();

  final Dio client;

  factory AppServiceClient() {
    return _singleton;
  }

  AppServiceClient._internal() : client = generateClient();

  static Dio generateClient() {
    final client = Dio();
    client.options.baseUrl = Urls.baseUrl;
    client.options.connectTimeout = Duration(seconds: 120);
    client.options.receiveTimeout = Duration(seconds: 40);
    if (!FlairstrackerApp.isProduction) {
      client.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );

      (client.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }
    client.interceptors.add(AuthInterceptor(client));
    return client;
  }
}
