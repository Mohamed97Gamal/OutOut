import 'package:flairstechsuite_mobile/enums/day_of_week.dart';
import 'package:flairstechsuite_mobile/enums/location_status.dart';
import 'package:flairstechsuite_mobile/features/announcement/data/model/announcement_dto.dart';
import 'package:flairstechsuite_mobile/models/api/paginated_responses.dart';
import 'package:flairstechsuite_mobile/models/employee_balance_dto.dart';
import 'package:flairstechsuite_mobile/models/file_dto.dart';
import 'package:flairstechsuite_mobile/models/organization_dto.dart';
import 'package:flairstechsuite_mobile/models/organization_full_dto.dart';
import 'package:flairstechsuite_mobile/utils/common.dart';
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseAPIResponse {
  final bool status;
  final String? errorMessage;
  final List<String>? errors;

  const BaseAPIResponse({bool? status, this.errorMessage, this.errors}) : status = status ?? false;

  factory BaseAPIResponse.fromJson(Map<String, dynamic> json) => _$BaseAPIResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseAPIResponseToJson(this);
}

@JsonSerializable()
class BoolResponse extends BaseAPIResponse {
  final bool? result;

  const BoolResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory BoolResponse.fromJson(Map<String, dynamic> json) => _$BoolResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BoolResponseToJson(this);
}

@JsonSerializable()
class StringResponse extends BaseAPIResponse {
  final String? result;

  const StringResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory StringResponse.fromJson(Map<String, dynamic> json) => _$StringResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StringResponseToJson(this);
}

@JsonSerializable()
class ListStringResponse extends BaseAPIResponse {
  final List<String>? result;

  const ListStringResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory ListStringResponse.fromJson(Map<String, dynamic> json) => _$ListStringResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ListStringResponseToJson(this);
}

@JsonSerializable()
class IntResponse extends BaseAPIResponse {
  final int? result;

  const IntResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory IntResponse.fromJson(Map<String, dynamic> json) => _$IntResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IntResponseToJson(this);
}

@JsonSerializable()
class AnnouncementDetailsResponse extends BaseAPIResponse {
  final AnnouncementDTO? result;

  const AnnouncementDetailsResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory AnnouncementDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementDetailsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AnnouncementDetailsResponseToJson(this);
}

@JsonSerializable()
class OrganizationFullDTOListResponse extends BaseAPIResponse {
  final List<OrganizationFullDTO>? result;

  const OrganizationFullDTOListResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory OrganizationFullDTOListResponse.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFullDTOListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrganizationFullDTOListResponseToJson(this);
}

@JsonSerializable()
class OrganizationFullDTOResponse extends BaseAPIResponse {
  final OrganizationFullDTO? result;

  const OrganizationFullDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory OrganizationFullDTOResponse.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFullDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrganizationFullDTOResponseToJson(this);
}

@JsonSerializable()
class OrganizationDTOResponse extends BaseAPIResponse {
  final OrganizationDTO? result;

  const OrganizationDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory OrganizationDTOResponse.fromJson(Map<String, dynamic> json) => _$OrganizationDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrganizationDTOResponseToJson(this);
}

@JsonSerializable()
class OrganizationDTOListResponse extends BaseAPIResponse {
  final List<OrganizationDTO>? result;

  const OrganizationDTOListResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory OrganizationDTOListResponse.fromJson(Map<String, dynamic> json) =>
      _$OrganizationDTOListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrganizationDTOListResponseToJson(this);
}

@JsonSerializable()
class DepartmentDTO {
  final String? id;
  final String? name;

  const DepartmentDTO({this.id, this.name});

  factory DepartmentDTO.fromJson(Map<String, dynamic> json) => _$DepartmentDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentDTOToJson(this);
}

@JsonSerializable()
class ApplicationUserRoleDTO {
  final String? roleName;
  final String? organizationName;

  const ApplicationUserRoleDTO({this.roleName, this.organizationName});

  factory ApplicationUserRoleDTO.fromJson(Map<String, dynamic> json) => _$ApplicationUserRoleDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationUserRoleDTOToJson(this);
}

@JsonSerializable()
class UpdateDepartmentViewModel {
  final String? id;
  final String? name;

  const UpdateDepartmentViewModel({this.id, this.name});

  factory UpdateDepartmentViewModel.fromJson(Map<String, dynamic> json) => _$UpdateDepartmentViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDepartmentViewModelToJson(this);
}

@JsonSerializable()
class DepartmentDTOListResponse extends BaseAPIResponse {
  final List<DepartmentDTO>? result;

