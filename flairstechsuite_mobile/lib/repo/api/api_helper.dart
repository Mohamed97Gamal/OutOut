import 'package:dio/dio.dart';
import 'package:flairstechsuite_mobile/main.dart';
import 'package:flairstechsuite_mobile/repo/auth_interceptor.dart';
import 'package:flairstechsuite_mobile/repo/urls.dart';
import 'package:flutter/foundation.dart';

class ApiHelper {
  static const baseUrl = FlairstrackerApp.isProduction ? "apiattendance.flairstech.com" : "192.168.54.200:1992";

  static const normalUrl = "flairstech.flairstracker.com";

  static const isHttps = FlairstrackerApp.isProduction;

  static Future<List<dynamic>?> getAsList(
    String functionName, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    bool auth = true,
  }) async {
    final uri = getUri(functionName, queryParameters);
    //final credentials = await UserCredentials.fromSecureStorage();

    final client = Dio();
    client.options.baseUrl = Urls.baseUrl;
    client.options.connectTimeout = Duration(seconds: 120);
    client.options.receiveTimeout = Duration(seconds: 40);
    if (!kReleaseMode) {
      client.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }
    client.interceptors.add(AuthInterceptor(client));

    final response = await client.get(
      uri.toString(),
    );
    return response.data as List?;
  }

  static Uri getUri(
    String functionName, [
    Map<String, String>? queryParameters = const {},
  ]) {
    if (isHttps) {
      return Uri.https(baseUrl, '/api/$functionName', queryParameters ?? {});
    } else {
      return Uri.http(baseUrl, '/api/$functionName', queryParameters ?? {});
    }
  }

  static Uri getNormalLink(String functionName) {
    if (isHttps) {
      return Uri.https(normalUrl, '/$functionName');
    } else {
      return Uri.http(normalUrl, '/$functionName');
    }
  }
}
