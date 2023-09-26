import 'package:flairstechsuite_mobile/features/announcement/data/model/announcement_dto.dart';
import 'package:flairstechsuite_mobile/features/announcement/presentation/manage_announcements_page.dart';
import 'package:flairstechsuite_mobile/features/announcement/presentation/view_announcements_page.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/domain/entity/check_in_out_history_entity.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/presentation/employee_checkinout_history_details_screen.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/presentation/employee_checkinout_history_screen.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/presentation/my_checkinout_history_details_screen.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/presentation/my_checkinout_history_screen.dart';
import 'package:flairstechsuite_mobile/features/cycles/domain/entity/cycle_entity.dart';
import 'package:flairstechsuite_mobile/screens/home/pages/cp_internal_admin/partners_management_page.dart';
import 'package:flairstechsuite_mobile/screens/home/pages/manager/team_status_page.dart';
import 'package:flutter/material.dart';

import '../features/cycles/data/model/holiday/holiday_dto.dart';
import '../features/cycles/presentation/cycle/admin_create_cycle_screen.dart';
import '../features/cycles/presentation/cycle/admin_manage_cycles.dart';
import '../features/cycles/presentation/cycle/cycle_details_screen.dart';
import '../features/cycles/presentation/holiday/create_holiday_screen.dart';
import '../features/cycles/presentation/holiday/edit_holiday_screen.dart';
import '../models/api/responses.dart';
import '../models/leave_request_dto.dart';
import '../screens/admin/admin_create_shift_screen.dart';
import '../screens/admin/admin_update_org_settings_screen.dart';
import '../screens/admin/assign_admin_screen.dart';
import '../screens/admin/assign_shift_screen.dart';
import '../features/announcement/presentation/create_edit_announcement_screen.dart';
import '../screens/admin/employee_balance_page.dart';
import '../screens/admin/employee_profile_screen.dart';
import '../screens/auth/select_organization_screen.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/common/full_image_screen.dart';
import '../features/announcement/presentation/announcement_detail_screen.dart';
import '../screens/employee/create_location_screen.dart';
import '../screens/employee/leave_detail_screen.dart';
import '../screens/home/pages/admin/admin_dashboard_page.dart';
import '../screens/home/pages/admin/admin_manage_shifts_page.dart';
import '../screens/home/pages/admin/all_employees_page.dart';
import '../screens/home/pages/admin/location_requests_page.dart';
import '../screens/home/pages/admin/view_admins_page.dart';
import '../features/check_in_out/presentation/check_inout_page.dart';
import '../features/quick_leave/presentation/create_quick_leave_request_page.dart';
import '../screens/home/pages/employee/employee_dashboard_page.dart';
import '../screens/home/pages/employee/locations_page.dart';
import '../screens/home/pages/employee/my_balance_page.dart';
import '../features/my_calendar/presentation/my_calendar_page.dart';
import '../screens/home/pages/employee/myemployee_profile_page.dart';
import '../screens/home/pages/employee/tenrox_tasks_page.dart';
import '../screens/home/pages/manager/attendance_report_page.dart';
import '../screens/home/pages/manager/balance_report_page.dart';
import '../screens/home/pages/manager/team_location_requests_page.dart';
import '../screens/home/pages/manager/team_members_page.dart';
import '../utils/common.dart';
import 'fade_material_page_route.dart';

class MyRouter {
  MyRouter._();

  static const splash = "/";
  static const selectOrganization = "/selectOrganization";
  static const viewAnnouncements = "/viewAnnouncements";
  static const viewAnnouncementsDetails = "$viewAnnouncements/details";
  static const checkInOut = "/checkInOut";
  static const quickLeaveRequest = "$checkInOut/quickLeaveRequest";
  static const checkInOutHistory = "$checkInOut/checkInOutHistory";
  static const checkInOutHistoryDetails = "$checkInOut/checkInOutHistoryDetails";
  static const employeeCheckInOutHistory = "$checkInOut/employeeCheckInOutHistory";
  static const viewEmployeeBalance = "$checkInOut/viewEmployeeBalance";
  static const employeeCheckInOutHistoryDetails = "$checkInOut/employeeCheckInOutHistoryDetails";
  static const myTasks = "/myTasks";
  static const fullImage = "$checkInOut/fullImage";
  static const myProfile = "/myProfile";
  static const viewEmployeeProfile = "$checkInOut/viewEmployeeProfile";
  static const adminDashboard = "/adminDashboard";
  static const updateOrgSettings = "$adminDashboard/updateOrgSettings";
  static const employeeDashboard = "/employeeDashboard";
  static const manageShifts = "/manageShifts";
  static const createShift = "$manageShifts/createShift";
  static const assignShift = "$manageShifts/assignShift";
  static const manageCycles = "/manageCycles";
  static const createCycle = "$manageCycles/createCycle";
  static const cycleDetails = "$manageCycles/cycleDetails";
  static const createHoliday = "$manageCycles/$cycleDetails/createHoliday";
  static const editHoliday = "$manageCycles/$cycleDetails/editHoliday";

