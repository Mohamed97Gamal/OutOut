import 'package:dartz/dartz.dart';
import '../../../../core/network/failure.dart';
import '../../data/model/cycle_holiday_dto.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/api/responses.dart';
import '../../data/model/holiday/holiday_dto.dart';

abstract class HolidayRepository {
  
  Future<Either<Failure, CycleHolidayResponse>> createHoilday(
      CycleHoliday holiday);
  Future<Either<Failure, CycleHolidayResponse>> updateHoilday(
      String cycleId, String holidayId, String holidayName);
  Future<Either<Failure, BoolResponse>> deleteHoliday(
      String cycleId, String holidayId);
}
