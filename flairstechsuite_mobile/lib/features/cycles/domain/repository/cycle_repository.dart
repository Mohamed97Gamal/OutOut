import 'package:dartz/dartz.dart';
import 'package:flairstechsuite_mobile/core/network/failure.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/api/responses.dart';
import '../../data/model/cycle/cycle_dto.dart';

abstract class CycleRepository {

  Future<Either<Failure, BoolResponse>> setCycleAsDefault(String cycleId);
  Future<Either<Failure, BoolResponse>> deleteCycle(String cycleId);
  Future<CycleDTOListResponse> getAllCycles();
  Future<Either<Failure, CycleDTOResponse>> addCycle(CycleDTO cycle);
  Future<CycleCountryDTOListResponse> getAllCycleCountries();
  Future<Either<Failure, CycleDTOResponse>> getCycleById(String cycleId);
  Future<Either<Failure, CycleDTOResponse>> getCurrentCycle();

}