  static const partnersManagement = "/partnersManagement";

  static const allEmployees = "/allEmployees";
  static const adminLocationRequests = "/adminLocationRequests";
  static const adminsList = "/adminsList";
  static const assignAdmin = "$adminsList/assignAdmin";
  static const addAdmin = "$adminsList/addAdmin";
  static const managerAttendanceReport = "/managerAttendanceReport";
 
  static const managerBalanceReport = "/managerBalanceReport";
  static const TeamStatus = "/teamStatus";
  static const adminAttendanceReport = "/adminAttendanceReport";
  static const adminBalanceReport = "/adminBalanceReport";
  static const manageAnnouncements = "/manageAnnouncements";
  static const createAnnouncement = "$manageAnnouncements/createAnnouncement";
  static const editAnnouncement = "$manageAnnouncements/editAnnouncement";
  static const teamMembers = "/teamMembers";
   static const employeeAttendanceReport =
      "$teamMembers/$viewEmployeeBalance/employeeAttendanceReport";
  static const managerLocationRequests = "/managerLocationRequests";
  static const myLocations = "/myLocations";
  static const myCalendar = "/myCalendar";
  static const myBalance = "/myBalance";
  static const viewLeaveDetails = "$myBalance/details";
  static const createLocation = "$myLocations/createLocation";

  static String routeWithId(String route, {String? id}) {
    final _id = (id ?? "").trim();
    if (_id.isEmpty || (route ?? "").isEmpty) return route;
    return "$route/$_id";
  }

  static String? _idFromRoute(String route) {
    final _id = route?.split("/")?.last ?? "";
    return _id.isEmpty ? null : _id;
  }

