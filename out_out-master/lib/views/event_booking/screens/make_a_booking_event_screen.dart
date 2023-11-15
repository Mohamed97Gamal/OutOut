import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/models/enums/payment_status.dart';
import 'package:out_out/data/view_models/event/event_booking_request.dart';
import 'package:out_out/data/view_models/event/event_occurrence_response.dart';
import 'package:out_out/data/view_models/event/event_package_response.dart';
import 'package:out_out/data/view_models/event/single_event_occurrence_response.dart';
import 'package:out_out/data/view_models/event_booking/telr_booking_response_operation_result.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/utils/date_utils.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/fields/custom_dropdown_form_field.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class MakeABookingEventScreen extends StatefulWidget {
  final SingleEventOccurrenceResponse singleEventOccurrenceResponse;

  MakeABookingEventScreen({
    Key? key,
    required this.singleEventOccurrenceResponse,
  }) : super(key: key);

  @override
  _MakeABookingEventScreenState createState() =>
      _MakeABookingEventScreenState();
}

class _MakeABookingEventScreenState extends State<MakeABookingEventScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  EventOccurrenceResponse? initialSelectedOccurrence;
  DateTime? dateTime;
  num? selectedQuantity;
  num? selectedPackagePrice;

  @override
  void initState() {
    for (int i = 0;
        i < widget.singleEventOccurrenceResponse.occurrences.length;
        i++) {
      var item = widget.singleEventOccurrenceResponse.occurrences[i];
      if (widget.singleEventOccurrenceResponse.occurrence!.id == item.id) {
        dateTime = fromDateAndTimeSpan(item.startDate, item.startTime);
        if (dateTime!.isAfter(DateTime.now())) {
          initialSelectedOccurrence = item;
        } else {
          initialSelectedOccurrence = null;
        }
      }
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
            "Make a Booking",
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
              TitleText(widget.singleEventOccurrenceResponse.name),
              const SizedBox(height: 16.0),
              CustomDropdownFormField<EventOccurrenceResponse>(
                name: "date",
                labelText: "Date",
                isRequired: true,
                hintText: "Select Date",
                initialValue: initialSelectedOccurrence,
                items: widget.singleEventOccurrenceResponse.occurrences
                    .where((occurrence) => fromDateAndTimeSpan(
                            occurrence.startDate, occurrence.startTime)
                        .isAfter(DateTime.now().toUtc()))
                    .toList(),
                itemBuilder: (context, item) {
                  return Text(item.explain());
                },
              ),
              const SizedBox(height: 16.0),
              CustomDropdownFormField<int>(
                name: "quantity",
                labelText: "Quantity",
                hintText: "Select Quantity",
                isRequired: true,
                items: List.generate(10, (index) => index + 1),
                itemBuilder: (context, item) => Text(item.toString()),
                validators: [],
                onChanged: (value) {
                  setState(() {
                    selectedQuantity = value!;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              CustomDropdownFormField<EventPackageResponse>(
                name: "package",
                labelText: "Package",
                hintText: "Select Package",
                isRequired: true,
                items:
                    widget.singleEventOccurrenceResponse.occurrence!.packages,
                itemBuilder: (context, item) =>
                    Text("AED ${item.price} - ${item.title}"),
                validators: [],
                onChanged: (value) {
                  setState(() {
                    selectedPackagePrice = value!.price;
                  });
                },
              ),
              const SizedBox(height: 40.0),
              if (selectedPackagePrice != null && selectedQuantity != null)
                Text(
                  'Total : ${selectedPackagePrice! * selectedQuantity!} AED',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              if (selectedPackagePrice != null && selectedQuantity != null)
                const SizedBox(height: 30.0),
              Container(
                width: double.maxFinite,
                height: 40.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Theme.of(context).primaryColor),
                  child: Text(
                    "Confirm & Pay",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () async {
                    var formState = _formKey.currentState;
                    if (formState == null) return;
                    if (!formState.saveAndValidate()) {
                      return;
                    }
                    final EventPackageResponse package =
                        formState.value["package"];
                    final EventOccurrenceResponse eventOccurrenceId =
                        formState.value["date"];
                    final num totalAmount =
                        selectedPackagePrice! * selectedQuantity!;

                    var result = await showFutureProgressDialog<
                        TelrBookingResponseOperationResult>(
                      context: context,
                      initFuture: () async {
                        final request = new EventBookingRequest()
                          ..eventOccurrenceId = eventOccurrenceId.id
                          ..packageId = package.id!
                          ..quantity = selectedQuantity!
                          ..totalAmount = totalAmount.toDouble();
                        return await ApiRepo()
                            .eventClient
                            .makeATelrBooking(request);
                      },
                    );
                    if (result != null && result.status) {
                      PaymentStatus telrPaymentStatus;
                      if (result.result.bookingUrl == null &&
                          totalAmount == 0.0) {
                        telrPaymentStatus = PaymentStatus.paid;
                      } else {
                        telrPaymentStatus =
                            await Navigation().navToTelrPaymentScreen(
                          context,
                          url: result.result.bookingUrl!,
                          bookingId: result.result.bookingId,
                        );
                      }

                      if (telrPaymentStatus == PaymentStatus.paid) {
                        await showAdaptiveAlertDialog(
                          barrierDismissible: false,
                          context: context,
                          icon: UniversalImage(IconAssets.done),
                          title: result.result.bookingUrl == null &&
                                  totalAmount == 0.0
                              ? "Event Booked Successfully!"
                              : "Payment Successfully Done",
                          content: "",
                          showCloseButton: true,
                          actions: <AdaptiveAlertDialogAction>[
                            AdaptiveAlertDialogAction(
                              title: "Done",
                              onPressed: () async {
                                Navigator.of(context).pop(PaymentStatus.paid);
                              },
                              isPrimary: true,
                            ),
                          ],
                        );
                        await Navigator.of(context).maybePop();
                        Navigation().navToEventBookingDetailsScreen(context,
                            eventBookingId: result.result.bookingId);
                        context
                            .read<MyAccountProvider>()
                            .eventBookingsRefreshNotifier
                            .refresh();
                        return;
                      } else if (telrPaymentStatus == PaymentStatus.declined) {
                        await showAdaptiveAlertDialog(
                          barrierDismissible: false,
                          context: context,
                          icon: UniversalImage(IconAssets.failed),
                          title: "Payment Failed",
                          content: "",
                          showCloseButton: true,
                          actions: <AdaptiveAlertDialogAction>[
                            AdaptiveAlertDialogAction(
                              title: "Done",
                              onPressed: () async {
                                await Navigator.of(context).maybePop();
                              },
                              isPrimary: true,
                            ),
                          ],
                        );
                      } else if (telrPaymentStatus == PaymentStatus.cancelled) {
                        ApiRepo()
                            .paymentClient
                            .cancelled(result.result.bookingId)
                            .then((value) {});
                        await showAdaptiveAlertDialog(
                          barrierDismissible: false,
                          context: context,
                          icon: UniversalImage(IconAssets.failed),
                          title: "Payment Failed",
                          content: "",
                          showCloseButton: true,
                          actions: <AdaptiveAlertDialogAction>[
                            AdaptiveAlertDialogAction(
                              title: "Done",
                              onPressed: () async {
                                await Navigator.of(context).maybePop();
                              },
                              isPrimary: true,
                            ),
                          ],
                        );
                      }
                    } else {
                      await showAdaptiveErrorDialog(
                        context: context,
                        title: "Error",
                        content: result?.errorMessage ?? "Unknown Error",
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
