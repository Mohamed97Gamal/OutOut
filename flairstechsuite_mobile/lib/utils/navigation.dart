import 'dart:async';

import 'package:flairstechsuite_mobile/features/announcement/data/model/announcement_dto.dart';
import 'package:flairstechsuite_mobile/features/check_in_out/domain/entity/check_in_out_history_entity.dart';
import 'package:flairstechsuite_mobile/models/customer_portal/client_profile_appointment/client_profile_appointment_response.dart';
import 'package:flairstechsuite_mobile/screens/cp_internal_admin/appointment_details_screen.dart';
import 'package:flairstechsuite_mobile/screens/cp_internal_admin/appointment_history_screen.dart';
import 'package:flairstechsuite_mobile/screens/cp_internal_admin/log_appointment_screen.dart';

import '../features/cycles/data/model/cycle/cycle_dto.dart';
import '../features/cycles/data/model/holiday/holiday_dto.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/api/responses.dart';
import '../models/leave_request_dto.dart';
import '../models/user_credentials.dart';
import '../navigation/my_router.dart';
import '../screens/home/pages/employee/myemployee_profile_page.dart';

class Navigation {
  static Future<void> logout() async {
    await UserCredentials.removeFromSecureStorage();
    restartApp();
  }

  static restartApp() {
    navigatorKey = GlobalKey<NavigatorState>();
    appRefreshableKey.currentState!.refresh();
  }

  static void navToSelectOrganization(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(MyRouter.selectOrganization, (_) => false);
  }

  static Future<bool?> navToCreateAnnouncement(BuildContext context) {
    return Navigator.of(context).pushNamed<bool>(MyRouter.createAnnouncement);
  }

  static Future<bool?> navToEditAnnouncement(BuildContext context, {required AnnouncementDTO announcement}) {
    assert(announcement != null);
    return Navigator.of(context).pushNamed<bool>(MyRouter.editAnnouncement, arguments: announcement);
  }

  static Future<bool?> navToAnnouncementDetails(BuildContext context, {String? announcementId}) {
    return Navigator.of(context).pushNamed<bool>(
      MyRouter.routeWithId(MyRouter.viewAnnouncementsDetails, id: announcementId),
    );
  }

  static Future<bool?> navToLeaveDetails(BuildContext context, {LeaveRequestDTO? leaveRequestDTO}) {
    return Navigator.of(context).pushNamed(MyRouter.viewLeaveDetails, arguments: leaveRequestDTO);
  }

