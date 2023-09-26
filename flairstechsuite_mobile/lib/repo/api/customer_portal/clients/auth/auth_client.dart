import 'package:dio/dio.dart';
import 'package:flairstechsuite_mobile/core/network/error_handler.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/auth/my_user_info_response.dart';
import 'package:flutter/material.dart';

class AuthClient {
  final Dio? dio;

  AuthClient({
    required this.dio,
  });

  Future<MyUserInfoResponseOperationResult> getMyUserInfo() async {
    try {
      final response = await dio!.get(
        "Auth/GetMyUserInfo",
      );
      return MyUserInfoResponseOperationResult.fromJson(response.data);
    } catch (e) {
      return MyUserInfoResponseOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }
}