  const DepartmentDTOListResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory DepartmentDTOListResponse.fromJson(Map<String, dynamic> json) => _$DepartmentDTOListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DepartmentDTOListResponseToJson(this);
}

@JsonSerializable()
class DepartmentDTOResponse extends BaseAPIResponse {
  final DepartmentDTO? result;

  const DepartmentDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory DepartmentDTOResponse.fromJson(Map<String, dynamic> json) => _$DepartmentDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DepartmentDTOResponseToJson(this);
}

@JsonSerializable()
class CreateAdminViewModel {
  final String? email;
  final String? fullName;
  final String? organizationId;

  const CreateAdminViewModel({this.fullName, this.email, this.organizationId});

  factory CreateAdminViewModel.fromJson(Map<String, dynamic> json) => _$CreateAdminViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAdminViewModelToJson(this);
}

@JsonSerializable()
class CreateDepartmentViewModel {
  final String? organizationId;
  final String? name;

  const CreateDepartmentViewModel({this.organizationId, this.name});

  factory CreateDepartmentViewModel.fromJson(Map<String, dynamic> json) => _$CreateDepartmentViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateDepartmentViewModelToJson(this);
}

@JsonSerializable()
class LoginResultDTO {
  final String? token;
  final String? employeeId;
  final String? fullName;
  final bool? isSuperAdmin;
  final bool? isAdmin;
  final String? refreshToken;
  final DateTime? refreshTokenExpiration;
  final bool? isManager;
  final String? organizationId;
  final bool? isVerifiedEmail;
  final DateTime? expiration;

  LoginResultDTO({
    this.token,
    this.employeeId,
    String? fullName,
    this.refreshToken,
    this.refreshTokenExpiration,
    this.isSuperAdmin,
    this.isAdmin,
    this.isManager,
    this.organizationId,
    this.isVerifiedEmail,
    this.expiration,
  }) : fullName = nullIfEmpty(fullName);

  factory LoginResultDTO.fromJson(Map<String, dynamic> json) => _$LoginResultDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultDTOToJson(this);
}

@JsonSerializable()
class LoginResultDTOResponse extends BaseAPIResponse {
  final LoginResultDTO? result;
  @JsonKey(ignore: true)
  int? responseCode;

