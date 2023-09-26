import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flairstechsuite_mobile/main.dart';
import 'package:flairstechsuite_mobile/models/user_credentials.dart';
import 'package:flairstechsuite_mobile/repo/auth_repository.dart';
import 'package:flairstechsuite_mobile/repo/urls.dart';
import 'package:flairstechsuite_mobile/utils/common.dart';
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:package_info/package_info.dart';
import 'package:synchronized/synchronized.dart' as sync;

class AuthInterceptor extends QueuedInterceptor  {
  final Dio originalDio;
  final lock = sync.Lock();

  AuthInterceptor(Dio dio)
      : assert(dio != null),
        originalDio = dio;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final credentials = await UserCredentials.fromSecureStorage();
    final organizationKey = credentials.organizationKey;
    final url = options?.uri?.toString()?.toLowerCase();

    final token = credentials?.accessToken;
    if (token == null) {
      return handler.next(options);
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    printIfDebug("Inserting token to: $url");
    options.headers["Authorization"] = "Bearer $token";
    options.headers["Tenant-Key"] = organizationKey;
    options.headers["hub_platform"] = Platform.isIOS ? "ios" : "android";
    options.headers["hub_version"] = packageInfo.version;

    // options.headers["Accept-Language"] = MyAppLocalization.current.locale;
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final uri = err.requestOptions.uri;
    if (err?.response?.statusCode != 401 ||
        !Urls.requiresAuth(url: uri?.toString()?.toLowerCase()))
      return handler.next(err);

    final shouldRetry = await lock.synchronized(() async {
      return await _shouldRetry();
    });
    if (shouldRetry) {
      return handler.resolve(await _generateRequest(err));
    }
    return handler.next(err);
  }

  Future<bool> _shouldRetry() async {
    final refreshResponse = await AuthRepository().refreshTokens();
    if (refreshResponse != null) {
      await UserCredentials(
        accessToken: refreshResponse?.accessToken,
        refreshToken: refreshResponse?.refreshToken,
        expirationDateTime:
            refreshResponse?.accessTokenExpirationDateTime.toString(),
      ).saveToSecureStorage();
      return true;
    } else {
      await UserCredentials.removeFromSecureStorage();
      showInvalidAuthData = true;
      Navigation.restartApp();
      return false;
    }
  }

  Future<Response> _generateRequest(DioError e) async {
    final options = e.response!.requestOptions;
    _recreateMultiPartIfNeeded(options);
    return await originalDio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
    );
  }

  _recreateMultiPartIfNeeded(RequestOptions options) {
    final isFormData = options.data is FormData;
    if (!isFormData) return;
    final newFormData = FormData();
    newFormData.fields.addAll(options.data.fields);
    final Map<String, String>? allExtraFiles = options.extra[extraFilesPathKey];
    for (MapEntry<String, MultipartFile> mapFile in options.data.files) {
      final oldFile = mapFile.value;
      MultipartFile? newFile;
      if (oldFile != null) {
        final filePathFromOldFile =
            ArgumentError.checkNotNull(allExtraFiles![oldFile.filename!]);
        newFile = MultipartFile.fromFileSync(
          filePathFromOldFile,
          filename: oldFile.filename,
          contentType: oldFile.contentType,
        );
      }
      newFormData.files.add(MapEntry(mapFile.key, newFile!));
    }
    options.data = newFormData;
  }
}