  static void navToHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      MyRouter.checkInOut,
      (_) => false,
    );
  }

  static Future<bool?> navToUpdateOrgSettings(BuildContext context, SettingsDTO? settingsDTO) {
    return Navigator.of(context).pushNamed(MyRouter.updateOrgSettings, arguments: settingsDTO);
  }

  static Future<bool> navToCreateLocation(BuildContext context) async {
    return (await (Navigator.of(context).pushNamed(MyRouter.createLocation) as FutureOr<bool>?)) ?? false;
  }

  // static Future<bool> navToUpdateDepartment(BuildContext context, DepartmentDTO departmentDTO) {
  //   return Navigator.of(context).push(
  //         MaterialPageRoute(
  //           builder: (context) {
  //             return UpdateDepartmentScreen(departmentDTO);
  //           },
  //         ),
  //       ) ??
  //       false;
  // }

  static Future<bool?> navToAssignAdmin(BuildContext context) {
    return Navigator.of(context).pushNamed(MyRouter.assignAdmin);
  }

  static navToFullImage(BuildContext context, String? url) {
    Navigator.of(context).pushNamed(MyRouter.fullImage, arguments: url);
  }

  // static void navToOrganizationProfile(BuildContext context, OrganizationDTO organizationDTO) {
  //   Navigator.of(context).push(
  //   MaterialPageRoute(
  //     builder: (context) {
  //       return OrganizationProfileScreen(organizationDTO);
  //     },
  //   ),
  // );
  // }

  static void navToMyCheckInOutHistory(BuildContext context) {
    Navigator.of(context).pushNamed(MyRouter.checkInOutHistory);
  }

  static navToEmployeeCheckInOutHistory(BuildContext context, String employeeId) {
    Navigator.of(context).pushNamed(MyRouter.routeWithId(MyRouter.employeeCheckInOutHistory, id: employeeId));
  }

  static Future<bool?> navToViewEmployeeBalance(BuildContext context, String employeeId) {
    return Navigator.of(context).pushNamed<bool>(MyRouter.routeWithId(MyRouter.viewEmployeeBalance, id: employeeId));
  }

  static void navToAssignShift(BuildContext context, ShiftDTO shift) {
    Navigator.of(context).pushNamed(MyRouter.assignShift, arguments: shift);
  }

  static void navToCycleDetails(BuildContext context, CycleDTO? cycle) {
    Navigator.of(context).pushNamed(MyRouter.cycleDetails, arguments: cycle);
  }

  static void navToQuickLeaveRequest(BuildContext context, isNavFromDrawer) {
    Navigator.of(context).pushNamed(MyRouter.quickLeaveRequest, arguments: isNavFromDrawer);
  }

  static void navToMyCheckInOutHistoryDetails(BuildContext context, CheckInOutHistoryEntity checkInOutHistory) {
    Navigator.of(context).pushNamed(MyRouter.checkInOutHistoryDetails, arguments: checkInOutHistory);
  }

  static void navToEmployeeCheckInOutHistoryDetails(BuildContext context, CheckInOutHistoryEntity checkInOutHistory) {
    Navigator.of(context).pushNamed(
      MyRouter.employeeCheckInOutHistoryDetails,
      arguments: checkInOutHistory,
    );
  }

  static Future<bool?> navToViewEmployeeProfile(BuildContext context, String? employeeId) {
    return Navigator.of(context).pushNamed<bool>(MyRouter.routeWithId(MyRouter.viewEmployeeProfile, id: employeeId));
  }

  static Future<bool?> navToAttendanceReport(BuildContext context, String employeeId) {
    return Navigator.of(context)
        .pushNamed<bool>(MyRouter.routeWithId(MyRouter.employeeAttendanceReport, id: employeeId));
  }

  static Future<bool?> navToCreateShift(BuildContext context) {
    return Navigator.of(context).pushNamed(MyRouter.createShift);
  }

  static Future<bool?> navToCreateCycle(BuildContext context) {
    return Navigator.of(context).pushNamed(MyRouter.createCycle);
  }

  static navToMyProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MyEmployeeProfilePage(
            isNavFromDrawer: false,
          );
        },
      ),
    );
  }

  static Future<bool?> navToCreatHoliday(BuildContext context, CycleDTO cycle) {
    return Navigator.of(context).pushNamed(MyRouter.createHoliday, arguments: cycle);
  }

  static Future<bool?> navToEditHoliday(BuildContext context, CycleDTO cycle, HolidayDTO holiday) {
    return Navigator.of(context).pushNamed(MyRouter.editHoliday, arguments: {"cycle": cycle, "holiday": holiday});
  }

  static Future<bool> navToLogScheduledAppointment(
    BuildContext context, {
    required String? clientProfileId,
    required String? clientProfileAppointmentId,
    required DateTime? scheduledDate,
  }) async {
    return await (Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LogAppointmentScreen.scheduled(
              clientProfileId: clientProfileId,
              clientProfileAppointmentId: clientProfileAppointmentId,
              scheduledDate: scheduledDate,
            ),
          ),
        ) as FutureOr<bool>?) ??
        false;
  }

  static Future<bool> navToLogUnscheduledAppointment(BuildContext context, {required String? clientProfileId}) async {
    return await (Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LogAppointmentScreen.unscheduled(clientProfileId: clientProfileId),
          ),
        ) as FutureOr<bool>?) ??
        false;
  }

  static Future<bool> navToAppointmentHistory(BuildContext context, {required String? clientProfileId}) async {
    return await (Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AppointmentHistoryScreen(clientProfileId: clientProfileId),
          ),
        ) as FutureOr<bool>?) ??
        false;
    ;
  }

  static Future navToAppointmentDetails(
    BuildContext context, {
    required ClientProfileAppointmentResponse clientProfileAppointmentResponse,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AppointmentDetailsScreen(
          clientProfileAppointmentResponse: clientProfileAppointmentResponse,
        ),
      ),
    );
  }
}
