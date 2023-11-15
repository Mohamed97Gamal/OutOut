import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/assets/logo_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/data/view_models/event_booking/ticket_redemption_request.dart';
import 'package:out_out/data/view_models/event_booking/ticket_response.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/fields/custom_otp_form_field.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class TicketRedeemScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final _otpController = TextEditingController();
  final TicketResponse ticketResponse;
  final RefreshNotifier refreshNotifier;

  TicketRedeemScreen({
    Key? key,
    required this.ticketResponse,required this.refreshNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAccountProvider = context.read<MyAccountProvider>();
    return CustomScaffold(
      showChangeLocation: true,
      headerHeight: 150.0,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: UniversalImage(LogoAssets.outout_blue_logo)),
              const SizedBox(height: 30.0),
              Center(child: TitleText("Enter 4-digit to Redeem Ticket")),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.center,
                child: Text("Enter the code to redeem the Event Ticket."),
              ),
              const SizedBox(height: 24.0),
              CustomOTPFormField(
                name: "otp_code",
                length: 4,
                isRequired: true,
                controller: _otpController,
              ),
              const SizedBox(height: 16.0),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  child: Text("Redeem"),
                  onPressed: () async {
                    var formState = _formKey.currentState;
                    if (formState == null) return;
                    if (!formState.validate()) {
                      return;
                    }
                    final eventCode = _otpController.text;
                    var request = await showFutureProgressDialog<BooleanOperationResult>(
                      context: context,
                      initFuture: () async {
                        final request = new TicketRedemptionRequest()
                          ..eventCode = eventCode
                          ..ticketId = ticketResponse.id
                          ..ticketSecret = ticketResponse.secret;
                        return await ApiRepo().eventClient.redeemTicket(request);
                      },
                    );
                    if (request != null && request.status) {
                      _otpController.clear();
                      await showAdaptiveAlertDialog(
                        context: context,
                        icon: UniversalImage(IconAssets.done),
                        content: "",
                        title: "Ticket Redeemed successfully.",
                        showCloseButton: false,
                      );
                      refreshNotifier.refresh();
                      myAccountProvider.refreshNotifier.refresh();
                      Navigator.of(context).maybePop(true);
                    } else {
                      _otpController.clear();
                      await showAdaptiveErrorDialog(
                        context: context,
                        title: "Ticket Not Redeemed",
                        dismissText: "Try Again",
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