  LoginResultDTOResponse({
    bool? status,
    this.result,
    this.responseCode,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory LoginResultDTOResponse.fromJson(Map<String, dynamic> json) => _$LoginResultDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginResultDTOResponseToJson(this);
}

@JsonSerializable()
class AdminsListDTOResponse extends BaseAPIResponse {
  final List<AdminDTO>? result;

  const AdminsListDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory AdminsListDTOResponse.fromJson(Map<String, dynamic> json) => _$AdminsListDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminsListDTOResponseToJson(this);
}

@JsonSerializable()
class AdminDTOResponse extends BaseAPIResponse {
  final AdminDTO? result;

  const AdminDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory AdminDTOResponse.fromJson(Map<String, dynamic> json) => _$AdminDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminDTOResponseToJson(this);
}

@JsonSerializable()
class AdminDTO {
  final EmployeeProfileDTO? admin;
  final String? organizationId;
  final String? organizationName;

  AdminDTO({
    this.admin,
    this.organizationId,
    String? organizationName,
  }) : organizationName = nullIfEmpty(organizationName);

  factory AdminDTO.fromJson(Map<String, dynamic> json) => _$AdminDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AdminDTOToJson(this);
}

@JsonSerializable()
class EmployeeProfileDTO {
  final String? id;
  final String? applicationUserId;
  final String? title;
  final String? fullName;
  final String? mobile;
  final int? source;
  final String? profileImagePath;
  final bool? active;
  final int? yearOfBirth;
  final bool? isManager;
  final String? organizationEmail;
  final String? managerId;
  final String? managerName;
  final bool? isAdmin;
  final DateTime? employmentDate;
  final bool? useTenroxTasksFeature;
  final bool? useTenroxCheckInOutFeature;
  final DateTime? modifiedDate;
  final int? workspacePolicy;
  final int? attendancePolicy;
  final int? currentTaskId;
  final DateTime? startedOn;
  final AssignedShiftDTO? assignedShift;
  final int? country;

  EmployeeProfileDTO(
    this.country, {
    this.id,
    this.applicationUserId,
    String? title,
    String? fullName,
    String? mobile,
    this.isManager,
    this.source,
    String? profileImagePath,
    this.active,
    this.yearOfBirth,
    String? organizationEmail,
    String? managerId,
    String? managerName,
    this.isAdmin,
    this.employmentDate,
    this.useTenroxTasksFeature,
    this.useTenroxCheckInOutFeature,
    this.modifiedDate,
    this.workspacePolicy,
    this.attendancePolicy,
    this.currentTaskId,
    this.startedOn,
    this.assignedShift,
  })  : title = nullIfEmpty(title),
        fullName = nullIfEmpty(fullName),
        managerId = nullIfEmpty(managerId),
        mobile = nullIfEmpty(mobile),
        organizationEmail = nullIfEmpty(organizationEmail),
        managerName = nullIfEmpty(managerName),
        profileImagePath = nullIfEmpty(profileImagePath);

  factory EmployeeProfileDTO.fromJson(Map<String, dynamic> json) => _$EmployeeProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeProfileDTOToJson(this);
}

@JsonSerializable()
class EmployeeProfileDTOResponse extends BaseAPIResponse {
  final EmployeeProfileDTO? result;

  const EmployeeProfileDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory EmployeeProfileDTOResponse.fromJson(Map<String, dynamic> json) => _$EmployeeProfileDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EmployeeProfileDTOResponseToJson(this);
}

@JsonSerializable()
class SettingsDTO {
  final String? id;
  final String? authenticatedBy;
  final int? minimumTaskTime;
  final String? adPath;
  final String? adfsPath;
  final bool? allowManualCheckInOut;
  final bool? allowAutomaticCheckInOut;
  final int? locationRadius;
  final String? authenticationPath;
  final bool? useTenroxTasksFeature;
  final bool? useTenroxCheckInOutFeature;
  final String? regionTimeZoneName;
  final int? maxLocations;
  final int? checkOutReminderMargin;

  const SettingsDTO({
    this.id,
    this.authenticatedBy,
    this.minimumTaskTime,
    this.adPath,
    this.checkOutReminderMargin,
    this.adfsPath,
    this.allowManualCheckInOut,
    this.allowAutomaticCheckInOut,
    this.locationRadius,
    this.authenticationPath,
    this.useTenroxTasksFeature,
    this.useTenroxCheckInOutFeature,
    this.regionTimeZoneName,
    this.maxLocations,
  });

  factory SettingsDTO.fromJson(Map<String, dynamic> json) => _$SettingsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsDTOToJson(this);
}

@JsonSerializable()
class SettingsDTOResponse extends BaseAPIResponse {
  final SettingsDTO? result;

  const SettingsDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory SettingsDTOResponse.fromJson(Map<String, dynamic> json) => _$SettingsDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SettingsDTOResponseToJson(this);
}

@JsonSerializable()
class EmployeeBalancesDTOOperationResult extends BaseAPIResponse {
  final EmployeeBalanceDTO? result;

  const EmployeeBalancesDTOOperationResult({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory EmployeeBalancesDTOOperationResult.fromJson(Map<String, dynamic> json) =>
      _$EmployeeBalancesDTOOperationResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EmployeeBalancesDTOOperationResultToJson(this);
}

@JsonSerializable()
class FileResponseOperationResult extends BaseAPIResponse {
  final FilerResponse? result;

  const FileResponseOperationResult({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory FileResponseOperationResult.fromJson(Map<String, dynamic> json) =>
      _$FileResponseOperationResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FileResponseOperationResultToJson(this);
}

@JsonSerializable()
class TenroxTaskDTO {
  final int? id;
  final int? uniqueId;
  final String? taskTitle;
  final String? taskDescription;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? workflowEntryId;
  final int? etc;
  final bool? isAssignmentCompleted;
  final int? userId;
  final bool? isRunning;
  final DateTime? startedOn;

  TenroxTaskDTO({
    this.id,
    this.uniqueId,
    String? taskTitle,
    String? taskDescription,
    this.startDate,
    this.endDate,
    this.workflowEntryId,
    this.etc,
    this.isRunning,
    this.isAssignmentCompleted,
    this.userId,
    this.startedOn,
  })  : taskTitle = nullIfEmpty(taskTitle),
        taskDescription = nullIfEmpty(taskDescription);

  factory TenroxTaskDTO.fromJson(Map<String, dynamic> json) => _$TenroxTaskDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TenroxTaskDTOToJson(this);
}

@JsonSerializable()
class TenroxTaskDTOListResponse extends BaseAPIResponse {
  final List<TenroxTaskDTO>? result;

  const TenroxTaskDTOListResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory TenroxTaskDTOListResponse.fromJson(Map<String, dynamic> json) => _$TenroxTaskDTOListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TenroxTaskDTOListResponseToJson(this);
}

@JsonSerializable()
class MyOrgAdminListResponse extends BaseAPIResponse {
  final List<EmployeeProfileDTO>? result;

  const MyOrgAdminListResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory MyOrgAdminListResponse.fromJson(Map<String, dynamic> json) => _$MyOrgAdminListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MyOrgAdminListResponseToJson(this);
}

@JsonSerializable()
class MyTeamMembersListResponse extends BaseAPIResponse {
  final List<EmployeeProfileDTO>? result;

  const MyTeamMembersListResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory MyTeamMembersListResponse.fromJson(Map<String, dynamic> json) => _$MyTeamMembersListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MyTeamMembersListResponseToJson(this);
}

@JsonSerializable()
class AllEmployeesListResponse extends BaseAPIResponse {
  final List<EmployeeProfileDTO>? result;

  const AllEmployeesListResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory AllEmployeesListResponse.fromJson(Map<String, dynamic> json) => _$AllEmployeesListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AllEmployeesListResponseToJson(this);
}

@JsonSerializable()
class LocationDTO {
  final String? id;
  final String? name;
  final double? longitude;
  final double? latitude;
  final double? radius;
  final LocationStatus? status;
  final EmployeeProfileDTO? employee;

  LocationDTO({
    this.id,
    String? name,
    this.longitude,
    this.latitude,
    this.radius,
    this.status,
    this.employee,
  }) : name = nullIfEmpty(name);

  factory LocationDTO.fromJson(Map<String, dynamic> json) => _$LocationDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDTOToJson(this);
}

@JsonSerializable()
class LeaveRequestDTOPageDTOOperationResult extends BaseAPIResponse {
  final LeaveRequestDTOPageDTO? result;

  const LeaveRequestDTOPageDTOOperationResult({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory LeaveRequestDTOPageDTOOperationResult.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestDTOPageDTOOperationResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LeaveRequestDTOPageDTOOperationResultToJson(this);
}

@JsonSerializable()
class EmployeeMinimizedDTOPageDTOOperationResult extends BaseAPIResponse {
  final EmployeeMinimizedDTOPageDTO? result;

  const EmployeeMinimizedDTOPageDTOOperationResult({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory EmployeeMinimizedDTOPageDTOOperationResult.fromJson(Map<String, dynamic> json) =>
      _$EmployeeMinimizedDTOPageDTOOperationResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EmployeeMinimizedDTOPageDTOOperationResultToJson(this);
}

@JsonSerializable()
class LocationDTOListResponse extends BaseAPIResponse {
  final PaginatedLocationDTOList? result;

  const LocationDTOListResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory LocationDTOListResponse.fromJson(Map<String, dynamic> json) => _$LocationDTOListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocationDTOListResponseToJson(this);
}

@JsonSerializable()
class LocationRequestDTO {
  final String? employeeId;
  final List<LocationDTO>? locations;

  const LocationRequestDTO({this.employeeId, this.locations});

  factory LocationRequestDTO.fromJson(Map<String, dynamic> json) => _$LocationRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LocationRequestDTOToJson(this);
}

@JsonSerializable()
class AnnouncementListResponse extends BaseAPIResponse {
  final PaginatedAnnouncementDTOList? result;

  const AnnouncementListResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory AnnouncementListResponse.fromJson(Map<String, dynamic> json) => _$AnnouncementListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AnnouncementListResponseToJson(this);
}

@JsonSerializable()
class LocationDTOResponse extends BaseAPIResponse {
  final LocationDTO? result;

  const LocationDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory LocationDTOResponse.fromJson(Map<String, dynamic> json) => _$LocationDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocationDTOResponseToJson(this);
}

@JsonSerializable()
class CreateLocationViewModel {
  final String? name;
  final double? longitude;
  final double? latitude;

  const CreateLocationViewModel({this.name, this.longitude, this.latitude});

  factory CreateLocationViewModel.fromJson(Map<String, dynamic> json) => _$CreateLocationViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateLocationViewModelToJson(this);

  CreateLocationViewModel copyWith({String? name, double? longitude, double? latitude}) {
    return CreateLocationViewModel(
      name: name ?? this.name,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }
}

@JsonSerializable()
class GpsLocation {
  final double? longitude;
  final double? latitude;

  const GpsLocation({this.longitude, this.latitude});

  factory GpsLocation.fromJson(Map<String, dynamic> json) => _$GpsLocationFromJson(json);

  Map<String, dynamic> toJson() => _$GpsLocationToJson(this);
}

@JsonSerializable()
class AssignShiftMultipleResponse extends BaseAPIResponse {
  final List<String>? result;

  const AssignShiftMultipleResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory AssignShiftMultipleResponse.fromJson(Map<String, dynamic> json) =>
      _$AssignShiftMultipleResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AssignShiftMultipleResponseToJson(this);
}

@JsonSerializable()
class AssignedShiftDTOResponse extends BaseAPIResponse {
  final AssignedShiftDTO? result;

  const AssignedShiftDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory AssignedShiftDTOResponse.fromJson(Map<String, dynamic> json) => _$AssignedShiftDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AssignedShiftDTOResponseToJson(this);
}

@JsonSerializable()
class AssignedShiftDTO {
  final String? shiftId;
  final String? shiftName;
  final int? shiftFromHour;
  final int? shiftFromMinutes;
  final int? shiftToHour;
  final int? shiftToMinutes;
  final int? shiftWorkingHoursInMinutes;
  final List<DayOfWeek?>? weekDays;

  const AssignedShiftDTO({
    this.shiftId,
    this.shiftName,
    this.shiftFromHour,
    this.shiftFromMinutes,
    this.shiftToHour,
    this.shiftToMinutes,
    this.shiftWorkingHoursInMinutes,
    this.weekDays,
  });

  factory AssignedShiftDTO.fromJson(Map<String, dynamic> json) => _$AssignedShiftDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AssignedShiftDTOToJson(this);
}

@JsonSerializable()
class NameValueDTO {
  final String? name;
  final int? value;

  const NameValueDTO({this.name, this.value});

  factory NameValueDTO.fromJson(Map<String, dynamic> json) => _$NameValueDTOFromJson(json);

  Map<String, dynamic> toJson() => _$NameValueDTOToJson(this);
}

@JsonSerializable()
class NameValueDTOListResponse extends BaseAPIResponse {
  final List<NameValueDTO>? result;

  const NameValueDTOListResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory NameValueDTOListResponse.fromJson(Map<String, dynamic> json) => _$NameValueDTOListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NameValueDTOListResponseToJson(this);
}

@JsonSerializable()
class ShiftDTO {
  final String? id;
  final String? name;
  final int? fromHour;
  final int? fromMinutes;
  final int? toHour;
  final int? toMinutes;
  final int? workingHoursInMinutes;
  final bool? isDefault;
  final List<DayOfWeek?>? weekDays;

  ShiftDTO({
    this.id,
    String? name,
    this.fromHour,
    this.fromMinutes,
    this.toHour,
    this.toMinutes,
    this.workingHoursInMinutes,
    this.isDefault,
    this.weekDays,
  }) : name = nullIfEmpty(name);

  factory ShiftDTO.fromJson(Map<String, dynamic> json) => _$ShiftDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftDTOToJson(this);
}

@JsonSerializable()
class ShiftMultipleAssigneesDTOOperationResult extends BaseAPIResponse {
  final ShiftMultipleAssigneesDTO? result;

  const ShiftMultipleAssigneesDTOOperationResult({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory ShiftMultipleAssigneesDTOOperationResult.fromJson(Map<String, dynamic> json) =>
      _$ShiftMultipleAssigneesDTOOperationResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShiftMultipleAssigneesDTOOperationResultToJson(this);
}

@JsonSerializable()
class ShiftMultipleAssigneesDTO {
  final String? shiftName;
  final List<String>? failedEmployeesNames;

  ShiftMultipleAssigneesDTO({
    this.shiftName,
    this.failedEmployeesNames,
  });

  factory ShiftMultipleAssigneesDTO.fromJson(Map<String, dynamic> json) => _$ShiftMultipleAssigneesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftMultipleAssigneesDTOToJson(this);
}

@JsonSerializable()
class ShiftDTOResponse extends BaseAPIResponse {
  final ShiftDTO? result;

  const ShiftDTOResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory ShiftDTOResponse.fromJson(Map<String, dynamic> json) => _$ShiftDTOResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShiftDTOResponseToJson(this);
}

@JsonSerializable()
class ShiftDTOListResponse extends BaseAPIResponse {
  final List<ShiftDTO>? result;

  const ShiftDTOListResponse({
    bool? status,
    this.result,
    String? errorMessage,
    List<String>? errors,
  }) : super(
          status: status,
          errors: errors,
          errorMessage: errorMessage,
        );

  factory ShiftDTOListResponse.fromJson(Map<String, dynamic> json) => _$ShiftDTOListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShiftDTOListResponseToJson(this);
}

@JsonSerializable()
class MyUserDetailsResponse extends BaseAPIResponse {
  final int? organizationId;
  final int? employeeId;
  final String? fullName;
  final List<String>? employeeRoles;

  MyUserDetailsResponse({
    this.organizationId,
    this.employeeId,
    this.fullName,
    this.employeeRoles,
  });

  factory MyUserDetailsResponse.fromJson(Map<String, dynamic> json) => _$MyUserDetailsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MyUserDetailsResponseToJson(this);
}
