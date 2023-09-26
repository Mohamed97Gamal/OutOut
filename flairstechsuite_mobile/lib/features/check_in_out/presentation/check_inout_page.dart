import 'dart:async';
import 'dart:math' as math;

import 'package:flairstechsuite_mobile/features/check_in_out/domain/entity/check_in_out_history_entity.dart';

import '../data/model/check_in_out_dto.dart';
import '../../../main.dart';
import '../../../models/api/responses.dart';
import '../../../navigation/my_router.dart';
import '../../../repo/repository.dart';
import '../../../utils/colors.dart';
import '../../../utils/date_utils.dart' as date_utils;
import '../../../utils/navigation.dart';
import '../../../utils/notifier_utils.dart';
import '../../../utils/resources_utils.dart';
import '../../../widgets/basic/adaptive_alert_dialog.dart';
import '../../../widgets/basic/adaptive_progress_indicator.dart';
import '../../../widgets/basic/bottom_bar.dart';
import '../../../widgets/basic/confirmation_dialog.dart';
import '../../../widgets/basic/drawer_scaffold.dart' as menu;
import '../../../widgets/basic/future_dialog.dart';
import '../../../widgets/basic/scale_down.dart';
import '../../../widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CheckInOutPage extends StatefulWidget {
  @override
  _CheckInOutPageState createState() => _CheckInOutPageState();
}

class _CheckInOutPageState extends State<CheckInOutPage> {
  CheckInOutHistoryEntity? history;
  bool? isCheckedIn;
  Duration? duration;
  Duration? maxDuration;
  bool isLoading = true;
  Timer? timer;
  String? selectedPlaceId;
  List<LocationDTO>? availableLocations = [];
  List<LocationDTO>? availableOffices = [];
  final _showcaseKey = GlobalKey();
  final _popupKey = GlobalKey<PopupMenuButtonState>();

