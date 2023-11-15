import 'package:dio/dio.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/disk/disk_repo.dart';
import 'package:out_out/data/memory/memory_repo.dart';
import 'package:out_out/data/models/tokens_data.dart';
import 'package:out_out/data/view_models/auth/refresh_token_request.dart';
import 'package:synchronized/synchronized.dart' as sync;

class AuthInterceptor extends QueuedInterceptor {
  final lock = sync.Lock();
  final Dio originalDio;

  AuthInterceptor(Dio dio) : originalDio = dio;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    TokensData? tokensData = MemoryRepo().tokensData;
    if (tokensData != null) {
      if (tokensData.accessTokenExpirationDate.isBefore(DateTime.now())) {
        bool shouldRetry = await lock.synchronized(() async {
          return await _shouldRetry();
        });
        if (!shouldRetry) {
          return handler.next(options);
        }
        tokensData = MemoryRepo().tokensData;
      }
      if (tokensData != null) {
        options.headers["Authorization"] = "Bearer ${tokensData.accessToken}";
      }
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 423) {
      //TODO: notify user ?
      MemoryRepo().deleteTokensData();
      await DiskRepo().deleteTokensData();
      return handler.reject(
        DioError(requestOptions: response.requestOptions, response: response),
      );
    }

    if (response.statusCode != 401) {
      //TODO: more handling for non 401 status code
      return handler.next(response);
    }

    final shouldRetry = await lock.synchronized(() async {
      return await _shouldRetry();
    });

    if (shouldRetry) {
      return _generateRequest(response);
    }

    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }

  Future<bool> _shouldRetry() async {
   try {
      final tokensData = MemoryRepo().tokensData;
      if (tokensData == null) {
        return false;
      }
      if (tokensData.refreshTokenExpirationDate.isBefore(DateTime.now())) {
        //TODO: restart the app w/ message to the user
        MemoryRepo().deleteTokensData();
        await DiskRepo().deleteTokensData();
        return false;
      }
      var refreshTokenRequest = new RefreshTokenRequest()
        ..accessToken = tokensData.accessToken
        ..refreshToken = tokensData.refreshToken;
      final refreshResponse = await ApiRepo().tokenClient.refreshAccessToken(refreshTokenRequest);
      if (refreshResponse.status) {
        final newTokensData = TokensData.fromLoginResponse(refreshResponse.result);
        MemoryRepo().updateTokensData(newTokensData);
        await DiskRepo().updateTokensData(newTokensData);
        return true;
      } else {
        MemoryRepo().deleteTokensData();
        await DiskRepo().deleteTokensData();
        //TODO: restart the app w/ message to the user
        return false;
      }
    } finally {
    }
  }

  _generateRequest(Response e) {
    final options = e.requestOptions;
    return originalDio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
    );
  }
}
