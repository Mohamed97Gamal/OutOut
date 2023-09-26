// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseAPIResponse _$BaseAPIResponseFromJson(Map<String, dynamic> json) {
  return BaseAPIResponse(
    status: json['status'] as bool,
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$BaseAPIResponseToJson(BaseAPIResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
    };

BoolResponse _$BoolResponseFromJson(Map<String, dynamic> json) {
  return BoolResponse(
    status: json['status'] as bool,
    result: json['result'] as bool?,
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$BoolResponseToJson(BoolResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

StringResponse _$StringResponseFromJson(Map<String, dynamic> json) {
  return StringResponse(
    status: json['status'] as bool,
    result: json['result'] as String,
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$StringResponseToJson(StringResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

ListStringResponse _$ListStringResponseFromJson(Map<String, dynamic> json) {
  return ListStringResponse(
    status: json['status'] as bool,
    result: (json['result'] as List)?.map((e) => e as String)?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ListStringResponseToJson(ListStringResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

IntResponse _$IntResponseFromJson(Map<String, dynamic> json) {
  return IntResponse(
    status: json['status'] as bool?,
    result: json['result'] as int?,
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$IntResponseToJson(IntResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

AnnouncementDetailsResponse _$AnnouncementDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return AnnouncementDetailsResponse(
    status: json['status'] as bool,
    result: json['result'] == null
        ? null
        : AnnouncementDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AnnouncementDetailsResponseToJson(
        AnnouncementDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

OrganizationFullDTOListResponse _$OrganizationFullDTOListResponseFromJson(
    Map<String, dynamic> json) {
  return OrganizationFullDTOListResponse(
    status: json['status'] as bool?,
    result: (json['result'] as List?)
        ?.map((e) => OrganizationFullDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$OrganizationFullDTOListResponseToJson(
        OrganizationFullDTOListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

OrganizationFullDTOResponse _$OrganizationFullDTOResponseFromJson(
    Map<String, dynamic> json) {
  return OrganizationFullDTOResponse(
    status: json['status'] as bool,
    result: json['result'] == null
        ? null
        : OrganizationFullDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$OrganizationFullDTOResponseToJson(
        OrganizationFullDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

OrganizationDTOResponse _$OrganizationDTOResponseFromJson(
    Map<String, dynamic> json) {
  return OrganizationDTOResponse(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : OrganizationDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$OrganizationDTOResponseToJson(
        OrganizationDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

OrganizationDTOListResponse _$OrganizationDTOListResponseFromJson(
    Map<String, dynamic> json) {
  return OrganizationDTOListResponse(
    status: json['status'] as bool?,
    result: (json['result'] as List?)
        ?.map((e) => OrganizationDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$OrganizationDTOListResponseToJson(
        OrganizationDTOListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

DepartmentDTO _$DepartmentDTOFromJson(Map<String, dynamic> json) {
  return DepartmentDTO(
    id: json['id'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$DepartmentDTOToJson(DepartmentDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ApplicationUserRoleDTO _$ApplicationUserRoleDTOFromJson(
    Map<String, dynamic> json) {
  return ApplicationUserRoleDTO(
    roleName: json['roleName'] as String,
    organizationName: json['organizationName'] as String,
  );
}

Map<String, dynamic> _$ApplicationUserRoleDTOToJson(
        ApplicationUserRoleDTO instance) =>
    <String, dynamic>{
      'roleName': instance.roleName,
      'organizationName': instance.organizationName,
    };

UpdateDepartmentViewModel _$UpdateDepartmentViewModelFromJson(
    Map<String, dynamic> json) {
  return UpdateDepartmentViewModel(
    id: json['id'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$UpdateDepartmentViewModelToJson(
        UpdateDepartmentViewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

DepartmentDTOListResponse _$DepartmentDTOListResponseFromJson(
    Map<String, dynamic> json) {
  return DepartmentDTOListResponse(
    status: json['status'] as bool?,
    result: (json['result'] as List?)
        ?.map((e) => DepartmentDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$DepartmentDTOListResponseToJson(
        DepartmentDTOListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

DepartmentDTOResponse _$DepartmentDTOResponseFromJson(
    Map<String, dynamic> json) {
  return DepartmentDTOResponse(
    status: json['status'] as bool,
    result: json['result'] == null
        ? null
        : DepartmentDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$DepartmentDTOResponseToJson(
        DepartmentDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

CreateAdminViewModel _$CreateAdminViewModelFromJson(Map<String, dynamic> json) {
  return CreateAdminViewModel(
    fullName: json['fullName'] as String,
    email: json['email'] as String,
    organizationId: json['organizationId'] as String,
  );
}

Map<String, dynamic> _$CreateAdminViewModelToJson(
        CreateAdminViewModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'fullName': instance.fullName,
      'organizationId': instance.organizationId,
    };

CreateDepartmentViewModel _$CreateDepartmentViewModelFromJson(
    Map<String, dynamic> json) {
  return CreateDepartmentViewModel(
    organizationId: json['organizationId'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CreateDepartmentViewModelToJson(
        CreateDepartmentViewModel instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'name': instance.name,
    };

LoginResultDTO _$LoginResultDTOFromJson(Map<String, dynamic> json) {
  return LoginResultDTO(
    token: json['token'] as String,
    employeeId: json['employeeId'] as String,
    fullName: json['fullName'] as String,
    refreshToken: json['refreshToken'] as String,
    refreshTokenExpiration: json['refreshTokenExpiration'] == null
        ? null
        : DateTime.parse(json['refreshTokenExpiration'] as String),
    isSuperAdmin: json['isSuperAdmin'] as bool,
    isAdmin: json['isAdmin'] as bool,
    isManager: json['isManager'] as bool,
    organizationId: json['organizationId'] as String,
    isVerifiedEmail: json['isVerifiedEmail'] as bool,
    expiration: json['expiration'] == null
        ? null
        : DateTime.parse(json['expiration'] as String),
  );
}

Map<String, dynamic> _$LoginResultDTOToJson(LoginResultDTO instance) =>
    <String, dynamic>{
      'token': instance.token,
      'employeeId': instance.employeeId,
      'fullName': instance.fullName,
      'isSuperAdmin': instance.isSuperAdmin,
      'isAdmin': instance.isAdmin,
      'refreshToken': instance.refreshToken,
      'refreshTokenExpiration':
          instance.refreshTokenExpiration?.toIso8601String(),
      'isManager': instance.isManager,
      'organizationId': instance.organizationId,
      'isVerifiedEmail': instance.isVerifiedEmail,
      'expiration': instance.expiration?.toIso8601String(),
    };

LoginResultDTOResponse _$LoginResultDTOResponseFromJson(
    Map<String, dynamic> json) {
  return LoginResultDTOResponse(
    status: json['status'] as bool,
    result: json['result'] == null
        ? null
        : LoginResultDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$LoginResultDTOResponseToJson(
        LoginResultDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

AdminsListDTOResponse _$AdminsListDTOResponseFromJson(
    Map<String, dynamic> json) {
  return AdminsListDTOResponse(
    status: json['status'] as bool?,
    result: (json['result'] as List?)
        ?.map((e) => AdminDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AdminsListDTOResponseToJson(
        AdminsListDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

AdminDTOResponse _$AdminDTOResponseFromJson(Map<String, dynamic> json) {
  return AdminDTOResponse(
    status: json['status'] as bool,
    result: json['result'] == null
        ? null
        : AdminDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AdminDTOResponseToJson(AdminDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

AdminDTO _$AdminDTOFromJson(Map<String, dynamic> json) {
  return AdminDTO(
    admin: json['admin'] == null
        ? null
        : EmployeeProfileDTO.fromJson(json['admin'] as Map<String, dynamic>),
    organizationId: json['organizationId'] as String,
    organizationName: json['organizationName'] as String,
  );
}

Map<String, dynamic> _$AdminDTOToJson(AdminDTO instance) => <String, dynamic>{
      'admin': instance.admin,
      'organizationId': instance.organizationId,
      'organizationName': instance.organizationName,
    };

EmployeeProfileDTO _$EmployeeProfileDTOFromJson(Map<String, dynamic> json) {
  return EmployeeProfileDTO(
    json['country'] as int?,
    id: json['id'] as String?,
    applicationUserId: json['applicationUserId'] as String?,
    title: json['title'] as String?,
    fullName: json['fullName'] as String?,
    mobile: json['mobile'] as String?,
    isManager: json['isManager'] as bool?,
    source: json['source'] as int?,
    profileImagePath: json['profileImagePath'] as String?,
    active: json['active'] as bool?,
    yearOfBirth: json['yearOfBirth'] as int?,
    organizationEmail: json['organizationEmail'] as String?,
    managerId: json['managerId'] as String?,
    managerName: json['managerName'] as String?,
    isAdmin: json['isAdmin'] as bool?,
    employmentDate: json['employmentDate'] == null
        ? null
        : DateTime.parse(json['employmentDate'] as String),
    useTenroxTasksFeature: json['useTenroxTasksFeature'] as bool?,
    useTenroxCheckInOutFeature: json['useTenroxCheckInOutFeature'] as bool?,
    modifiedDate: json['modifiedDate'] == null
        ? null
        : DateTime.parse(json['modifiedDate'] as String),
    workspacePolicy: json['workspacePolicy'] as int?,
    attendancePolicy: json['attendancePolicy'] as int?,
    currentTaskId: json['currentTaskId'] as int?,
    startedOn: json['startedOn'] == null
        ? null
        : DateTime.parse(json['startedOn'] as String),
    assignedShift: json['assignedShift'] == null
        ? null
        : AssignedShiftDTO.fromJson(
            json['assignedShift'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EmployeeProfileDTOToJson(EmployeeProfileDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'applicationUserId': instance.applicationUserId,
      'title': instance.title,
      'fullName': instance.fullName,
      'mobile': instance.mobile,
      'source': instance.source,
      'profileImagePath': instance.profileImagePath,
      'active': instance.active,
      'yearOfBirth': instance.yearOfBirth,
      'isManager': instance.isManager,
      'organizationEmail': instance.organizationEmail,
      'managerId': instance.managerId,
      'managerName': instance.managerName,
      'isAdmin': instance.isAdmin,
      'employmentDate': instance.employmentDate?.toIso8601String(),
      'useTenroxTasksFeature': instance.useTenroxTasksFeature,
      'useTenroxCheckInOutFeature': instance.useTenroxCheckInOutFeature,
      'modifiedDate': instance.modifiedDate?.toIso8601String(),
      'workspacePolicy': instance.workspacePolicy,
      'attendancePolicy': instance.attendancePolicy,
      'currentTaskId': instance.currentTaskId,
      'startedOn': instance.startedOn?.toIso8601String(),
      'assignedShift': instance.assignedShift,
      'country': instance.country,
    };

EmployeeProfileDTOResponse _$EmployeeProfileDTOResponseFromJson(
    Map<String, dynamic> json) {
  return EmployeeProfileDTOResponse(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : EmployeeProfileDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$EmployeeProfileDTOResponseToJson(
        EmployeeProfileDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

SettingsDTO _$SettingsDTOFromJson(Map<String, dynamic> json) {
  return SettingsDTO(
    id: json['id'] as String?,
    authenticatedBy: json['authenticatedBy'] as String?,
    minimumTaskTime: json['minimumTaskTime'] as int?,
    adPath: json['adPath'] as String?,
    checkOutReminderMargin: json['checkOutReminderMargin'] as int?,
    adfsPath: json['adfsPath'] as String?,
    allowManualCheckInOut: json['allowManualCheckInOut'] as bool?,
    allowAutomaticCheckInOut: json['allowAutomaticCheckInOut'] as bool?,
    locationRadius: json['locationRadius'] as int?,
    authenticationPath: json['authenticationPath'] as String?,
    useTenroxTasksFeature: json['useTenroxTasksFeature'] as bool?,
    useTenroxCheckInOutFeature: json['useTenroxCheckInOutFeature'] as bool?,
    regionTimeZoneName: json['regionTimeZoneName'] as String?,
    maxLocations: json['maxLocations'] as int?,
  );
}

Map<String, dynamic> _$SettingsDTOToJson(SettingsDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authenticatedBy': instance.authenticatedBy,
      'minimumTaskTime': instance.minimumTaskTime,
      'adPath': instance.adPath,
      'adfsPath': instance.adfsPath,
      'allowManualCheckInOut': instance.allowManualCheckInOut,
      'allowAutomaticCheckInOut': instance.allowAutomaticCheckInOut,
      'locationRadius': instance.locationRadius,
      'authenticationPath': instance.authenticationPath,
      'useTenroxTasksFeature': instance.useTenroxTasksFeature,
      'useTenroxCheckInOutFeature': instance.useTenroxCheckInOutFeature,
      'regionTimeZoneName': instance.regionTimeZoneName,
      'maxLocations': instance.maxLocations,
      'checkOutReminderMargin': instance.checkOutReminderMargin,
    };

SettingsDTOResponse _$SettingsDTOResponseFromJson(Map<String, dynamic> json) {
  return SettingsDTOResponse(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : SettingsDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$SettingsDTOResponseToJson(
        SettingsDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

EmployeeBalancesDTOOperationResult _$EmployeeBalancesDTOOperationResultFromJson(
    Map<String, dynamic> json) {
  return EmployeeBalancesDTOOperationResult(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : EmployeeBalanceDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$EmployeeBalancesDTOOperationResultToJson(
        EmployeeBalancesDTOOperationResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

FileResponseOperationResult _$FileResponseOperationResultFromJson(
    Map<String, dynamic> json) {
  return FileResponseOperationResult(
    status: json['status'] as bool,
    result: json['result'] == null
        ? null
        : FilerResponse.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FileResponseOperationResultToJson(
        FileResponseOperationResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

TenroxTaskDTO _$TenroxTaskDTOFromJson(Map<String, dynamic> json) {
  return TenroxTaskDTO(
    id: json['id'] as int?,
    uniqueId: json['uniqueId'] as int?,
    taskTitle: json['taskTitle'] as String?,
    taskDescription: json['taskDescription'] as String?,
    startDate: json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String),
    endDate: json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String),
    workflowEntryId: json['workflowEntryId'] as int?,
    etc: json['etc'] as int?,
    isRunning: json['isRunning'] as bool?,
    isAssignmentCompleted: json['isAssignmentCompleted'] as bool?,
    userId: json['userId'] as int?,
    startedOn: json['startedOn'] == null
        ? null
        : DateTime.parse(json['startedOn'] as String),
  );
}

Map<String, dynamic> _$TenroxTaskDTOToJson(TenroxTaskDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uniqueId': instance.uniqueId,
      'taskTitle': instance.taskTitle,
      'taskDescription': instance.taskDescription,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'workflowEntryId': instance.workflowEntryId,
      'etc': instance.etc,
      'isAssignmentCompleted': instance.isAssignmentCompleted,
      'userId': instance.userId,
      'isRunning': instance.isRunning,
      'startedOn': instance.startedOn?.toIso8601String(),
    };

TenroxTaskDTOListResponse _$TenroxTaskDTOListResponseFromJson(
    Map<String, dynamic> json) {
  return TenroxTaskDTOListResponse(
    status: json['status'] as bool?,
    result: (json['result'] as List?)
        ?.map((e) => TenroxTaskDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$TenroxTaskDTOListResponseToJson(
        TenroxTaskDTOListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

MyOrgAdminListResponse _$MyOrgAdminListResponseFromJson(
    Map<String, dynamic> json) {
  return MyOrgAdminListResponse(
    status: json['status'] as bool?,
    result: (json['result'] as List?)
        ?.map((e) =>  EmployeeProfileDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$MyOrgAdminListResponseToJson(
        MyOrgAdminListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

MyTeamMembersListResponse _$MyTeamMembersListResponseFromJson(
    Map<String, dynamic> json) {
  return MyTeamMembersListResponse(
    status: json['status'] as bool?,
    result: (json['result'] as List?)
        ?.map((e) => EmployeeProfileDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$MyTeamMembersListResponseToJson(
        MyTeamMembersListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

AllEmployeesListResponse _$AllEmployeesListResponseFromJson(
    Map<String, dynamic> json) {
  return AllEmployeesListResponse(
    status: json['status'] as bool?,
    result: (json['result'] as List?)
        ?.map((e) =>  EmployeeProfileDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AllEmployeesListResponseToJson(
        AllEmployeesListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

LocationDTO _$LocationDTOFromJson(Map<String, dynamic> json) {
  return LocationDTO(
    id: json['id'] as String,
    name: json['name'] as String,
    longitude: (json['longitude'] as num)?.toDouble(),
    latitude: (json['latitude'] as num)?.toDouble(),
    radius: (json['radius'] as num)?.toDouble(),
    status: _$enumDecodeNullable(_$LocationStatusEnumMap, json['status']),
    employee: json['employee'] == null
        ? null
        : EmployeeProfileDTO.fromJson(json['employee'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LocationDTOToJson(LocationDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'radius': instance.radius,
      'status': _$LocationStatusEnumMap[instance.status],
      'employee': instance.employee,
    };

T? _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T? _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$LocationStatusEnumMap = {
  LocationStatus.pending: 0,
  LocationStatus.approved: 1,
  LocationStatus.rejected: 2,
};

LeaveRequestDTOPageDTOOperationResult
    _$LeaveRequestDTOPageDTOOperationResultFromJson(Map<String, dynamic> json) {
  return LeaveRequestDTOPageDTOOperationResult(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : LeaveRequestDTOPageDTO.fromJson(
            json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$LeaveRequestDTOPageDTOOperationResultToJson(
        LeaveRequestDTOPageDTOOperationResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

EmployeeMinimizedDTOPageDTOOperationResult
    _$EmployeeMinimizedDTOPageDTOOperationResultFromJson(
        Map<String, dynamic> json) {
  return EmployeeMinimizedDTOPageDTOOperationResult(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : EmployeeMinimizedDTOPageDTO.fromJson(
            json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$EmployeeMinimizedDTOPageDTOOperationResultToJson(
        EmployeeMinimizedDTOPageDTOOperationResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

LocationDTOListResponse _$LocationDTOListResponseFromJson(
    Map<String, dynamic> json) {
  return LocationDTOListResponse(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : PaginatedLocationDTOList.fromJson(
            json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$LocationDTOListResponseToJson(
        LocationDTOListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

LocationRequestDTO _$LocationRequestDTOFromJson(Map<String, dynamic> json) {
  return LocationRequestDTO(
    employeeId: json['employeeId'] as String?,
    locations: (json['locations'] as List?)
        ?.map((e) => LocationDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LocationRequestDTOToJson(LocationRequestDTO instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'locations': instance.locations,
    };

AnnouncementListResponse _$AnnouncementListResponseFromJson(
    Map<String, dynamic> json) {
  return AnnouncementListResponse(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : PaginatedAnnouncementDTOList.fromJson(
            json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AnnouncementListResponseToJson(
        AnnouncementListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

LocationDTOResponse _$LocationDTOResponseFromJson(Map<String, dynamic> json) {
  return LocationDTOResponse(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : LocationDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$LocationDTOResponseToJson(
        LocationDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

CreateLocationViewModel _$CreateLocationViewModelFromJson(
    Map<String, dynamic> json) {
  return CreateLocationViewModel(
    name: json['name'] as String?,
    longitude: (json['longitude'] as num)?.toDouble(),
    latitude: (json['latitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CreateLocationViewModelToJson(
        CreateLocationViewModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };

GpsLocation _$GpsLocationFromJson(Map<String, dynamic> json) {
  return GpsLocation(
    longitude: (json['longitude'] as num)?.toDouble(),
    latitude: (json['latitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$GpsLocationToJson(GpsLocation instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };

AssignShiftMultipleResponse _$AssignShiftMultipleResponseFromJson(
    Map<String, dynamic> json) {
  return AssignShiftMultipleResponse(
    status: json['status'] as bool?,
    result: (json['result'] as List?)?.map((e) => e as String)?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AssignShiftMultipleResponseToJson(
        AssignShiftMultipleResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

AssignedShiftDTOResponse _$AssignedShiftDTOResponseFromJson(
    Map<String, dynamic> json) {
  return AssignedShiftDTOResponse(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : AssignedShiftDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AssignedShiftDTOResponseToJson(
        AssignedShiftDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

AssignedShiftDTO _$AssignedShiftDTOFromJson(Map<String, dynamic> json) {
  return AssignedShiftDTO(
    shiftId: json['shiftId'] as String?,
    shiftName: json['shiftName'] as String?,
    shiftFromHour: json['shiftFromHour'] as int?,
    shiftFromMinutes: json['shiftFromMinutes'] as int?,
    shiftToHour: json['shiftToHour'] as int?,
    shiftToMinutes: json['shiftToMinutes'] as int?,
    shiftWorkingHoursInMinutes: json['shiftWorkingHoursInMinutes'] as int?,
    weekDays: (json['weekDays'] as List)
        ?.map((e) => _$enumDecodeNullable(_$DayOfWeekEnumMap, e))
        ?.toList(),
  );
}

Map<String, dynamic> _$AssignedShiftDTOToJson(AssignedShiftDTO instance) =>
    <String, dynamic>{
      'shiftId': instance.shiftId,
      'shiftName': instance.shiftName,
      'shiftFromHour': instance.shiftFromHour,
      'shiftFromMinutes': instance.shiftFromMinutes,
      'shiftToHour': instance.shiftToHour,
      'shiftToMinutes': instance.shiftToMinutes,
      'shiftWorkingHoursInMinutes': instance.shiftWorkingHoursInMinutes,
      'weekDays':
          instance.weekDays?.map((e) => _$DayOfWeekEnumMap[e])?.toList(),
    };

const _$DayOfWeekEnumMap = {
  DayOfWeek.sunday: 0,
  DayOfWeek.monday: 1,
  DayOfWeek.tuesday: 2,
  DayOfWeek.wednesday: 3,
  DayOfWeek.thursday: 4,
  DayOfWeek.friday: 5,
  DayOfWeek.saturday: 6,
};

NameValueDTO _$NameValueDTOFromJson(Map<String, dynamic> json) {
  return NameValueDTO(
    name: json['name'] as String?,
    value: json['value'] as int?,
  );
}

Map<String, dynamic> _$NameValueDTOToJson(NameValueDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

NameValueDTOListResponse _$NameValueDTOListResponseFromJson(
    Map<String, dynamic> json) {
  return NameValueDTOListResponse(
    status: json['status'] as bool?,
    result: (json['result'] as List?)
        ?.map((e) => NameValueDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$NameValueDTOListResponseToJson(
        NameValueDTOListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

ShiftDTO _$ShiftDTOFromJson(Map<String, dynamic> json) {
  return ShiftDTO(
    id: json['id'] as String?,
    name: json['name'] as String?,
    fromHour: json['fromHour'] as int?,
    fromMinutes: json['fromMinutes'] as int?,
    toHour: json['toHour'] as int?,
    toMinutes: json['toMinutes'] as int?,
    workingHoursInMinutes: json['workingHoursInMinutes'] as int?,
    isDefault: json['isDefault'] as bool?,
    weekDays: (json['weekDays'] as List?)
        ?.map((e) => _$enumDecodeNullable(_$DayOfWeekEnumMap, e))
        ?.toList(),
  );
}

Map<String, dynamic> _$ShiftDTOToJson(ShiftDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fromHour': instance.fromHour,
      'fromMinutes': instance.fromMinutes,
      'toHour': instance.toHour,
      'toMinutes': instance.toMinutes,
      'workingHoursInMinutes': instance.workingHoursInMinutes,
      'isDefault': instance.isDefault,
      'weekDays':
          instance.weekDays?.map((e) => _$DayOfWeekEnumMap[e])?.toList(),
    };

ShiftMultipleAssigneesDTOOperationResult
    _$ShiftMultipleAssigneesDTOOperationResultFromJson(
        Map<String, dynamic> json) {
  return ShiftMultipleAssigneesDTOOperationResult(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : ShiftMultipleAssigneesDTO.fromJson(
            json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ShiftMultipleAssigneesDTOOperationResultToJson(
        ShiftMultipleAssigneesDTOOperationResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

ShiftMultipleAssigneesDTO _$ShiftMultipleAssigneesDTOFromJson(
    Map<String, dynamic> json) {
  return ShiftMultipleAssigneesDTO(
    shiftName: json['shiftName'] as String?,
    failedEmployeesNames: (json['failedEmployeesNames'] as List?)
        ?.map((e) => e as String)
        ?.toList(),
  );
}

Map<String, dynamic> _$ShiftMultipleAssigneesDTOToJson(
        ShiftMultipleAssigneesDTO instance) =>
    <String, dynamic>{
      'shiftName': instance.shiftName,
      'failedEmployeesNames': instance.failedEmployeesNames,
    };

ShiftDTOResponse _$ShiftDTOResponseFromJson(Map<String, dynamic> json) {
  return ShiftDTOResponse(
    status: json['status'] as bool?,
    result: json['result'] == null
        ? null
        : ShiftDTO.fromJson(json['result'] as Map<String, dynamic>),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ShiftDTOResponseToJson(ShiftDTOResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

ShiftDTOListResponse _$ShiftDTOListResponseFromJson(Map<String, dynamic> json) {
  return ShiftDTOListResponse(
    status: json['status'] as bool?,
    result: (json['result'] as List?)
        ?.map((e) => ShiftDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    errorMessage: json['errorMessage'] as String?,
    errors: (json['errors'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ShiftDTOListResponseToJson(
        ShiftDTOListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
      'result': instance.result,
    };

MyUserDetailsResponse _$MyUserDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return MyUserDetailsResponse(
    organizationId: json['organizationId'] as int?,
    employeeId: json['employeeId'] as int?,
    fullName: json['fullName'] as String?,
    employeeRoles:
        (json['employeeRoles'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$MyUserDetailsResponseToJson(
        MyUserDetailsResponse instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'employeeId': instance.employeeId,
      'fullName': instance.fullName,
      'employeeRoles': instance.employeeRoles,
    };
