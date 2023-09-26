import '../../../../core/network/failure.dart';
import '../remote_data_source/cycle_remote_data_source_impl.dart';
import '../../../../models/api/responses.dart';
import '../../domain/repository/cycle_repository.dart';
import '../model/cycle/cycle_dto.dart';
import 'package:dartz/dartz.dart';

class CycleRepositoryImpl extends CycleRepository {
  CycleRemoteDataSourceImpl cycleRemoteDataSourceImpl =
      CycleRemoteDataSourceImpl();
  @override
  Future<Either<Failure, BoolResponse>> deleteCycle(String? cycleId) async {
    final response = await cycleRemoteDataSourceImpl.deleteCycle(cycleId);
    if (response.status == true) {
      return Right(response);
    } else {
      return Left(Failure(status: response.status, message: response));
    }
  }

  @override
  Future<Either<Failure, BoolResponse>> setCycleAsDefault(
      String? cycleId) async {
    final response = await cycleRemoteDataSourceImpl.setCycleAsDefault(cycleId);
    if (response.status == true) {
      return Right(response);
    } else {
      return Left(Failure(status: response.status, message: response));
    }
  }

  @override
  Future<Either<Failure, CycleDTOResponse>> addCycle(CycleDTO cycle) async {
    final response = await cycleRemoteDataSourceImpl.addCycle(cycle);
    if (response.status == true) {
      return Right(response);
    } else {
      return Left(Failure(status: response.status, message: response));
    }
  }

  @override
  Future<CycleDTOListResponse> getAllCycles() {
    final response = cycleRemoteDataSourceImpl.getAllCycles();
    return response;
    // if (response.status == true) {
    //   return Right(response);
    // } else {
    //   return Left(Failure(status: response.status, message: response));
    // }
  }

  @override
  Future<CycleCountryDTOListResponse> getAllCycleCountries() async {
    final response = await cycleRemoteDataSourceImpl.getAllCycleCountries();
    return response;
    // if (response.status == true) {
    //   return Right(response);
    // } else {
    //   return Left(Failure(status: response.status, message: response));
    // }
  }

  @override
  Future<Either<Failure, CycleDTOResponse>> getCurrentCycle() async {
    final response = await cycleRemoteDataSourceImpl.getCurrentCycle();
    if (response.status == true) {
      return Right(response);
    } else {
      return Left(Failure(status: response.status, message: response));
    }
  }

  @override
  Future<Either<Failure, CycleDTOResponse>> getCycleById(String? cycleId) async {
    final response = await cycleRemoteDataSourceImpl.getCycleById(cycleId);
    if (response.status == true) {
      return Right(response);
    } else {
      return Left(Failure(status: response.status, message: response));
    }
  }
}