  @override
  void initState() {
    super.initState();
    initialize();
    timer = Timer.periodic(Duration(seconds: 60), (t) => initialize());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void initialize() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    final locationsResponse = await Repository().getMyLocations();
    availableLocations = locationsResponse.result?.records??[];

    final officesResponse = await Repository().getActiveOffices();
    availableOffices = officesResponse.result!.records;

    final response = await Repository().getMyCheckInOutHistoryToday();
    if (!mounted) return;
    if (!response.status) return;
    if (response.result!.isNotEmpty) {
      setState(() {
        history = response.result!.last;
        if (history != null) {
          duration = Duration(minutes: history!.totalWorkingMinutes!);
          maxDuration = Duration(minutes: history!.requiredMinutes!);
          if (history!.checkInOutDurations!.isNotEmpty) {
            isCheckedIn = history!.checkInOutDurations!.last.checkOutDTO == null;
            if (isCheckedIn!) {
              selectedPlaceId =
                  history!.checkInOutDurations!.last.checkInDTO!.placeId;
            }
          } else {
            isCheckedIn = false;
          }
        }
        isLoading = false;
      });
    } else {
      final assignedShiftResponse = await Repository().getMyAssignedShift();
      if (!mounted) return;
      setState(() {
        duration = Duration();
        maxDuration = Duration(
            minutes: assignedShiftResponse.result!.shiftWorkingHoursInMinutes!);
        isCheckedIn = false;
        isLoading = false;
      });
    }

    if (duration! >= maxDuration! && isCheckedIn!) {
      final dateFormat = DateFormat.yMd();
      final oldDate = dateFormat.parse(
          prefsInstance!.getString("last_confirm_overtime_work") ??
              dateFormat.format(DateTime(2000)));
      print(oldDate);
      final currentDate = DateTime.now();
      await prefsInstance!.setString(
        "last_confirm_overtime_work",
        dateFormat.format(DateTime.now()),
      );
      if (currentDate.day != oldDate.day) {
        final confirm = await showConfirmationDialog(
          context: context,
          actionText:
              "You've completed your working hours today, Do you want to checkout?",
          icon: Icons.question_answer,
          barrierDismissible: false,
        );
        if (confirm == true) {
          final response =
              await showFutureProgressDialog<CheckInOutDTOResponse>(
            nullable: true,
            context: context,
            initFuture: () async {
              final enabled = await Geolocator.isLocationServiceEnabled();
              if (!enabled) {
                return null;
              }

              final currentPosition = await Geolocator.getCurrentPosition();
              if (currentPosition == null) {
                return null;
              }

              final gpsLocation = GpsLocation(
                latitude: currentPosition.latitude,
                longitude: currentPosition.longitude,
              );
              return await Repository()
                  .checkOutNew(gpsLocation, selectedPlaceId);
            },
          );
          if (response?.status ?? false) {
            setState(() => isCheckedIn = false);
          } else {
            if (response != null) {
              await showErrorDialog(context, response);
            } else {
              await showAdaptiveAlertDialog(
                context: context,
                title: Text("Error"),
                content: Text("Can't access location data."),
              );
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) => menu.DrawerScaffold(
          builder: (context) {
            return NotificationScaffold(
              bottomNavigationBar: const MyBottomNavigationBar(),
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(ResourcesUtils.menu),
                  ),
                  onPressed: () =>
                      Provider.of<menu.MenuController>(context, listen: false)
                          .toggle(),
                ),
                title: ScaleDown(child: Text("Check In/Out".toUpperCase())),
                actions: [
                  if (isLoading) AdaptiveProgressIndicator(),
                  PopupMenuButton<String?>(
                    key: _popupKey,
                    tooltip: "Select Location",
                    onSelected: (newValue) {
                      if (newValue == null) return;

                      setState(() {
                        selectedPlaceId = newValue;
                      });
                    },
                    icon: selectedPlaceId == null
                        ? Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.red,
                            child: Icon(Icons.location_pin),
                          )
                        : Icon(Icons.location_pin),
                    itemBuilder: (context) {
                      return [
                        for (final location in availableLocations!)
                          PopupMenuItem(
                            child: Text(
                              location.name!,
                              style: TextStyle(
                                  color: selectedPlaceId == location.id
                                      ? Colors.red
                                      : null),
                            ),
                            value: location.id,
                          ),
                        PopupMenuDivider(),
                        for (final office in availableOffices!)
                          PopupMenuItem(
                            child: Text(
                              office.name!,
                              style: TextStyle(
                                  color: selectedPlaceId == office.id
                                      ? Colors.red
                                      : null),
                            ),
                            value: office.id,
                          ),
                        PopupMenuDivider(),
                        PopupMenuItem(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("Manage"),
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    MyRouter.myLocations, (_) => false);
                              },
                            ),
                          ),
                          value: null,
                        ),
                      ];
                    },
                  ),
                ],
              ),
              body: Stack(
                children: [
                  if (duration != null &&
                      maxDuration != null &&
                      isCheckedIn != null)
                    if (isLoading)
                      const Positioned(
                        top: 24.0,
                        right: 24.0,
                        child: AdaptiveProgressIndicator(),
                      ),
                  Positioned.fill(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? MediaQuery.of(context).size.height * 0.8
                            : MediaQuery.of(context).size.height * 1.5,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "Attendance",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (duration == null ||
                                maxDuration == null ||
                                isCheckedIn == null)
                              if (isLoading)
                                const Center(
                                    child: AdaptiveProgressIndicator()),
                            if (duration != null &&
                                maxDuration != null &&
                                isCheckedIn != null)
                              CheckInOutWidget(
                                checkedIn: isCheckedIn,
                                duration: duration,
                                maxDuration: maxDuration,
                                onPressed: () async {
                                  if (!isLoading && selectedPlaceId == null) {
                                    _popupKey.currentState!.showButtonMenu();
                                  }
                                  if (selectedPlaceId == null) {
                                    ShowCaseWidget.of(context)
                                        .startShowCase([_showcaseKey]);
                                    return;
                                  }
                                  final newCheckedInValue = !isCheckedIn!;
                                  final response =
                                      await showFutureProgressDialog<
                                          CheckInOutDTOResponse>(
                                    nullable: true,
                                    context: context,
                                    initFuture: () async {
                                      final enabled = await Geolocator
                                          .isLocationServiceEnabled();
                                      if (!enabled) {
                                        return null;
                                      }

                                      final permission =
                                          await Geolocator.checkPermission();
                                      if (permission ==
                                              LocationPermission.denied ||
                                          permission ==
                                              LocationPermission
                                                  .deniedForever) {
                                        final permissionRequestResult =
                                            await Geolocator
                                                .requestPermission();
                                        if (permissionRequestResult ==
                                                LocationPermission.denied ||
                                            permissionRequestResult ==
                                                LocationPermission
                                                    .deniedForever) return null;
                                      }

                                      final currentPosition =
                                          await Geolocator.getCurrentPosition();
                                      if (currentPosition == null) {
                                        return null;
                                      }

                                      final gpsLocation = GpsLocation(
                                        latitude: currentPosition.latitude,
                                        longitude: currentPosition.longitude,
                                      );

                                      if (newCheckedInValue) {
                                        return await Repository().checkInNew(
                                            gpsLocation, selectedPlaceId);
                                      } else {
                                        return await Repository().checkOutNew(
                                            gpsLocation, selectedPlaceId);
                                      }
                                    },
                                  );

                                  if (response?.status ?? false) {
                                    setState(() {
                                      initialize();
                                    });
                                  } else {
                                    if (response != null) {
                                      await showErrorDialog(context, response);
                                    } else {
                                      await showAdaptiveAlertDialog(
                                        context: context,
                                        title: Text("clock in/out denied"),
                                        content: Text(
                                            "Please check your GPS and try again."),
                                      );
                                    }
                                  }
                                },
                              ),
                            const SizedBox(height: 24.0),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: MaterialButton(
                                color: Theme.of(context).primaryColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 64.0),
                                child: Text("Check My Attendance".toUpperCase(),
                                    textAlign: TextAlign.center),
                                onPressed: () =>
                                    Navigation.navToMyCheckInOutHistory(
                                        context),
                              ),
                            ),
                            const SizedBox(height: 24.0),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: MaterialButton(
                                color: MyColors.blackColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 64.0),
                                child: Text("quick leave request".toUpperCase(),
                                    textAlign: TextAlign.center),
                                onPressed: () =>
                                    Navigation.navToQuickLeaveRequest(
                                        context, false),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CheckInOutWidget extends StatelessWidget {
  final bool? checkedIn;
  final Duration? duration;
  final Duration? maxDuration;
  final Function onPressed;

  const CheckInOutWidget({
    Key? key,
    required this.checkedIn,
    required this.duration,
    required this.maxDuration,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var percentage = (duration!.inSeconds / maxDuration!.inSeconds);
    percentage = math.min(percentage, 1);
    if (percentage < 0) percentage = 0;
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(27.0),
              child: CircularStepProgressIndicator(
                totalSteps: 100,
                currentStep: (percentage * 100.0).floor(),
                padding: math.pi / 40,
                selectedColor: Colors.black,
                unselectedColor: Colors.black45,
                selectedStepSize: 0.0,
                unselectedStepSize: 4.0,
                width: 240,
                height: 240,
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(27.0),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(hintColor: const Color(0xff363636)),
                    child: CircularProgressIndicator(
                      strokeWidth: 3.5,
                      value: percentage,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(57.0),
              child: CenterCircle(checkedIn, duration, onPressed),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                  alignment: FractionalOffset.center,
                  angle: math.pi * ((percentage * 360.0) - 90.0) / 180.0,
                  child: SizedBox(
                    width: 240.0 + 48.0,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                        radius: 24.0,
                        backgroundColor: const Color(0xff363636),
                        foregroundColor: Colors.white,
                        child: Transform.rotate(
                          angle:
                              -math.pi * ((percentage * 360.0) - 90.0) / 180.0,
                          child: Text("${(percentage * 100.0).floor()}%"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if ((duration!.inSeconds * 100 / maxDuration!.inSeconds) >= 100)
          Text(
            "Completed",
            style: TextStyle(
              fontSize: 22.0,
              color: MyColors.greenColor,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}

class CenterCircle extends StatelessWidget {
  final bool? checkedIn;
  final Duration? duration;
  final Function onPressed;

  CenterCircle(this.checkedIn, this.duration, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox.fromSize(
          size: Size.fromRadius(90.0),
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
            backgroundColor:
                checkedIn! ? Theme.of(context).primaryColor : Color(0xff73bfc7),
            value: 0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: ClipOval(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
              borderRadius: BorderRadius.circular(85.0),
              onTap: onPressed as void Function()?,
              child: SizedBox.fromSize(
                size: Size.fromRadius(84.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 40,
                      child: Center(
                        child: Text(
                          "TOTAL HOURS",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 25,
                      child: Center(
                        child: Text(
                          date_utils.DateUtils.durationToText(duration!),
                          style: TextStyle(
                              fontSize: 27.0, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      flex: 40,
                      child: Container(
                        padding: const EdgeInsets.all(1.0),
                        color: checkedIn!
                            ? Theme.of(context).primaryColor
                            : Color(0xff73bfc7),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 1.0),
                            Expanded(
                              flex: 15,
                              child: Center(
                                child: Text(
                                  "PLEASE PRESS HERE",
                                  style: TextStyle(
                                      fontSize: 10.0, color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 45,
                              child: Center(
                                child: Text(
                                  checkedIn! ? "CLOCK OUT" : "CLOCK IN",
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
