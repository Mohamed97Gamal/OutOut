import '../../../../models/api/responses.dart';
import '../model/cycle_holiday_dto.dart';

abstract class HolidayRemoteDataSource {
  Future<CycleHolidayResponse> createHoilday(CycleHoliday holiday);
  Future<CycleHolidayResponse> updateHoilday(
      String cycleId, String holidayId, String holidayName);
  Future<BoolResponse> deleteHoliday(String cycleId, String holidayId);
}
