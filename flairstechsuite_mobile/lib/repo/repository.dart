import 'package:dio/dio.dart';
import 'package:flairstechsuite_mobile/core/network/app_service_client.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/data/model/check_in_out_dto.dart';
import 'package:flairstechsuite_mobile/features/my_calendar/data/models/calendar_dto.dart';
import 'package:flairstechsuite_mobile/features/quick_leave/domain/entity/quick_leave_entity.dart';
import 'package:flairstechsuite_mobile/models/my_team_leave_request.dart';
import '../features/cycles/data/model/cycle_holiday_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

import '../main.dart';
import '../models/api/paginated_responses.dart';
import '../models/api/requests.dart';
import '../models/api/responses.dart';
import '../models/employees_filteration_request_dto.dart';
import '../models/organization_dto.dart';
import '../utils/common.dart';
import 'urls.dart';

class Repository {
  //Singleton
  static final Repository _singleton = Repository._internal();

  final Dio _client;

  factory Repository() {
    return _singleton;
  }

  Repository._internal() : _client = AppServiceClient.generateClient();

  Future<AssignShiftMultipleResponse> getAllowedVersions() async {
    try {
      final response = await _client.get(
        Urls.getAllowedVersions,
      );
      return AssignShiftMultipleResponse.fromJson(response.data);
    } catch (e) {
      return AssignShiftMultipleResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> sendForgetPassword(String email) async {
    try {
      final response = await _client.post(
        Urls.sendForgetPassword,
        data: {"email": "$email"},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> sendBalanceReport({
    required bool teamOnly,
    required List<String?> cc,
    required bool? directReporteesOnly,
  }) async {
    try {
      final response = await _client.post(
        Urls.exportBalance,
        data: {
          "teamOnly": teamOnly,
          "cc": cc,
          "directReporteesOnly": directReporteesOnly,
        },
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> sendAttendanceReport({
    required DateTime from,
    required DateTime to,
    required String? employeeId,
    required bool teamOnly,
    required List<String?> cc,
    required bool? directReporteesOnly,
  }) async {
    assert(from != null && to != null);
    try {
      final response = await _client.post(
        Urls.exportAttendance,
        data: {
          "from": from?.toIso8601String(),
          "to": to?.toIso8601String(),
          "teamOnly": teamOnly,
          "cc": cc,
          "employeeId": employeeId,
          "directReporteesOnly": directReporteesOnly,
        },
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> sendVerifyEmail(String email) async {
    try {
      final response = await _client.get(
        Urls.sendVerifyEmail,
        queryParameters: {"email": "$email"},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> changePassword(String oldPassword, String newPassword) async {
    try {
      final response = await _client.post(
        Urls.changePassword,
        data: {"oldPassword": "$oldPassword", "newPassword": "$newPassword", "confirmNewPassword": "$newPassword"},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<OrganizationDTOListResponse> getOrganizationsDetails() async {
    try {
      final response = await _client.get(Urls.getAllOrganizations);
      return OrganizationDTOListResponse.fromJson(response.data);
    } catch (e) {
      return OrganizationDTOListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<OrganizationDTOResponse> getOrganizationDetails(String organizationId) async {
    try {
      final response = await _client.get(Urls.getOrganizationDetails + "/$organizationId");
      return OrganizationDTOResponse.fromJson(response.data);
    } catch (e) {
      return OrganizationDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<OrganizationFullDTOListResponse> getFullOrganizationsDetails() async {
    try {
      final response = await _client.get(Urls.getFullOrganizationsDetails);
      return OrganizationFullDTOListResponse.fromJson(response.data);
    } catch (e) {
      return OrganizationFullDTOListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<OrganizationDTOResponse> getMyOrganizationDetails() async {
    try {
      final response = await _client.get(Urls.getMyOrganizationInfo);
      return OrganizationDTOResponse.fromJson(response.data);
    } catch (e) {
      return OrganizationDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<OrganizationDTOResponse> updateMyOrganizationInfo(OrganizationDTO orgDTO) async {
    try {
      final options = Options();
      final file = await _createMultipartFile(options, filePath: orgDTO.logo);
      final formData = FormData.fromMap({
        "name": orgDTO.name,
        "business": orgDTO.business,
        "website": orgDTO.website,
        "contactNumber": orgDTO.contactNumber,
        "addresses": orgDTO.addresses!.map((e) => e.toJson()).toList(),
        "domains": orgDTO.domains!.toList(),
        "logo": file
      });
      final response = await _client.post(Urls.updateMyOrganizationInfo, data: formData, options: options);
      return OrganizationDTOResponse.fromJson(response.data);
    } catch (e) {
      return OrganizationDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<SettingsDTOResponse> getMyOrganizationSettings() async {
    try {
      final response = await _client.get(Urls.getAllOrganizationSettings);
      return SettingsDTOResponse.fromJson(response.data);
    } catch (e) {
      return SettingsDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> addMyFCMToken() async {
    try {
      final response = await _client.post(
        Urls.addMyFCMToken,
        queryParameters: {"fcmToken": await firebaseMessaging.getToken()},
      );
      print("${firebaseMessaging.app.options.messagingSenderId}sssssssssssssssssssssssssssssss");
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> deleteMyFCMToken() async {
    try {
      final response = await _client.post(
        Urls.deleteMyFCMToken,
        queryParameters: {"fcmToken": await firebaseMessaging.getToken()},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> sendAnnouncementNotification(String? id) async {
    try {
      final response = await _client.post(
        Urls.sendAnnouncementNotification,
        queryParameters: {"announcementId": id},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<ListStringResponse> getTimeZones() async {
    try {
      final response = await _client.get(
        Urls.getTimeZones,
      );
      return ListStringResponse.fromJson(response.data);
    } catch (e) {
      return ListStringResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<ListStringResponse> getAllEmails() async {
    try {
      final response = await _client.get(
        Urls.getAllEmails,
      );
      return ListStringResponse.fromJson(response.data);
    } catch (e) {
      return ListStringResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<SettingsDTOResponse> updateOrganizationSettings(SettingsDTO settingsDTO) async {
    try {
      final response = await _client.post(
        Urls.updateOrganizationSettings,
        data: settingsDTO.toJson(),
      );
      return SettingsDTOResponse.fromJson(response.data);
    } catch (e) {
      return SettingsDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<OrganizationDTOResponse> createOrganization(OrganizationDTO organizationDTO) async {
    try {
      final response = await _client.post(
        Urls.createOrganization,
        data: organizationDTO.toJson(),
      );
      return OrganizationDTOResponse.fromJson(response.data);
    } catch (e) {
      return OrganizationDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<OrganizationDTOResponse> updateOrganization(OrganizationDTO organizationDTO) async {
    try {
      final response = await _client.post(
        Urls.updateOrganization,
        data: organizationDTO.toJson(),
      );
      return OrganizationDTOResponse.fromJson(response.data);
    } catch (e) {
      return OrganizationDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> deactivateOrganization(String organizationId) async {
    try {
      final response = await _client.get(Urls.deactivateOrganization + "/$organizationId");
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> activateOrganization(String organizationId) async {
    try {
      final response = await _client.get(Urls.activateOrganization + "/$organizationId");
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<AdminsListDTOResponse> getAdminsList(String organizationId) async {
    final path = organizationId != null ? Urls.getAdminsList + "/$organizationId" : Urls.getAdminsList;
    try {
      final response = await _client.get(path);
      return AdminsListDTOResponse.fromJson(response.data);
    } catch (e) {
      return AdminsListDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<MyOrgAdminListResponse> getMyOrgAdminList() async {
    try {
      final response = await _client.get(Urls.getMyOrgAdmins);
      return MyOrgAdminListResponse.fromJson(response.data);
    } catch (e) {
      return MyOrgAdminListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<MyTeamMembersListResponse> getMyTeamMembers({bool sorted = true, bool? directReporteesOnly}) async {
    try {
      final response = await _client.get(
        Urls.getMyTeamMembers,
        queryParameters: {"directReporteesOnly": directReporteesOnly},
      );
      final result = MyTeamMembersListResponse.fromJson(response.data);
      if (sorted == true) {
        result.result!.sort((a, b) => a.fullName!.toLowerCase().compareTo(b.fullName!.toLowerCase()));
      }
      return result;
    } catch (e) {
      return MyTeamMembersListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<AllEmployeesListResponse> getAllEmployees({bool sorted = true}) async {
    try {
      final response = await _client.post(Urls.getEmployeesList, data: {});
      final result = AllEmployeesListResponse.fromJson(response.data);
      if (sorted == true) {
        result.result!.sort((a, b) => a.fullName!.toLowerCase().compareTo(b.fullName!.toLowerCase()));
      }
      return result;
    } catch (e) {
      return AllEmployeesListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<AllEmployeesListResponse> getEmployeesAssignedToShift({String? shiftId}) async {
    try {
      final response = await _client.post(
        Urls.getEmployeesAssignedToShift,
        data: {"shiftId": shiftId},
      );
      final result = AllEmployeesListResponse.fromJson(response.data);
      result.result!.sort((a, b) => a.fullName!.toLowerCase().compareTo(b.fullName!.toLowerCase()));
      return result;
    } catch (e) {
      return AllEmployeesListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> assignMyOrgAdmin(String? employeeId) async {
    try {
      final response = await _client.post(
        Urls.assignAdminToMyOrganization,
        queryParameters: {"employeeId": "$employeeId"},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> assignShift(String? shiftId, Set<String?> employeeIds) async {
    try {
      final response = await _client.post(
        Urls.assignShift,
        data: {"shiftId": shiftId, "employeeIds": employeeIds.toList()},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<AssignShiftMultipleResponse> assignShiftToMultipleEmployees(String? shiftId, Set<String?> employeeIds) async {
    try {
      final response = await _client.post(
        Urls.multipleAssignShift,
        data: {"shiftId": shiftId, "employeeIds": employeeIds.toList()},
      );
      return AssignShiftMultipleResponse.fromJson(response.data);
    } catch (e) {
      return AssignShiftMultipleResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> deleteAdmin(String organizationId, String applicationUserId) async {
    try {
      final response = await _client.get(
        Urls.deleteAdmin,
        queryParameters: {"organizationId": "$organizationId", "applicationUserId": "$applicationUserId"},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> deleteMyOrgAdmin(String? employeeId) async {
    try {
      final response = await _client.get(
        Urls.deleteMyOrgAdmin,
        queryParameters: {"employeeId": "$employeeId"},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<AdminDTOResponse> addAdmin(CreateAdminViewModel createAdminViewModel) async {
    try {
      final response = await _client.post(
        Urls.addAdmin,
        data: createAdminViewModel.toJson(),
      );
      return AdminDTOResponse.fromJson(response.data);
    } catch (e) {
      return AdminDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  // For Admins use
  Future<AdminDTOResponse> addAdminToMyOrganization(CreateAdminViewModel createAdminViewModel) async {
    try {
      final response = await _client.post(
        Urls.addAdminToMyOrganization,
        data: createAdminViewModel.toJson(),
      );
      return AdminDTOResponse.fromJson(response.data);
    } catch (e) {
      return AdminDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<OrganizationFullDTOResponse> getFullOrganizationDetails(String organizationId) async {
    try {
      final response = await _client.get(Urls.getFullOrganizationsDetails + "/$organizationId");
      return OrganizationFullDTOResponse.fromJson(response.data);
    } catch (e) {
      return OrganizationFullDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<DepartmentDTOListResponse> getOrganizationDepartments(String organizationId) async {
    try {
      final response = await _client.get(Urls.getOrganizationDepartments);
      return DepartmentDTOListResponse.fromJson(response.data);
    } catch (e) {
      return DepartmentDTOListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<MyUserDetailsResponse> getMyUserDetails() async {
    try {
      final response = await _client.get(Urls.getMyUserDetails);
      return MyUserDetailsResponse.fromJson(response.data);
    } catch (e) {
      return MyUserDetailsResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<DepartmentDTOResponse> updateDepartment(UpdateDepartmentViewModel updateDepartmentViewModel) async {
    try {
      final response = await _client.post(
        Urls.updateDepartment,
        data: updateDepartmentViewModel.toJson(),
      );
      return DepartmentDTOResponse.fromJson(response.data);
    } catch (e) {
      return DepartmentDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> deleteDepartment(String departmentId) async {
    try {
      final response = await _client.get(Urls.deleteDepartment + "/$departmentId");
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<DepartmentDTOResponse> createDepartment(CreateDepartmentViewModel createDepartmentViewModel) async {
    try {
      final response = await _client.post(
        Urls.createDepartment,
        data: createDepartmentViewModel.toJson(),
      );
      return DepartmentDTOResponse.fromJson(response.data);
    } catch (e) {
      return DepartmentDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<EmployeeProfileDTOResponse> getMyEmployeeProfile() async {
    try {
      final response = await _client.get(
        Urls.getMyEmployee,
      );
      return EmployeeProfileDTOResponse.fromJson(response.data);
    } catch (e) {
      return EmployeeProfileDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<TenroxTaskDTOListResponse> getMyTasks() async {
    try {
      final response = await _client.get(Urls.getMyTasks);
      return TenroxTaskDTOListResponse.fromJson(response.data);
    } catch (e) {
      return TenroxTaskDTOListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> startTask(int? taskId, String? taskTitle) async {
    try {
      final response = await _client.post(
        Urls.startMyTask,
        queryParameters: {"TaskId": "$taskId", "TaskTitle": "$taskTitle"},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> endTask(int? taskId) async {
    try {
      final response = await _client.post(
        Urls.endMyTask,
        queryParameters: {"TaskId": "$taskId"},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<LocationDTOListResponse> getMyLocations() async {
    try {
      final response = await _client.get(
        Urls.getMyLocations,
        queryParameters: {"pageSize": 2147483646},
      );
      return LocationDTOListResponse.fromJson(response.data);
    } catch (e) {
      return LocationDTOListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<IntResponse> calculateLeaveDays({required DateTime from, required DateTime to}) async {
    try {
      final response = await _client.post(Urls.calculateLeaveDays, data: {"from": from.toIso8601String(), "to": to.toIso8601String()});
      return IntResponse.fromJson(response.data);
    } catch (e) {
      return IntResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<LeaveRequestDTOPageDTOOperationResult> getMyLeaveRequests({
    int? pageNumber,
    int? pageSize,
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final response = await _client.post(
        Urls.getMyLeaveRequests,
        queryParameters: {
          "pageNumber": "$pageNumber",
          "pageSize": pageSize,
        },
        data: {"from": from.toIso8601String(), "to": to.toIso8601String()},
      );
      return LeaveRequestDTOPageDTOOperationResult.fromJson(response.data);
    } catch (e) {
      return LeaveRequestDTOPageDTOOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<LeaveRequestDTOPageDTOOperationResult> getMyTeamLeaveRequests({
    int? pageNumber,
    int? pageSize,
    required MyTeamLeaveRequest filter,
  }) async {
    try {
      final response = await _client.post(
        Urls.getMyTeamLeaveRequests,
        queryParameters: {"pageSize": "$pageSize", "pageNumber": "$pageNumber"},
        data: {
          "employeesOrganizationEmails": filter.employeesOrganizationEmails,
          "leaveRequest": filter.leaveRequest,
          "directReporteesOnly": filter.directReporteesOnly,
          "from": filter.from!.toIso8601String(),
          "to": filter.to!.toIso8601String(),
        },
      );
      return LeaveRequestDTOPageDTOOperationResult.fromJson(response.data);
    } catch (e) {
      return LeaveRequestDTOPageDTOOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<LeaveRequestDTOPageDTOOperationResult> getEmployeeLeaveRequests({
    int? pageNumber,
    int? pageSize,
    required DateTime from,
    required DateTime to,
    String? employeeId,
  }) async {
    try {
      final response = await _client.post(
        Urls.getEmployeeLeaveRequests,
        queryParameters: {
          "pageNumber": "$pageNumber",
          "pageSize": pageSize,
        },
        data: {"employeeId": "$employeeId", "from": from.toIso8601String(), "to": to.toIso8601String()},
      );
      return LeaveRequestDTOPageDTOOperationResult.fromJson(response.data);
    } catch (e) {
      return LeaveRequestDTOPageDTOOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<LocationDTOListResponse> getActiveOffices() async {
    try {
      final response = await _client.get(
        Urls.getActiveOffices,
        queryParameters: {"pageSize": 2147483646},
      );
      return LocationDTOListResponse.fromJson(response.data);
    } catch (e) {
      return LocationDTOListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BasePaginatedResponseWrapper> getAllLocationsForAdmin({
    int? pageSize,
    int? pageNumber,
    AllLocationFilterRequest? filter,
  }) async {
    final response = await _client.post(
      Urls.getAllLocations,
      queryParameters: {"pageSize": "$pageSize", "pageNumber": "$pageNumber"},
      data: filter?.toJson() ?? {},
    );
    return BasePaginatedResponseWrapper.fromJson(response.data);
  }

  Future<BasePaginatedResponseWrapper> getAllLocationsForManager({
    int? pageSize,
    int? pageNumber,
    AllLocationFilterRequest? filter,
  }) async {
    final response = await _client.post(
      Urls.getMyTeamLocations,
      queryParameters: {"pageSize": "$pageSize", "pageNumber": "$pageNumber"},
      data: filter?.toJson() ?? {},
    );
    return BasePaginatedResponseWrapper.fromJson(response.data);
  }

  Future<AssignedShiftDTOResponse> getMyAssignedShift() async {
    try {
      final response = await _client.post(Urls.getMyAssignedShift);
      return AssignedShiftDTOResponse.fromJson(response.data);
    } catch (e) {
      return AssignedShiftDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<CheckInOutHistoryDTOResponse> getMyCheckInOutHistoryToday() async {
    try {
      final response = await _client.get(
        Urls.getMyCheckInOutHistoryToday,
      );
      return CheckInOutHistoryDTOResponse.fromJson(response.data);
    } catch (e) {
      return CheckInOutHistoryDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<CheckInOutHistoryDTOResponse> getMyCheckInOutHistory(DateTime from, DateTime to) async {
    try {
      final response = await _client.get(
        Urls.getMyCheckInOutHistory,
        queryParameters: {"from": "$from", "to": "$to"},
      );
      return CheckInOutHistoryDTOResponse.fromJson(response.data);
    } catch (e) {
      return CheckInOutHistoryDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<CheckInOutHistoryDTOResponse> getEmployeeCheckInOutHistory(
    String? employeeId,
    DateTime from,
    DateTime to,
  ) async {
    try {
      final response = await _client.get(
        Urls.getEmployeeCheckInOutHistory,
        queryParameters: {"employeeId": "$employeeId", "from": "$from", "to": "$to"},
      );
      print("object ${response.data}");
      return CheckInOutHistoryDTOResponse.fromJson(response.data);
    } catch (e) {
      return CheckInOutHistoryDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> deleteLocation(String? id) async {
    try {
      final response = await _client.delete(Urls.deleteLocation + "/$id");
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<LocationDTOResponse> createLocation(CreateLocationViewModel createLocationViewModel) async {
    try {
      final response = await _client.post(Urls.createLocation, data: createLocationViewModel.toJson());
      return LocationDTOResponse.fromJson(response.data);
    } catch (e) {
      return LocationDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<CheckInOutDTOResponse> checkInNew(GpsLocation gpsLocation, String? placeId) async {
    try {
      final response = await _client.post(
        Urls.checkInNew,
        data: {
          ...gpsLocation.toJson(),
          "placeId": placeId,
        },
      );
      return CheckInOutDTOResponse.fromJson(response.data);
    } catch (e) {
      return CheckInOutDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<CheckInOutDTOResponse> checkOutNew(GpsLocation gpsLocation, String? placeId) async {
    try {
      final response = await _client.post(
        Urls.checkOutNew,
        data: {
          ...gpsLocation.toJson(),
          "placeId": placeId,
        },
      );
      return CheckInOutDTOResponse.fromJson(response.data);
    } catch (e) {
      return CheckInOutDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<CheckInOutDTOResponse> forgetCheckOut() async {
    try {
      final response = await _client.post(Urls.forgetCheckOut);
      return CheckInOutDTOResponse.fromJson(response.data);
    } catch (e) {
      return CheckInOutDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  // Future<bool> keepAlive(GpsLocation gpsLocation) async {
  //   await ApiHelper.post(Urls.keepAlive, body: gpsLocation.toJson());
  //   return true;
  // }

  Future<NameValueDTOListResponse> getWorkspacePolicyTypes() async {
    try {
      final response = await _client.get(Urls.getEmployeeWorkspacePolicyTypes);
      return NameValueDTOListResponse.fromJson(response.data);
    } catch (e) {
      return NameValueDTOListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<NameValueDTOListResponse> getCountries() async {
    try {
      final response = await _client.get(Urls.getEmployeesCountries);
      return NameValueDTOListResponse.fromJson(response.data);
    } catch (e) {
      return NameValueDTOListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<NameValueDTOListResponse> getAttendancePolicyTypes() async {
    try {
      final response = await _client.get(Urls.getEmployeeAttendancePolicyTypes);
      return NameValueDTOListResponse.fromJson(response.data);
    } catch (e) {
      return NameValueDTOListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<EmployeeProfileDTOResponse> getEmployeeProfile(String employeeId) async {
    try {
      final response = await _client.get(Urls.getEmployeeProfile + "/$employeeId");
      return EmployeeProfileDTOResponse.fromJson(response.data);
    } catch (e) {
      return EmployeeProfileDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> updateEmployeeWorkspacePolicy(String employeeId, int workspacePolicy) async {
    try {
      final response = await _client.post(
        Urls.changeWorkspacePolicy,
        queryParameters: {"employeeId": "$employeeId", "workspacePolicy": "$workspacePolicy"},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> updateEmployeeCountry(String employeeId, int country) async {
    try {
      final response = await _client.post(
        Urls.changeEmployeeCountry,
        queryParameters: {"employeeId": "$employeeId", "country": "$country"},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> updateEmployeeAttendancePolicyPolicy(String employeeId, int attendancePolicy) async {
    try {
      final response = await _client.post(
        Urls.changeAttendancePolicy,
        queryParameters: {"employeeId": "$employeeId", "attendancePolicy": "$attendancePolicy"},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<ShiftDTOListResponse> getAllShifts() async {
    try {
      final response = await _client.get(Urls.getAllShifts);
      return ShiftDTOListResponse.fromJson(response.data);
    } catch (e) {
      return ShiftDTOListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<ShiftDTOResponse> createShift(ShiftDTO shift) async {
    try {
      final response = await _client.post(Urls.createShift, data: shift.toJson());
      return ShiftDTOResponse.fromJson(response.data);
    } catch (e) {
      return ShiftDTOResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<CycleHolidayResponse> createHoilday(CycleHoliday cycle) async {
    try {
      final response = await _client.post(Urls.createHoliday, data: cycle.toJson());

      return CycleHolidayResponse.fromJson(response.data);
    } catch (e) {
      return CycleHolidayResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<CycleHolidayResponse> updateHoilday({required String cycleId, required String holidayId, required String holidayName}) async {
    try {
      final response = await _client.put(Urls.updateHoliday, data: {"cycleId": cycleId, "holidayId": holidayId, "holidayName": holidayName});
      return CycleHolidayResponse.fromJson(response.data);
    } catch (e) {
      return CycleHolidayResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  // Future<HolidayDTOResponse> updateAnnouncement({
  //   String id,
  //   bool imageChanged,
  //   String imagePath,
  //   String title,
  //   String body,
  //   bool publish,
  //   bool sendNotification,
  // }) async {
  //   try {
  //     final options = Options();
  //     final file = await _createMultipartFile(options, filePath: imagePath);
  //     final formData = FormData.fromMap({
  //       "id": id,
  //       "imageChanged": imageChanged,
  //       "title": title?.trim(),
  //       "body": body?.trim(),
  //       "publish": publish ?? false,
  //       "sendNotification": sendNotification ?? false,
  //       "image": file,
  //     });
  //     final response = await _client.post(Urls.updateAnnouncement,
  //         data: formData, options: options);
  //     return AnnouncementDetailsResponse.fromJson(response.data);
  //   } catch (e) {
  //     return AnnouncementDetailsResponse.fromJson(getErrorResponse(e).toJson());
  //   }
  // }

  Future<BoolResponse> unPublishAnnouncement(String? id) async {
    try {
      final response = await _client.post(
        Urls.unPublishAnnouncement,
        queryParameters: {"announcementId": id},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> markAnnouncementAsRead(String? id) async {
    try {
      final response = await _client.post(
        Urls.markAnnouncementAsRead,
        queryParameters: {"announcementId": id},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<AnnouncementDetailsResponse> getAnnouncementDetails(String id) async {
    try {
      final response = await _client.get(Urls.getAnnouncementDetails + "/$id");
      return AnnouncementDetailsResponse.fromJson(response.data);
    } catch (e) {
      return AnnouncementDetailsResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> publishAnnouncement(String? id) async {
    try {
      final response = await _client.post(
        Urls.publishAnnouncement,
        queryParameters: {"announcementId": id},
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> setAsDefaultShift(String? shiftId) async {
    try {
      final response = await _client.get(Urls.setDefaultShift + "/$shiftId");
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> setAsDefaultCycle(String cycleId) async {
    try {
      final response = await _client.post(Urls.setDefaultCycle + "$cycleId");
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> deleteShift(String? shiftId) async {
    try {
      final response = await _client.get(Urls.deleteShift + "/$shiftId");
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> deleteCycle(String cycleId) async {
    try {
      final response = await _client.delete(Urls.deleteCycle + "?cycleId=$cycleId");
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> deleteCycleHoliday(String cycleId, String holidayId) async {
    try {
      final response = await _client.delete(Urls.deleteCycleHoliday, queryParameters: {"cycleId": "$cycleId", "holidayId": "$holidayId"});
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> updateEmployeeAssignedShift(String employeeId, String shiftId) async {
    try {
      final response = await _client.post(
        Urls.assignShift,
        data: {
          "employeeIds": ["$employeeId"],
          "shiftId": "$shiftId"
        },
      );
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<LocationDTOListResponse> getEmployeeLocations(String employeeId) async {
    try {
      final response = await _client.get(
        Urls.getEmployeeLocations,
        queryParameters: {"employeeId": "$employeeId", "pageSize": 2147483646},
      );
      return LocationDTOListResponse.fromJson(response.data);
    } catch (e) {
      return LocationDTOListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> approveLocation(String? locationId) async {
    try {
      final response = await _client.get(Urls.approveLocation + "/$locationId");
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> rejectLocation(String? locationId) async {
    try {
      final response = await _client.get(Urls.rejectLocation + "/$locationId");
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> submitWFHRequest() async {
    try {
      final response = await _client.post(Urls.submitWFHRequest);
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<AnnouncementDetailsResponse> createAnnouncement({
    String? imagePath,
    String? title,
    String? body,
    bool? publish,
    bool? sendNotification,
  }) async {
    try {
      final options = Options();
      final file = await _createMultipartFile(options, filePath: imagePath);
      final formData = FormData.fromMap({
        "title": title?.trim(),
        "body": body?.trim(),
        "publish": publish ?? false,
        "sendNotification": sendNotification ?? false,
        "image": file,
      });
      final response = await _client.post(Urls.createAnnouncement, data: formData, options: options);
      return AnnouncementDetailsResponse.fromJson(response.data);
    } catch (e) {
      return AnnouncementDetailsResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<AnnouncementDetailsResponse> updateAnnouncement({
    String? id,
    bool? imageChanged,
    String? imagePath,
    String? title,
    String? body,
    bool? publish,
    bool? sendNotification,
  }) async {
    try {
      final options = Options();
      final file = await _createMultipartFile(options, filePath: imagePath);
      final formData = FormData.fromMap({
        "id": id,
        "imageChanged": imageChanged,
        "title": title?.trim(),
        "body": body?.trim(),
        "publish": publish ?? false,
        "sendNotification": sendNotification ?? false,
        "image": file,
      });
      final response = await _client.post(Urls.updateAnnouncement, data: formData, options: options);
      return AnnouncementDetailsResponse.fromJson(response.data);
    } catch (e) {
      return AnnouncementDetailsResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> submitAnnualLeaveRequest() async {
    try {
      final response = await _client.post(Urls.submitAnnualLeaveRequest);
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> submitSickLeaveRequest() async {
    try {
      final response = await _client.post(Urls.submitSickLeaveRequest);
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> createNewEmergencyLeaveRequest(QuickLeaveEntity quickLeave) async {
    try {
      final response = await _client.post(Urls.createNewEmergencyLeaveRequest,
          data: {"from": quickLeave.from!.toIso8601String(), "to": quickLeave.to!.toIso8601String(), "reason": quickLeave.reason});
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> createAnnualLeaveRequest(QuickLeaveEntity quickLeave) async {
    try {
      final response = await _client.post(Urls.createNewAnnualLeaveRequest,
          data: {"from": quickLeave.from!.toIso8601String(), "to": quickLeave.to!.toIso8601String(), "reason": quickLeave.reason});
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> createHalfDayLeaveRequest(QuickLeaveEntity quickLeave) async {
    try {
      final response = await _client.post(Urls.createNewHalfDayLeaveRequest, data: {
        "from": quickLeave.from!.toIso8601String(),
        "to": quickLeave.to!.toIso8601String(),
        "reason": quickLeave.reason,
        "halfDayType": quickLeave.halfDayType
      });

      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<BoolResponse> createNewSickLeaveRequest(QuickLeaveEntity quickLeave) async {
    try {
      final options = Options();
      FormData formData;
      final files = <MultipartFile?>[];

      for (var file in quickLeave.imagePaths!) {
        final f = await _createMultipartFile(options, filePath: file);
        files.add(f);
      }
      formData = FormData.fromMap({
        "from": quickLeave.from,
        "to": quickLeave.to,
        "reason": quickLeave.reason,
        "uploadedFiles": files,
      });
      final response = await _client.post(Urls.createNewSickLeaveRequest, data: formData, options: options);
      return BoolResponse.fromJson(response.data);
    } catch (e) {
      return BoolResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<EmployeeBalancesDTOOperationResult> getMyBalances() async {
    try {
      final response = await _client.get(Urls.getMyBalances);
      return EmployeeBalancesDTOOperationResult.fromJson(response.data);
    } catch (e) {
      return EmployeeBalancesDTOOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<CalendarDtoResponse> getMyCalendar(int month, int year) async {
    try {
      final response = await _client.get(Urls.getMyCalendar + "?month=$month&year=$year");
      return CalendarDtoResponse.fromJson(response.data);
    } catch (e) {
      return CalendarDtoResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<EmployeeBalancesDTOOperationResult> getEmployeeBalances({String? employeeId}) async {
    try {
      final response = await _client.get(Urls.getEmployeeBalances + "/$employeeId");
      return EmployeeBalancesDTOOperationResult.fromJson(response.data);
    } catch (e) {
      return EmployeeBalancesDTOOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<EmployeeMinimizedDTOPageDTOOperationResult> getMyTeamMembersPaginated({
    int? pageNumber,
    int? pageSize,
    String? searchValue,
    bool? directReporteesOnly,
  }) async {
    try {
      final response = await _client.get(
        Urls.getMyTeamMembersPaginated,
        queryParameters: {
          "PageNumber": "$pageNumber",
          "PageSize": pageSize,
          "searchValue": searchValue,
          "DirectReporteesOnly": directReporteesOnly,
        },
      );
      return EmployeeMinimizedDTOPageDTOOperationResult.fromJson(response.data);
    } catch (e) {
      return EmployeeMinimizedDTOPageDTOOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<EmployeeMinimizedDTOPageDTOOperationResult> getAllEmployeesPaginated({
    int? pageNumber,
    int? pageSize,
    required EmployeesFilterationRequestDTO employeesFilterationRequest,
  }) async {
    try {
      final response = await _client.post(
        Urls.getAllEmployeesPaginated,
        data: employeesFilterationRequest.toJson(),
        queryParameters: {"PageNumber": "$pageNumber", "PageSize": pageSize},
      );
      return EmployeeMinimizedDTOPageDTOOperationResult.fromJson(response.data);
    } catch (e) {
      return EmployeeMinimizedDTOPageDTOOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<FileResponseOperationResult> downloadBase64File({
    String? requestId,
    String? fileId,
  }) async {
    try {
      final response = await _client.get(
        Urls.downloadBase64File,
        queryParameters: {
          "requestId": "$requestId",
          "fileId": "$fileId",
        },
      );
      return FileResponseOperationResult.fromJson(response.data);
    } catch (e) {
      return FileResponseOperationResult.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<AnnouncementListResponse> getAllAnnouncements({int? pageSize, int? pageNumber}) async {
    try {
      final response = await _client.post(Urls.getAllAnnouncements, queryParameters: {"pageSize": "$pageSize", "pageNumber": "$pageNumber"}, data: {});
      return AnnouncementListResponse.fromJson(response.data);
    } catch (e) {
      return AnnouncementListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<AnnouncementListResponse> getPublishedAnnouncements({int? pageSize, int? pageNumber}) async {
    try {
      final response = await _client.post(
        Urls.getPublishedAnnouncements,
        queryParameters: {"pageSize": "$pageSize", "pageNumber": "$pageNumber"},
      );
      return AnnouncementListResponse.fromJson(response.data);
    } catch (e) {
      return AnnouncementListResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<IntResponse> getUnreadAnnouncementsCount() async {
    try {
      final response = await _client.post(Urls.getUnreadAnnouncementsCount);
      return IntResponse.fromJson(response.data);
    } catch (e) {
      return IntResponse.fromJson(getErrorResponse(e).toJson());
    }
  }

  Future<MultipartFile?> _createMultipartFile(
    Options options, {
    String? filePath,
    String? filename,
    MediaType? contentType,
  }) async {
    ArgumentError.checkNotNull(options);
    MultipartFile? multiFile;
    if (filePath != null) {
      multiFile = await MultipartFile.fromFile(filePath, filename: filename, contentType: contentType);
      // final Map<String, String> allFiles =
      //     options.extra[extraFilesPathKey] ?? {};
      // allFiles[multiFile.filename] = filePath;
      // options.extra[extraFilesPathKey] = allFiles;
    }
    return multiFile;
  }

  static BaseAPIResponse getErrorResponse(dynamic e) {
    if (e is DioError) {
      try {
        return BaseAPIResponse.fromJson(e.response!.data);
      } catch (_) {}
    }
    printIfDebug(e.toString());
    return BaseAPIResponse(status: false);
  }
}
