import 'package:flairstechsuite_mobile/enums/cycle_country.dart';
import 'package:flairstechsuite_mobile/enums/location_status.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/navigation/my_router.dart';
import 'package:flairstechsuite_mobile/providers/my_profile_provider.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/screens/home/pages/manager/attendance_report_page.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flairstechsuite_mobile/utils/date_utils.dart' as date_utils;
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/utils/url_launcher_utils.dart';
import 'package:flairstechsuite_mobile/views/assigned_shift_dialog.dart';
import 'package:flairstechsuite_mobile/views/attendance_policy_dialog.dart';
import 'package:flairstechsuite_mobile/views/country_change_dialog.dart';
import 'package:flairstechsuite_mobile/views/location_status_icon.dart';
import 'package:flairstechsuite_mobile/views/location_tile.dart';
import 'package:flairstechsuite_mobile/views/profile_property_tile.dart';
import 'package:flairstechsuite_mobile/views/profile_shift_tile.dart';
import 'package:flairstechsuite_mobile/views/workspace_policy_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_progress_indicator.dart';
import 'package:flairstechsuite_mobile/widgets/basic/cached_network_image.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/basic/scale_down.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EmployeeProfileScreen extends StatefulWidget {
  final String employeeId;

  EmployeeProfileScreen(this.employeeId) : assert(employeeId != null);

  @override
  _EmployeeProfileScreenState createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  final _refreshableKey = GlobalKey<RefreshableState>();
  var _didEditLocations = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(_didEditLocations);
        return false;
      },
      child: NotificationScaffold(
        body: Refreshable(
          key: _refreshableKey,
          child: RefreshIndicator(
            onRefresh: () async => _refreshableKey.currentState!.refresh(),
            child: CustomFutureBuilder<EmployeeProfileDTOResponse>(
              initFuture: () =>
                  Repository().getEmployeeProfile(widget.employeeId),
              onLoading: (context) {
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text("Employee Profile".toUpperCase()),
                    flexibleSpace: Container(height: 200.0),
                  ),
                  body: Center(
                    child: AdaptiveProgressIndicator(),
                  ),
                );
              },
              onSuccess: (context, snapshot) {
                final employeeDTO = snapshot.data!.result!;
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        centerTitle: true,
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              employeeDTO.fullName ?? "",
                              style: TextStyle(fontSize: 18.0),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              employeeDTO.title ?? "",
                              style: TextStyle(fontSize: 10.0),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        background: Center(
                          child: Stack(
                            children: <Widget>[
                              InkWell(
                                onTap: employeeDTO?.profileImagePath == null
                                    ? null
                                    : () => Navigation.navToFullImage(
                                        context, employeeDTO.profileImagePath),
                                child: AvatarNetworkImage(
                                  employeeDTO.profileImagePath,
                                  width: 100.0,
                                  height: 100.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Consumer<MyProfileProvider>(
                        builder: (context, provider, _) {
                      return SliverPadding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            <Widget>[
                              ProfilePropertyTile(
                                name: "Email: ",
                                hyperlinked:
                                    provider.current!.id == widget.employeeId
                                        ? false
                                        : true,
                                icon: Icon(FontAwesomeIcons.envelopeOpenText),
                                value: employeeDTO.organizationEmail,
                                onPressed: provider.current!.id ==
                                        widget.employeeId
                                    ? null
                                    : () => launchURL(
                                        "mailto:${employeeDTO.organizationEmail}"),
                              ),
                              Divider(),
                              ProfilePropertyTile(
                                name: "Manager: ",
                                icon: Icon(FontAwesomeIcons.userTie),
                                value: employeeDTO.managerName ?? "No Manager",
                                onPressed: employeeDTO.managerId != null &&
                                        provider.current!.id != employeeDTO.id
                                    ? () => Navigation.navToViewEmployeeProfile(
                                        context, employeeDTO.managerId)
                                    : null,
                              ),
                              Divider(),
                              ProfilePropertyTile(
                                name: "Join Date: ",
                                icon: Icon(FontAwesomeIcons.calendarDay),
                                value: date_utils.DateUtils.dateFormat
                                    .format(employeeDTO.employmentDate!),
                              ),
                              Divider(),
                              ProfilePropertyTile(
                                name: "Last Modified Date: ",
                                icon: Icon(FontAwesomeIcons.calendar),
                                value: date_utils.DateUtils.dateFormat
                                    .format(employeeDTO.modifiedDate!),
                              ),
                              Divider(),
                              ProfileShiftTile(
                                shift: employeeDTO.assignedShift,
                                trailing: InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      FontAwesomeIcons.solidEdit,
                                      size: 20,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  onTap: () async {
                                    final updated =
                                        await showUpdateEmployeeAssignedShiftDialog(
                                      context,
                                      widget.employeeId,
                                      employeeDTO.assignedShift!.shiftId,
                                    );
                                    if (updated) {
                                      _refreshableKey.currentState!.refresh();
                                    }
                                  },
                                ),
                              ),
                              Divider(),
                              CustomFutureBuilder<NameValueDTOListResponse>(
                                initFuture: () =>
                                    Repository().getWorkspacePolicyTypes(),
                                onSuccess: (context, snapshot) {
                                  final nameValueDTOsList =
                                      snapshot.data!.result!;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32.0, vertical: 4.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child:
                                                Icon(FontAwesomeIcons.scroll),
                                          ),
                                        ),
                                        const SizedBox(width: 12.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Work Space Policy: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                nameValueDTOsList
                                                        .firstWhere((e) =>
                                                            e.value ==
                                                            employeeDTO
                                                                .workspacePolicy)
                                                        .name ??
                                                    "",
                                                style: TextStyle(
                                                    color: MyColors
                                                        .lightGrayColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: InkWell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                FontAwesomeIcons.solidEdit,
                                                size: 20,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            onTap: () async {
                                              final updated =
                                                  await showUpdateEmployeeWorkspacePolicyDialog(
                                                context,
                                                widget.employeeId,
                                                employeeDTO.workspacePolicy,
                                              );
                                              if (updated) {
                                                _refreshableKey.currentState!
                                                    .refresh();
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Divider(),
                              CustomFutureBuilder<NameValueDTOListResponse>(
                                initFuture: () =>
                                    Repository().getAttendancePolicyTypes(),
                                onSuccess: (context, snapshot) {
                                  final nameValueDTOsList =
                                      snapshot.data!.result!;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32.0, vertical: 4.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Icon(
                                                FontAwesomeIcons.stopwatch),
                                          ),
                                        ),
                                        const SizedBox(width: 12.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Follow up Attendance Policy: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                nameValueDTOsList
                                                        .firstWhere((e) =>
                                                            e.value ==
                                                            employeeDTO
                                                                .attendancePolicy)
                                                        .name ??
                                                    "",
                                                style: TextStyle(
                                                    color: MyColors
                                                        .lightGrayColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: InkWell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                FontAwesomeIcons.solidEdit,
                                                size: 20,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            onTap: () async {
                                              final updated =
                                                  await showUpdateEmployeeAttendancePolicyDialog(
                                                context,
                                                widget.employeeId,
                                                employeeDTO.attendancePolicy,
                                              );
                                              if (updated) {
                                                _refreshableKey.currentState!
                                                    .refresh();
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0, vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child:
                                                Icon(FontAwesomeIcons.calendar),
                                          ),
                                        ),
                                        const SizedBox(width: 12.0),
                                        Text(
                                          "Holiday Set:  ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          CycleCountry.fromJson(
                                                      employeeDTO.country)
                                                  .name ??
                                              "",
                                          style:
                                              TextStyle(
                                              color: MyColors.lightGrayColor),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16.0),
                                            child: Icon(
                                              FontAwesomeIcons.solidEdit,
                                              size: 20,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          onTap: () async {
                                            final updated =
                                                await showUpdateEmployeeCountryDialog(
                                              context,
                                              widget.employeeId,
                                              employeeDTO.country,
                                            );
                                            if (updated) {
                                              _refreshableKey.currentState!
                                                  .refresh();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              ProfilePropertyTile(
                                name: "Use Tenrox Tasks Feature",
                                icon: SizedBox(
                                  width: 25.0,
                                  height: 25.0,
                                  child: Checkbox(
                                    value: employeeDTO.useTenroxTasksFeature,
                                    onChanged: null,
                                  ),
                                ),
                                value: "",
                              ),
                              Divider(),
                              EmployeeLocationsPropertyTile(
                                employeeId: widget.employeeId,
                                onChange: () => _didEditLocations = true,
                              ),
                              const SizedBox(height: 24),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 32),
                                child: MaterialButton(
                                  color: Theme.of(context).primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 64.0),
                                  child: ScaleDown(
                                      child: Text(
                                          "Available Balance".toUpperCase(),
                                          maxLines: 1)),
                                  onPressed: () =>
                                      Navigation.navToViewEmployeeBalance(
                                          context, widget.employeeId),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 32),
                                child: MaterialButton(
                                  color: Theme.of(context).primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 64.0),
                                  child: ScaleDown(
                                      child: Text(
                                          "Attendance History".toUpperCase(),
                                          maxLines: 1)),
                                  onPressed: () =>
                                      Navigation.navToEmployeeCheckInOutHistory(
                                          context, widget.employeeId),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 32),
                                child: MaterialButton(
                                  color: Theme.of(context).primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 64.0),
                                  child: ScaleDown(
                                      child: Text(
                                          "Attendance Report".toUpperCase(),
                                          maxLines: 1)),
                                  onPressed: () =>
                                      // Navigator.of(context)
                                      //     .pushNamed(MyRouter.routeWithId(
                                      //         MyRouter.employeeAttendanceReport,
                                      //         id: widget.employeeId))
                                      // Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           AttendanceReportPage(
                                      //         employeeId: widget.employeeId,
                                      //         teamOnly: true,
                                      //       ),
                                      //     ))
                                      Navigation.navToAttendanceReport(
                                          context, widget.employeeId),
                                ),
                              ),
                              const SizedBox(height: 80.0),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class EmployeeLocationsPropertyTile extends StatelessWidget {
  EmployeeLocationsPropertyTile(
      {Key? key, required this.employeeId, this.onChange})
      : super(key: key);

  final String employeeId;
  final Function? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.location_on),
              const SizedBox(width: 10.0),
              Text(
                "Locations",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          CustomFutureBuilder<LocationDTOListResponse>(
            initFuture: () => Repository().getEmployeeLocations(employeeId),
            onSuccess: (index, snapshot) {
              final locationsList = snapshot.data!.result!.records!;
              if (locationsList.isEmpty) return Text("No Locations.");
              return Theme(
                data: Theme.of(context).copyWith(
                  buttonTheme:
                      Theme.of(context).buttonTheme.copyWith(height: 38.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (final location in locationsList)
                      EmployeeProfileLocation(
                        location: location,
                        onChange: onChange,
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class EmployeeProfileLocation extends StatelessWidget {
  EmployeeProfileLocation({
    Key? key,
    required this.location,
    this.onChange,
  }) : super(key: key);

  final LocationDTO location;
  final Function? onChange;
  final GlobalKey<PopupMenuButtonState> _popupKey =
      GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 32),
      child: LocationTile(
        location: location,
        bottom: Row(
          children: [
            const Text("Status"),
            const SizedBox(width: 8),
            Stack(
              children: [
                Positioned.fill(
                  child: PopupMenuButton<LocationStatus>(
                    key: _popupKey,
                    offset: Offset(0.0, 50.0),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Container(),
                    itemBuilder: (context) {
                      return <PopupMenuItem<LocationStatus>>[
                        if (location.status != LocationStatus.approved)
                          PopupMenuItem(
                            value: LocationStatus.approved,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LocationStatusIcon(LocationStatus.approved,
                                    colored: false),
                                const SizedBox(width: 8.0),
                                Text("Approve".toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ],
                            ),
                          ),
                        if (location.status != LocationStatus.rejected)
                          PopupMenuItem(
                            value: LocationStatus.rejected,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LocationStatusIcon(LocationStatus.rejected,
                                    colored: false),
                                const SizedBox(width: 8.0),
                                Text("Reject".toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ],
                            ),
                          ),
                      ];
                    },
                    onSelected: (status) async {
                      final response =
                          await showFutureProgressDialog<BoolResponse>(
                        context: context,
                        initFuture: () async {
                          if (status == LocationStatus.approved) {
                            return Repository().approveLocation(location.id);
                          } else if (status == LocationStatus.rejected) {
                            return Repository().rejectLocation(location.id);
                          }
                          return null;
                        },
                      );
                      if (response?.status ?? false) {
                        await showAdaptiveAlertDialog(
                          context: context,
                          content: Text(
                              "You have successfully ${status.name} the location."),
                        );
                        Refreshable.of(context)!.refresh();
                        onChange?.call();
                      } else {
                        await showErrorDialog(context, response);
                      }
                    },
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  color: location.status.color,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.keyboard_arrow_down),
                      Text(location.status.name!.toUpperCase()),
                    ],
                  ),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    await Future.delayed(
                      Duration(milliseconds: 500),
                      () => _popupKey.currentState!.showButtonMenu(),
                    );
                  },
                ),
              ],
            ),
            Spacer(),
          ],
        ),
        trailing: LocationStatusIcon(location.status),
      ),
    );
  }
}
