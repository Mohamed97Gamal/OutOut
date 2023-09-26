import 'package:flutter/cupertino.dart';

import '../../../../core/network/app_service_client.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../models/api/responses.dart';
import '../../../../repo/urls.dart';
import '../model/cycle/cycle_dto.dart';
import 'cycle_remote_data_source.dart';

class CycleRemoteDataSourceImpl extends CycleRemoteDataSource
   {
  final _appServiceClient = AppServiceClient();

  @override
  Future<CycleDTOResponse> addCycle(CycleDTO cycle) async {
    try {
      final response =
          await _appServiceClient.client
          .post(Urls.createCycle, data: cycle.toJson());
      return CycleDTOResponse.fromJson(response.data);
    } catch (e) {
      return CycleDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  @override
  Future<BoolResponse> deleteCycle(String? cycleId,
      {VoidCallback? refresh}) async {
    try {
      final response =
          await _appServiceClient.client
          .delete(Urls.deleteCycle + "?cycleId=$cycleId");
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  @override
  Future<CycleDTOListResponse> getAllCycles() async {
    try {
      final response = await _appServiceClient.client.get(Urls.getAllCycles);
      return CycleDTOListResponse.fromJson(response.data);
    } catch (e) {
      return CycleDTOListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  @override
  Future<BoolResponse> setCycleAsDefault(String? cycleId,
      {VoidCallback? refresh}) async {
    try {
      final response = await _appServiceClient.client
          .post(Urls.setDefaultCycle + "$cycleId");
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  @override
  Future<CycleCountryDTOListResponse> getAllCycleCountries() async {
    try {
      final response =
          await _appServiceClient.client.get(Urls.getAllCycleCountries);
      return CycleCountryDTOListResponse.fromJson(response.data);
    } catch (e) {
      return CycleCountryDTOListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  @override
  Future<CycleDTOResponse> getCurrentCycle() async {
    try {
      final response = await _appServiceClient.client.get(Urls.getCurrentCycle);
      return CycleDTOResponse.fromJson(response.data);
    } catch (e) {
      return CycleDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  @override
  Future<CycleDTOResponse> getCycleById(String? cycleId) async {
    try {
      final response =
          await _appServiceClient.client.get(Urls.getCycleById + "$cycleId");
      return CycleDTOResponse.fromJson(response.data);
    } catch (e) {
      return CycleDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }
}
