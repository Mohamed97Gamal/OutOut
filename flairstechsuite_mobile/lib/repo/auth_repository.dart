import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flairstechsuite_mobile/main.dart';
import 'package:flairstechsuite_mobile/models/user_credentials.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

bool authIsLive = FlairstrackerApp.isProduction;

class AuthRepository {
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  final _clientId = 'flairs_tracker_mobile';
  final _redirectUrl =
      authIsLive ? 'com.flairstech.account:/oauthredirect/' : 'com.flairstech.stsstaging:/oauthredirect/';
  final _scopes = <String>[
    'openid',
    'profile',
    'offline_access',
    'flairs_tracker_api',
    'flairs_clients_app_api_flairstech',
  ];

  // ignore: missing_return
  Future<String?> login(String organizationKey) async {
    final _issuer = authIsLive
        ? 'https://account.flairstech.com/tenants/${organizationKey}/'
        : 'https://stsstaging.flairstech.com/tenants/${organizationKey}/';
    final _discoveryUrl = authIsLive
        ? 'https://account.flairstech.com/tenants/${organizationKey}/.well-known/openid-configuration'
        : 'https://stsstaging.flairstech.com/tenants/${organizationKey}/.well-known/openid-configuration';

    try {
      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUrl,
          issuer: _issuer,
          promptValues: ['login'],
          discoveryUrl: _discoveryUrl,
          scopes: _scopes,
          allowInsecureConnections: !kReleaseMode,
        ),
      );

      if (result != null) {
        await UserCredentials(
          accessToken: result.accessToken,
          refreshToken: result.refreshToken,
          expirationDateTime: result.accessTokenExpirationDateTime.toString(),
          organizationKey: organizationKey,
        ).saveToSecureStorage();
      }
      return null;
    } catch (e, stack) {
      await FirebaseCrashlytics.instance.recordError(e, stack, reason: "Authentication issue");
      return "Error: ${e.toString()}";
    }
  }

  // ignore: missing_return
  Future<TokenResponse?> refreshTokens() async {
    final credentials = await UserCredentials.fromSecureStorage();
    final organizationKey = credentials.organizationKey;
    final _discoveryUrl = authIsLive
        ? 'https://account.flairstech.com/tenants/${organizationKey}/.well-known/openid-configuration'
        : 'https://stsstaging.flairstech.com/tenants/${organizationKey}/.well-known/openid-configuration';

    try {
      final refreshResult = await (_appAuth.token(
        TokenRequest(
          _clientId,
          _redirectUrl,
          refreshToken: credentials.refreshToken,
          discoveryUrl: _discoveryUrl,
          scopes: _scopes,
          allowInsecureConnections: !kReleaseMode,
        ),
      ) as FutureOr<TokenResponse>);
      if (refreshResult.accessToken != null && refreshResult.accessToken != credentials.accessToken)
        return refreshResult;
      else
        return null;
    } catch (_) {
      return null;
    }
  }
}
