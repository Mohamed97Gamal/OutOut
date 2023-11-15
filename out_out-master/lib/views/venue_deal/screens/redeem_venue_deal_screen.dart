import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/assets/logo_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/data/view_models/venue_deal/offer_response.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/fields/custom_otp_form_field.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';

class RedeemVenueDealScreen extends StatefulWidget {
  final OfferResponse offerResponse;

  RedeemVenueDealScreen({
    Key? key,
    required this.offerResponse,
  }) : super(key: key);

  @override
  _RedeemVenueDealScreenState createState() => _RedeemVenueDealScreenState();
}

class _RedeemVenueDealScreenState extends State<RedeemVenueDealScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              Center(child: TitleText("Enter 4-digit Offer Code")),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.center,
                child: Text("Enter the code to get the offer in the restaurant."),
              ),
              const SizedBox(height: 24.0),
              CustomOTPFormField(
                length: 4,
                name: "otp_code",
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

                    var result = await showFutureProgressDialog<BooleanOperationResult>(
                      context: context,
                      initFuture: () async {
                        return await ApiRepo().offerClient.redeemOffer(widget.offerResponse.id, _otpController.text);
                      },
                    );
                    if (result != null && result.status) {
                      await showAdaptiveAlertDialog(
                        context: context,
                        icon: UniversalImage(IconAssets.done),
                        content: "",
                        title: "Offer Redeemed successfully.",
                        showCloseButton: false,
                      );
                      Navigator.of(context).maybePop(true);
                    } else {
                      _otpController.clear();
                      await showAdaptiveErrorDialog(
                        context: context,
                        title: "Offer Not Redeemed",
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
