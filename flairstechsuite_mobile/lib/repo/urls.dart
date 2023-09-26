import '../main.dart';

class Urls {
  Urls._();

  static const baseUrl = FlairstrackerApp.isProduction
      ? "https://apiattendance.flairstech.com/api/"
      : "https://192.168.54.200:1990/api/";

  static const getFullOrganizationsDetails =
      "Organizations/GetFullOrganizationsDetails";
  static const getMyOrganizationInfo = "Auth/GetMyOrganization";
  static const submitAnnualLeaveRequest = "Tasks/SubmitAnnualLeaveRequest";
  static const submitSickLeaveRequest = "Tasks/SubmitSickLeaveRequest";
  static const submitWFHRequest = "Tasks/SubmitWFHRequest";
  static const createAnnouncement = "Announcement/Create";
  static const approveLocation = "Locations/ApproveLocation";
  static const getEmployeeLocations = "Locations/GetEmployeeLocations";
  static const forgetCheckOut = "CheckInOuts/ForgetCheckOut";
  static const getEmployeeWorkspacePolicyTypes =
      "Employees/GetEmployeeWorkspacePolicyTypes";
  static const getEmployeesCountries =
      "Employees/GetEmployeesCountries";
  static const getEmployeeAttendancePolicyTypes =
      "Employees/GetEmployeeAttendancePolicyTypes";
  static const calculateLeaveDays = "LeaveRequests/CalculateLeaveDays";

