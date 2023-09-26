import 'package:flutter/cupertino.dart';

import '../../../../models/api/responses.dart';
import '../model/cycle/cycle_dto.dart';

abstract class CycleRemoteDataSource {
  Future<BoolResponse> setCycleAsDefault(String cycleId,
      {VoidCallback? refresh});
  Future<BoolResponse> deleteCycle(String cycleId, {VoidCallback? refresh});
  Future<CycleDTOResponse> addCycle(CycleDTO cycle);
  Future<CycleDTOListResponse> getAllCycles();
  Future<CycleCountryDTOListResponse> getAllCycleCountries();
  Future<CycleDTOResponse> getCycleById(String cycleId);
  Future<CycleDTOResponse> getCurrentCycle();
}
