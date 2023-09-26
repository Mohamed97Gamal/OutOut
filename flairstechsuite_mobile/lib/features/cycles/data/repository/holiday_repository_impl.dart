import '../../../../core/network/failure.dart';
import 'package:dartz/dartz.dart';
import '../remote_data_source/holiday_remote_data_source_impl.dart';
import '../../../../models/api/responses.dart';
import '../../domain/repository/holiday_repository.dart';
import '../model/cycle_holiday_dto.dart';

class HolidayRepositoryImpl extends HolidayRepository {
  HolidayRemoteDataSourceImpl holidayRemoteDataSourceImpl =
      HolidayRemoteDataSourceImpl();
  @override
  Future<Either<Failure, CycleHolidayResponse>> createHoilday(
      CycleHoliday holiday) async {
    final response = await holidayRemoteDataSourceImpl.createHoilday(holiday);

    if (response.status == true) {
      return Right(response);
    } else {
      return Left(Failure(status: response.status, message: response));
    }
  }

  @override
  Future<Either<Failure, BoolResponse>> deleteHoliday(
      String? cycleId, String? holidayId) async {
    final response =
        await holidayRemoteDataSourceImpl.deleteHoliday(cycleId, holidayId);
    if (response.status == true) {
      return Right(response);
    } else {
      return Left(Failure(status: response.status, message: response));
    }
  }

  @override
  Future<Either<Failure, CycleHolidayResponse>> updateHoilday(
      String? cycleId, String? holidayId, String? holidayName) async {
    final response = await holidayRemoteDataSourceImpl.updateHoilday(
        cycleId, holidayId, holidayName);
    if (response.status == true) {
      return Right(response);
    } else {
      return Left(Failure(status: response.status, message: response));
    }
  }

}