  static const keepAlive = "CheckInOuts/KeepAlive";
  static const checkOutNew = "CheckInOuts/CheckOutNew";
  static const checkInNew = "CheckInOuts/CheckInNew";
  static const createLocation = "Locations/Create";
  static const deleteLocation = "Locations/Delete";
  static const getEmployeeCheckInOutHistory =
      "CheckInOuts/GetEmployeeCheckInOutHistory";
  static const getMyCheckInOutHistory = "CheckInOuts/GetMyCheckInOutHistory";
  static const getMyCheckInOutHistoryToday =
      "CheckInOuts/GetMyCheckInOutHistoryToday";
  static const getMyAssignedShift = "Shifts/GetMyAssignedShift";
  static const getMyTeamLocations = "Locations/GetMyTeamLocations";
  static const rejectLocation = "Locations/RejectLocation";
  static const createDepartment = "Departments/Create";
  static const updateDepartment = "Departments/Update";
  static const getOrganizationDepartments = "Departments/GetAllDepartments";
  static const addAdminToMyOrganization =
      "Organizations/AddAdminToMyOrganization";
  static const addAdmin = "Organizations/AddAdmin";
  static const deleteMyOrgAdmin = "Organizations/DeleteAdminFromMyOrganization";
  static const deleteAdmin = "Organizations/DeleteAdmin";
  static const multipleAssignShift = "Shifts/MultipleAssignShift";
  static const assignShift = "Shifts/AssignShift";
  static const exportBalance = "Balances/ExportBalance";
  static const assignAdminToMyOrganization =
      "Organizations/AssignAdminToMyOrganization";
  static const getEmployeesList = "Employees/GetEmployeesList";
  static const getMyTeamMembers = "Employees/GetMyTeamMembers";
  static const getMyTeamMembersPaginated = "Employees/GetMyTeamMembersPaginated";
  static const getAllEmployeesPaginated = "Employees/GetEmployeesListPaginated";
  static const getMyOrgAdmins = "Organizations/GetMyOrganizationAdmins";
  static const getAdminsList = "Organizations/GetAdminsList";
  static const activateOrganization = "Organizations/Activate";
  static const deactivateOrganization = "Organizations/Deactivate";
  static const updateOrganization = "Organizations/Update";
  static const getOrganizationDetails = "Organizations/GetById";
  static const getAllOrganizations = "Organizations/GetAllOrganizations";
  static const removeMyProfileImage = "EmployeeUsers/RemoveMyProfileImage";
  static const updateMyProfileImage = "EmployeeUsers/UpdateMyProfileImage";
  static const changePassword = "Auth/ChangePassword";
  static const sendVerifyEmail = "Auth/SendVerifyEmail";
  static const exportAttendance = "CheckInOuts/ExportAttendance";
  static const sendForgetPassword = "Auth/SendResetPasswordEmail";
  static const register = "CandidateUsers/Register";
  static const login = "Auth/Login";
  static const deleteShift = "Shifts/Delete";
  static const setDefaultShift = "Shifts/SetDefaultShift";
  static const createShift = "Shifts/Create";
  static const getAllShifts = "Shifts/GetAllShifts";
  static const getEmployeesAssignedToShift ="Shifts/GetEmployeesAssignedToShift";
  static const quickLeave = "QuickLeave";
  static const createNewAnnualLeaveRequest =
      "$quickLeave/CreateNewAnnualLeaveRequest";
  static const createNewHalfDayLeaveRequest =
      "$quickLeave/CreateNewHalfDayLeaveRequest";
  static const createNewSickLeaveRequest =
      "$quickLeave/CreateNewSickLeaveRequest";
  static const createNewEmergencyLeaveRequest =
      "$quickLeave/CreateNewEmergencyLeaveRequest";
  static const getMyCalendar = "Calendar/GetMyCalendar";
  static const deleteCycle = "Cycle/Delete";
  static const createCycle = "Cycle/Create";
  static const getAllCycles = "Cycle/GetAll";
  static const getCurrentCycle = "Cycle/GetCurrentCycle";
  static const getCycleById = "Cycle/GetById?cycleId=";
  static const getAllCycleCountries = "Cycle/GetCyclesCountries";
  static const setDefaultCycle = "Cycle/MarkAsDefault?cycleId=";
  static const createHoliday = "Holidays/AddHolidaysToCycle";
  static const updateHoliday = "Holidays/EditHolidayInCycle";
  static const deleteCycleHoliday = "Holidays/DeleteHolidayFromCycle";
  static const getMyBalances = "Balances/GetMyBalances";
  static const changeWorkspacePolicy = "Employees/ChangeWorkspacePolicy";
  static const changeAttendancePolicy = "Employees/ChangeAttendancePolicy";
  static const getEmployeeProfile = "Employees/GetById";
  static const getMyTasks = "Tasks/GetMyTasks";
  static const endMyTask = "Tasks/EndMyTask";
  static const startMyTask = "Tasks/StartMyTask";
  static const getMyEmployee = "EmployeeUsers/GetMyEmployee";
  static const getAllLocations = "Locations/GetAllLocations";
  static const getMyLocations = "Locations/GetMyLocations";
  static const getActiveOffices = "Offices/GetActiveOffices";
  static const deleteDepartment = "Departments/Delete";
  static const createOrganization = "Organizations/Create";
  static const updateOrganizationSettings = "OrganizationSettings/Update";
  static const changeEmployeeCountry = "Employees/ChangeEmployeeCountry";
  static const getTimeZones = "OrganizationSettings/GetTimezoneNames";
  static const getAllOrganizationSettings =
      "OrganizationSettings/GetAllOrganizationSettings";
  static const updateMyOrganizationInfo =
      "Organizations/UpdateMyOrganizationInfo";
  static const publishAnnouncement = "Announcement/PublishAnnouncement";
  static const unPublishAnnouncement = "Announcement/UnPublishAnnouncement";
  static const getAllAnnouncements = "Announcement/GetAllAnnouncements";
  static const getPublishedAnnouncements =
      "Announcement/GetPublishedAnnouncements";
  static const getUnreadAnnouncementsCount =
      "Announcement/GetMyUnreadAnnouncementsCount";
  static const markAnnouncementAsRead = "Announcement/MarkAsRead";
  static const getAnnouncementDetails = "Announcement/GetDetailsById";
  static const updateAnnouncement = "Announcement/Update";
  static const sendAnnouncementNotification =
      "Announcement/SendAnnouncementNotification";
  static const addMyFCMToken = "Auth/AddMyFCMToken";
  static const deleteMyFCMToken = "Auth/DeleteMyFCMToken";
  static const getMyUserDetails = "Auth/GetMyUserDetails";
  static const getAllowedVersions = "Auth/GetAllowedVersions";
  static const getAllEmails = "Employees/GetEmployeesOrganizationEmails";

