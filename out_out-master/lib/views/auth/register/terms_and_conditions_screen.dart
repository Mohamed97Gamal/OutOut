import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:out_out/widgets/containers/custom_flat_scaffold.dart';
import 'package:out_out/widgets/title_text.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFlatScaffold(
      showChangeLocation: false,
      title: TitleText("Terms & Conditions"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int x = 0; x < 60; x++)
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 2.5,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        "Terms and conditions #$x",
                        style: GoogleFonts.roboto(
                          color: Color(0xff646464),
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