  static Route<dynamic>? generate(RouteSettings settings) {
    final name = ArgumentError.checkNotNull(settings?.name);
    if (name == splash) {
      return MaterialPageRoute(settings: settings, builder: (_) => SplashScreen());
    } else if (name == selectOrganization) {
      return MaterialPageRoute(settings: settings, builder: (_) => SelectOrganizationScreen());
    } else if (name == viewAnnouncements) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => ViewAnnouncementsPage());
    } else if (name == fullImage) {
      final args = tryCast<String>(settings.arguments);
      return MaterialPageRoute(
        settings: settings,
        fullscreenDialog: true,
        builder: (_) => FullImageScreen(url: args),
      );
    } else if (name == checkInOut) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => CheckInOutPage());
    } else if (name.startsWith("$employeeCheckInOutHistory/")) {
      final args = _idFromRoute(name);
      return MaterialPageRoute(settings: settings, builder: (_) => EmployeeCheckInOutHistoryScreen(args!));
    } else if (name.startsWith("$viewEmployeeProfile/")) {
      final args = _idFromRoute(name);
      return MaterialPageRoute<bool>(settings: settings, builder: (_) => EmployeeProfileScreen(args!));
    }
    else if (name.startsWith("$viewEmployeeBalance/")) {
      final args = _idFromRoute(name);
      return MaterialPageRoute<bool>(settings: settings, builder: (_) => EmployeeBalanceScreen(args!));
    }
    else if (name.startsWith("$viewAnnouncementsDetails/")) {
      final args = _idFromRoute(name);
      return MaterialPageRoute<bool>(
        settings: settings,
        builder: (_) => AnnouncementDetailsScreen(announcementId: args!),
      );
    } else if (name == viewLeaveDetails) {
      final args = tryCast<LeaveRequestDTO>(settings.arguments);
      return MaterialPageRoute<bool>(settings: settings, builder: (_) => LeaveDetailsScreen(leaveRequestDTO: args));
    } else if (name == updateOrgSettings) {
      final args = tryCast<SettingsDTO>(settings.arguments);
      return MaterialPageRoute<bool>(settings: settings, builder: (_) => UpdateOrganizationSettingsScreen(args!));
    } else if (name == createAnnouncement) {
      return MaterialPageRoute<bool>(settings: settings, builder: (_) => CreateEditAnnouncementScreen());
    } else if (name == quickLeaveRequest) {
      final args = tryCast<bool>(settings.arguments);
      return MaterialPageRoute<bool>(
          settings: settings,
          builder: (_) => CreateQuickLeaveRequestScreen(isNavFromDrawer: args));
    } else if (name == editAnnouncement) {
      final args = tryCast<AnnouncementDTO>(settings.arguments);
      return MaterialPageRoute<bool>(
        settings: settings,
        builder: (_) => CreateEditAnnouncementScreen(announcement: args),
      );
    } else if (name == checkInOutHistory) {
      return MaterialPageRoute(settings: settings, builder: (_) => MyCheckInOutHistoryScreen());
    } else if (name == checkInOutHistoryDetails) {
      final args = tryCast<CheckInOutHistoryEntity>(settings.arguments);
      return MaterialPageRoute(settings: settings, builder: (_) => MyCheckInOutHistoryDetailsScreen(args));
    } else if (name == employeeCheckInOutHistoryDetails) {
      final args = tryCast<CheckInOutHistoryEntity>(settings.arguments);
      return MaterialPageRoute(settings: settings, builder: (_) => EmployeeCheckInOutHistoryDetailsScreen(args));
    } else if (name == myTasks) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => TenroxTasksPage());
    } else if (name == createShift) {
      return MaterialPageRoute<bool>(settings: settings, builder: (_) => CreateShiftScreen());
    } else if (name == createCycle) {
      return MaterialPageRoute<bool>(
          settings: settings, builder: (_) => CreateCycleScreen());
    } else if (name == cycleDetails) {
      final args = tryCast<CycleEntity>(settings.arguments);
      return MaterialPageRoute<bool>(
          settings: settings,
          builder: (_) => CycleDetailsScreen(
                cycle: args!,
              ));
    } else if (name == createHoliday) {
      final args = tryCast<CycleEntity>(settings.arguments);
      return MaterialPageRoute<bool>(
          settings: settings, builder: (_) => CreateHolidayScreen(cycle: args!));
    } else if (name == editHoliday) {
      return MaterialPageRoute<bool>(
          settings: settings,
          builder: (_) => EditHolidayScreen(
                cycle: tryCast<CycleEntity>(settings.arguments),
                holiday: tryCast<HolidayDTO>(settings.arguments),
              ));
    } else if (name == assignAdmin) {
      return MaterialPageRoute<bool>(settings: settings, builder: (_) => AssignAdminScreen());
    } else if (name == createLocation) {
      return MaterialPageRoute<bool>(settings: settings, builder: (_) => CreateLocationScreen());
    } else if (name == assignShift) {
      final args = tryCast<ShiftDTO>(settings.arguments);
      return MaterialPageRoute(
          settings: settings, builder: (_) => AssignShiftScreen(shift: args!));
    } else if (name == myProfile) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => MyEmployeeProfilePage());
    } else if (name == adminDashboard) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => AdminDashboardPage());
    } else if (name == manageShifts) {
      return FadeMaterialPageRoute(
          settings: settings, builder: (_) => ManageShiftsPage());
    } else if (name == manageCycles) {
      return FadeMaterialPageRoute(
          settings: settings, builder: (_) => ManageCyclesPage());
    } else if (name == allEmployees) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => AllEmployeesPage());
    } else if (name == adminLocationRequests) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => LocationRequestsPage());
    } else if (name == adminsList) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => ViewAdminsPage());
    } else if (name == managerAttendanceReport) {
      return FadeMaterialPageRoute(
          settings: settings,
          builder: (_) => AttendanceReportPage(
                teamOnly: true,
              ));
    } else if (name.startsWith("$employeeAttendanceReport")) {
      final args = _idFromRoute(name);
      return MaterialPageRoute<bool>(
          settings: settings,
          builder: (_) => AttendanceReportPage(
                employeeId: args,
                isNavFromDrawer: false,
              ));
    } else if (name == adminAttendanceReport) {
      return FadeMaterialPageRoute(
          settings: settings,
          builder: (_) => AttendanceReportPage(
                teamOnly: false,
              ));
    }
    else if (name == managerBalanceReport) {
      return FadeMaterialPageRoute(
          settings: settings,
          builder: (_) => BalanceReportPage(
            teamOnly: true,
          ));
    } else if (name == adminBalanceReport) {
      return FadeMaterialPageRoute(
          settings: settings,
          builder: (_) => BalanceReportPage(
            teamOnly: false,
          ));
    }
    else if (name == manageAnnouncements) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => ManageAnnouncementsPage());
    }
    else if (name == TeamStatus) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => TeamStatusPage());
    }else if (name == teamMembers) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => TeamMembersPage());
    } else if (name == managerLocationRequests) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => TeamLocationRequestsPage());
    } else if (name == myLocations) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => LocationsPage());
    } else if (name == myCalendar) {
      return FadeMaterialPageRoute(
          settings: settings, builder: (_) => MyCalendarPage());
    } else if (name == myBalance) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => MyBalancePage());
    } else if (name == employeeDashboard) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => EmployeeDashboardPage());
    } else if (name == partnersManagement) {
      return FadeMaterialPageRoute(settings: settings, builder: (_) => PartnersManagementPage());
    } else {
      printIfDebug("Unknown route: $name");
      return null;
    }
  }
}
