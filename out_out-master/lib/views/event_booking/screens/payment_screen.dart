import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/utils/validators.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/fields/custom_credit_card_form_field.dart';
import 'package:out_out/widgets/fields/custom_text_form_field.dart';

class PaymentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  PaymentScreen({
    Key? key,
  }) : super(key: key);

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
            "Payment",
            style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
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
              CustomTextFormField(
                name: "card number",
                labelText: "Card Number",
                hintText: "1234    4567   8910   2135",
                isRequired: true,
                validators: [Validators.creditCard],
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 25.0),
              CustomTextFormField(
                name: "card holder name",
                labelText: "Card Holder Name",
                hintText: "",
                isRequired: true,
                validators: [],
              ),
              const SizedBox(height: 25.0),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomExpireDateFormField(
                      isNumbered: true,
                      name: "expire date",
                      labelText: "Expire Date",
                      isExpired: true,
                      hintText: "02/22",
                      isRequired: true,
                      validators: [Validators.expireDate],
                    ),
                  ),
                  Expanded(child: const SizedBox(width: 20.0)),
                  Expanded(
                    flex: 2,
                    child: CustomTextFormField(
                      name: "cvv",
                      labelText: "CVV",
                      hintText: "093",
                      isRequired: true,
                      validators: [Validators.cvv],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              Container(
                width: double.maxFinite,
                height: 40.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shadowColor: Theme.of(context).primaryColor),
                  child: Text(
                    "Confirm & Pay",
                    style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    // Navigation().navToBookingEventConfirmationScreen(context);
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
