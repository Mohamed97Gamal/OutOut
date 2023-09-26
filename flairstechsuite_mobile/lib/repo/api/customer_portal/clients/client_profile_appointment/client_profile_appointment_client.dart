import 'package:dio/dio.dart';
import 'package:flairstechsuite_mobile/core/network/error_handler.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_appointment_response_operation_result.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_appointment_response_page_operation_result.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_mood.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/my_appointments_history_summary_response_operation_result.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/my_partner_response_operation_result.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/my_partner_response_page_operation_result.dart';
import 'package:flutter/material.dart';

class ClientProfileAppointmentClient {
  final Dio? dio;

  ClientProfileAppointmentClient({
    required this.dio,
  });

  Future<ClientProfileAppointmentResponsePageOperationResult> getMyFutureAppointmentsThisWeek({
    required int pageIndex,
    required int pageSize,
  }) async {
    try {
      final response = await dio!.post(
        "ClientProfileAppointment/GetMyAppointmentsThisWeek",
        queryParameters: {
          "PageIndex": pageIndex,
          "PageSize": pageSize,
        },
      );
      return ClientProfileAppointmentResponsePageOperationResult.fromJson(response.data);
    } catch (e) {
      return ClientProfileAppointmentResponsePageOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<MyPartnerResponsePageOperationResult> getMyPartners({
    required int pageIndex,
    required int pageSize,
  }) async {
    try {
      final response = await dio!.post(
        "ClientProfileAppointment/GetMyPartners",
        queryParameters: {
          "PageIndex": pageIndex,
          "PageSize": pageSize,
        },
      );
      return MyPartnerResponsePageOperationResult.fromJson(response.data);
    } catch (e) {
      return MyPartnerResponsePageOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<MyPartnerResponseOperationResult> getMyPartnerById({
    required String? id,
  }) async {
    try {
      final response = await dio!.get(
        "ClientProfileAppointment/GetMyPartnerById",
        queryParameters: {
          "Id": id,
        },
      );
      return MyPartnerResponseOperationResult.fromJson(response.data);
    } catch (e) {
      return MyPartnerResponseOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<ClientProfileAppointmentResponsePageOperationResult> getMyAppointmentsHistory({
    required int pageIndex,
    required int pageSize,
    required String? clientProfileId,
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final response = await dio!.post(
        "ClientProfileAppointment/GetMyAppointmentsHistory",
        queryParameters: {
          "PageIndex": pageIndex,
          "PageSize": pageSize,
        },
        data: {
          "clientProfileId": clientProfileId,
          "from": from.toIso8601String(),
          "to": to.toIso8601String(),
        },
      );
      return ClientProfileAppointmentResponsePageOperationResult.fromJson(response.data);
    } catch (e) {
      return ClientProfileAppointmentResponsePageOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<MyAppointmentsHistorySummaryResponseOperationResult> getMyAppointmentsHistorySummary({
    required String? clientProfileId,
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final response = await dio!.post(
        "ClientProfileAppointment/GetMyAppointmentsHistorySummary",
        data: {
          "clientProfileId": clientProfileId,
          "from": from.toIso8601String(),
          "to": to.toIso8601String(),
        },
      );
      return MyAppointmentsHistorySummaryResponseOperationResult.fromJson(response.data);
    } catch (e) {
      return MyAppointmentsHistorySummaryResponseOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<ClientProfileAppointmentResponseOperationResult> logAppointment({
    String? clientProfileAppointmentId,
    String? clientProfileId,
    required ClientProfileMood mood,
    required List<String> issues,
    required List<String> opportunities,
    required String notes,
  }) async {
    try {
      final response = await dio!.post(
        "ClientProfileAppointment/LogAppointment",
        data: {
          "clientProfileId": clientProfileId,
          "clientProfileAppointmentId": clientProfileAppointmentId,
          "mood": mood.value,
          "issues": [
            for (final issue in issues) {"description": issue},
          ],
          "opportunities": [
            for (final opportunity in opportunities) {"description": opportunity},
          ],
          "notes": notes,
        },
      );
      return ClientProfileAppointmentResponseOperationResult.fromJson(response.data);
    } catch (e) {
      return ClientProfileAppointmentResponseOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }
}