  static const getEmployeeBalances = "Balances/GetEmployeeBalances";
  static const getMyLeaveRequests = "LeaveRequests/GetMyLeaveRequests";
  static const getMyTeamLeaveRequests = "LeaveRequests/GetMyTeamLeaveRequests";
  static const getEmployeeLeaveRequests = "LeaveRequests/GetEmployeeLeaveRequests";
  static const downloadBase64File = "LeaveRequests/DownloadBase64File";
  static final _withAuth = [
    getMyBalances,
    exportBalance,
    calculateLeaveDays,
    getMyLeaveRequests,
    getEmployeeBalances,
    getEmployeesCountries,
    getAllEmployeesPaginated,
    changeEmployeeCountry,
    getEmployeeLeaveRequests,
    downloadBase64File,
    getAllEmails,
    getMyUserDetails,
    addMyFCMToken,
    deleteMyFCMToken,
    sendAnnouncementNotification,
    updateAnnouncement,
    getAnnouncementDetails,
    markAnnouncementAsRead,
    getUnreadAnnouncementsCount,
    getPublishedAnnouncements,
    getAllAnnouncements,
    unPublishAnnouncement,
    publishAnnouncement,
    getFullOrganizationsDetails,
    getMyOrganizationInfo,
    submitAnnualLeaveRequest,
    submitSickLeaveRequest,
    submitWFHRequest,
    approveLocation,
    getEmployeeLocations,
    forgetCheckOut,
    getEmployeeWorkspacePolicyTypes,
    keepAlive,
    checkOutNew,
    checkInNew,
    createLocation,
    deleteLocation,
    getEmployeeCheckInOutHistory,
    getMyCheckInOutHistory,
    getMyCheckInOutHistoryToday,
    getMyAssignedShift,
    getMyTeamLocations,
    rejectLocation,
    createDepartment,
    updateDepartment,
    getOrganizationDepartments,
    addAdminToMyOrganization,
    addAdmin,
    deleteMyOrgAdmin,
    deleteAdmin,
    multipleAssignShift,
    assignShift,
    assignAdminToMyOrganization,
    getEmployeesList,
    getMyTeamMembers,
    getMyTeamMembersPaginated,
    getMyOrgAdmins,
    getAdminsList,
    deleteCycleHoliday,
    activateOrganization,
    deactivateOrganization,
    updateOrganization,
    getOrganizationDetails,
    removeMyProfileImage,
    updateMyProfileImage,
    changePassword,
    exportAttendance,
    deleteShift,
    setDefaultShift,
    createShift,
    getAllShifts,
    deleteCycle,
    setDefaultCycle,
    createCycle,
    getAllCycles,
    getCurrentCycle,
    changeWorkspacePolicy,
    getEmployeeProfile,
    createAnnouncement,
    getMyTasks,
    endMyTask,
    startMyTask,
    getMyEmployee,
    getAllLocations,
    getMyLocations,
    getActiveOffices,
    deleteDepartment,
    createOrganization,
    updateOrganizationSettings,
    getTimeZones,
    getAllOrganizationSettings,
    updateMyOrganizationInfo,
  ].map((e) => e.toLowerCase()).toSet();

  static bool requiresAuth({String? url}) {
    final _url = url?.toLowerCase();
    if ((_url ?? "").isEmpty) return false;

    for (final loopUrl in _withAuth) {
      if (_url!.contains(loopUrl)) {
        return true;
      }
    }
    return false;
  }
}

const extraFilesPathKey = "flairstech_extra_files_path";
