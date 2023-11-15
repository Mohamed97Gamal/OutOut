import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/models/enums/day_of_week.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/data/view_models/venue/venue_response.dart';
import 'package:out_out/data/view_models/venue_booking/venue_booking_request.dart';
import 'package:out_out/data/view_models/venue_booking/venue_booking_response_operation_result.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/utils/date_utils.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/fields/custom_date_form_field.dart';
import 'package:out_out/widgets/fields/custom_dropdown_form_field.dart';
import 'package:out_out/widgets/fields/custom_time_form_field.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_bottom_sheet.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:intl/intl.dart';

class MakeABookingVenueScreen extends StatefulWidget {
  final VenueResponse venueResponse;

  MakeABookingVenueScreen({
    required this.venueResponse,
    Key? key,
  }) : super(key: key);

  @override
  _MakeABookingVenueScreenState createState() =>
      _MakeABookingVenueScreenState();
}

class _MakeABookingVenueScreenState extends State<MakeABookingVenueScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late DateTime selectedDate;

  @override
  void initState() {
    selectedDate = DateTime.now();
    while (!widget.venueResponse.isMatchingDate(selectedDate)) {
      selectedDate = selectedDate.add(Duration(days: 1));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      headerHeight: 130.0,
      showChangeLocation: true,
      header: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 20),
          child: Text(
            "Make a Reservation",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(widget.venueResponse.name),
              const SizedBox(height: 30.0),
              CustomDateFormField(
                name: "date",
                labelText: "Date",
                hintText: "Select Date",
                isRequired: true,
                initialValue: selectedDate,
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      selectedDate = value;
                    }
                  });
                },
                selectableDayPredicate: (d) {
                  final todayOrFuture =
                      d.isAfter(DateTime.now()) || d.isToday();
                  return todayOrFuture &&
                      widget.venueResponse.isMatchingDate(d);
                },
              ),
              const SizedBox(height: 25.0),
              CustomTimeFormField(
                name: "time",
                labelText: "Time",
                hintText: "Select Time",
                isRequired: true,
                onChanged: (value) {},
                selectableDayPredicate: (time) {
                  final dateTime = fromDateAndTime(
                      DateTime.tryParse(DateFormat("yyyy-MM-ddTHH:mm:ss.000'Z'")
                          .format(selectedDate))!,
                      time);
                  return dateTime.isFuture() &&
                      widget.venueResponse.isMatchingTime(time);
                },
                validators: [
                  (value, label) {
                    if (value == null) {
                      return null;
                    }
                    final dateTime = fromDateAndTime(selectedDate, value);
                    if (!dateTime.isFuture()) {
                      return "You cannot select an old date.";
                    }
                    if (!widget.venueResponse.isMatchingTime(dateTime)) {
                      var todayOpenTimes = widget.venueResponse.openTimes.where(
                        (element) =>
                            element.days.contains(selectedDate.dayOfWeek),
                      );
                      if (todayOpenTimes.isNotEmpty) {
                        var openTime = todayOpenTimes.first;
                        final from = openTime.from;
                        final to = openTime.to;
                        return "Venue is open from $from to $to only.";
                      } else {
                        List<DayOfWeek> days = [];
                        for (var openTime in widget.venueResponse.openTimes) {
                          days.addAll(openTime.days);
                        }
                        return "Venue is open on ${days.map((e) => e.name).join(",")}.";
                      }
                    }
                    return null;
                  }
                ],
              ),
              const SizedBox(height: 25.0),
              CustomDropdownFormField<int>(
                name: "number_of_people",
                labelText: "Number of People",
                hintText: "Select Number of People",
                isRequired: true,
                items: List.generate(20, (index) => index + 1),
                itemBuilder: (context, item) => Text(item.toString()),
                validators: [],
                onChanged: (value) {},
              ),
              const SizedBox(height: 25.0),
              Container(
                width: double.maxFinite,
                height: 40.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Theme.of(context).primaryColor),
                  child: Text(
                    "Make a Reservation",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () async {
                    var formState = _formKey.currentState;
                    if (formState == null) return;
                    if (!formState.saveAndValidate()) {
                      //TODO: investigate focus issue with time field?
                      FocusScope.of(context).unfocus();
                      return;
                    }
                    var bookingResult = await showFutureProgressDialog<
                        VenueBookingResponseOperationResult>(
                      context: context,
                      initFuture: () async {
                        final date = formState.value["date"] as DateTime;
                        final time = formState.value["time"] as DateTime;
                        final dateTime = fromDateAndTime(date, time);
                        final request = new VenueBookingRequest()
                          ..venueId = widget.venueResponse.id
                          ..peopleNumber = formState.value["number_of_people"]
                          ..date = dateTime.add(dateTime.timeZoneOffset);
                        return await ApiRepo()
                            .venueClient
                            .makeABooking(request);
                      },
                    );
                    if (bookingResult != null && bookingResult.status) {
                      await showAdaptiveAlertDialog(
                        barrierDismissible: false,
                        context: context,
                        icon: UniversalImage(IconAssets.done),
                        title:
                            "Your Booking is pending and you will receive a callback",
                        content:
                            "During busy times it may take a while to come back with confirmation. "
                            "If you don’t receive a confirmation please call the venue directly during working hours.",
                        showCloseButton: false,
                        actions: <AdaptiveAlertDialogAction>[
                          AdaptiveAlertDialogAction(
                            title: "Done",
                            onPressed: () async {
                              await Navigator.of(context).maybePop();
                            },
                            isPrimary: true,
                          ),
                          AdaptiveAlertDialogAction(
                            title: "Cancel reservation",
                            onPressed: () async {
                              await showAdaptiveBottomSheet(
                                context: context,
                                content: Text(
                                  "Are you sure you want to cancel the booking?",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                actions: <AdaptiveBottomSheetAction>[
                                  AdaptiveBottomSheetAction(
                                    title: "Yes",
                                    onPressed: () async {
                                      var request =
                                          await showFutureProgressDialog<
                                              BooleanOperationResult>(
                                        context: context,
                                        initFuture: () async {
                                          return await ApiRepo()
                                              .venueClient
                                              .cancelABooking(
                                                  bookingResult.result.id);
                                        },
                                      );
                                      if (request != null && request.status) {
                                        await showAdaptiveAlertDialog(
                                          context: context,
                                          icon: UniversalImage(IconAssets.done),
                                          content: "",
                                          title:
                                              "Venue Booking canceled successfully.",
                                          showCloseButton: false,
                                        );
                                      } else {
                                        await showAdaptiveErrorDialog(
                                          context: context,
                                          title: "Error",
                                          content: request?.errorMessage ??
                                              "Unknown Error",
                                        );
                                      }
                                      await Navigator.of(context).maybePop();
                                    },
                                    isPrimary: true,
                                  ),
                                  AdaptiveBottomSheetAction(
                                    title: "No",
                                    onPressed: () async {
                                      await Navigator.of(context).maybePop();
                                    },
                                  ),
                                ],
                              );
                              await Navigator.of(context).maybePop();
                            },
                          ),
                        ],
                      );
                      await Navigator.of(context).maybePop();
                      await Navigation().navToVenueBookingDetailsScreen(
                        context,
                        venueBookingId: bookingResult.result.id,
                      );
                    } else {
                      await showAdaptiveErrorDialog(
                        context: context,
                        title: "Error",
                        content: bookingResult?.errorMessage ?? "Unknown Error",
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
