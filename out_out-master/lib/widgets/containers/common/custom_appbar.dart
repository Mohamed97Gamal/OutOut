import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:out_out/widgets/containers/common/adaptive_back_button.dart';
import 'package:out_out/widgets/containers/common/change_location.dart';
import 'package:out_out/widgets/containers/common/corners.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool showChangeLocation;
  final bool showBackButton;

  CustomAppBar({
    Key? key,
    required this.showChangeLocation,
    this.showBackButton = true,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shouldShowBackButton = Navigator.of(context).canPop() && showBackButton;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (showChangeLocation)
          Positioned(
            top: -65.0,
            right: -60.0,
            child: RightCornerCut(),
          ),
        if (!showChangeLocation)
          Positioned(
            top: -65.0,
            left: -60.0,
            child: LeftCornerCut(),
          ),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: SafeArea(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (showChangeLocation && !shouldShowBackButton)
                  Expanded(
                    child: ChangeLocation(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16.0),
                    ),
                  ),
                if (shouldShowBackButton)
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: showChangeLocation ? 0.0 : 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (shouldShowBackButton)
                            AdaptiveBackButton(
                              showArrowBG: false,
                            ),
                          if (!showChangeLocation && title != null) title!,
                          if (showChangeLocation)
                            Expanded(
                              child: ChangeLocation(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 16.0),
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
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
