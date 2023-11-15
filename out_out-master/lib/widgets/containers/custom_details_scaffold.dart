import 'dart:io';

import 'package:flutter/material.dart';
import 'package:out_out/data/memory/providers/bottom_navigation_bar_provider.dart';
import 'package:out_out/widgets/containers/common/adaptive_back_button.dart';
import 'package:out_out/widgets/containers/common/custom_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class CustomDetailsScaffold extends StatelessWidget {
  final Widget body;
  final Widget background;
  final bool showArrowBG;

  CustomDetailsScaffold(
      {required this.body, required this.background, this.showArrowBG = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      background,
                      Padding(
                        padding: const EdgeInsets.only(top: 150.0),
                        child: body,
                      ),
                    ],
                  ),
                  if (context.read<BottomNavigationBarProvider>().show)
                    Container(
                      color: Colors.white,
                      height: 100.0,
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            top: Platform.isIOS ? 64.0 : 32.0,
            left: 0.0,
            child: Align(
              alignment:
                  Platform.isIOS ? Alignment.center : Alignment.centerLeft,
              child: AdaptiveBackButton(
                showArrowBG: showArrowBG,
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            left: 0.0,
            bottom: 0.0,
            child: CustomBottomNavigationBar(),
          ),
        ],
      ),
    );
  }
}
