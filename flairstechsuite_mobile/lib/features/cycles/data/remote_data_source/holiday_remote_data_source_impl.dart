import '../../../../core/network/app_service_client.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../models/api/responses.dart';
import '../../../../repo/urls.dart';
import '../model/cycle_holiday_dto.dart';
import 'holiday_remote_data_source.dart';

class HolidayRemoteDataSourceImpl extends HolidayRemoteDataSource {
  final _appServiceClient = AppServiceClient();

  @override
  Future<CycleHolidayResponse> createHoilday(CycleHoliday holiday) async {
    try {
      final response =
          await _appServiceClient.client
          .post(Urls.createHoliday, data: holiday.toJson());

      return CycleHolidayResponse.fromJson(response.data);
    } catch (e) {
      return CycleHolidayResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  @override
  Future<BoolResponse> deleteHoliday(String? cycleId, String? holidayId) async {
    try {
      final response = await _appServiceClient.client.delete(
          Urls.deleteCycleHoliday,
          queryParameters: {"cycleId": "$cycleId", "holidayId": "$holidayId"});
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  @override
  Future<CycleHolidayResponse> updateHoilday(
      String? cycleId, String? holidayId, String? holidayName) async {
    try {
      final response = await _appServiceClient.client.put(Urls.updateHoliday,
          data: {
        "cycleId": cycleId,
        "holidayId": holidayId,
        "holidayName": holidayName
      });
      return CycleHolidayResponse.fromJson(response.data);
    } catch (e) {
      return CycleHolidayResponse.fromJson(getErrorResponse(e).toJson());
    }
  }
}
