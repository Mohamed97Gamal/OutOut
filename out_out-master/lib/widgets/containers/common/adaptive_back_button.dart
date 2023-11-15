import 'dart:io';

import 'package:flutter/material.dart';

class AdaptiveBackButton extends StatelessWidget {
  final bool showArrowBG;
  const AdaptiveBackButton({
    Key? key,
    required this.showArrowBG,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "back_button",
      child: showArrowBG
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                shape: CircleBorder(),
                color: Colors.white,
                child: Platform.isIOS
                    ? IconButton(
                        iconSize: 28,
                        // padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        // alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 10),
                        icon: const BackButtonIcon(),
                        tooltip:
                            MaterialLocalizations.of(context).backButtonTooltip,
                        onPressed: () => Navigator.of(context).maybePop(),
                      )
                    : Center(
                        child: IconButton(
                          iconSize: 28,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          alignment: Alignment.center,
                          icon: const BackButtonIcon(),
                          tooltip: MaterialLocalizations.of(context)
                              .backButtonTooltip,
                          onPressed: () => Navigator.of(context).maybePop(),
                        ),
                      ),
              ),
            )
          : Material(
              color: Colors.transparent,
              child: Center(
                child: IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  constraints: BoxConstraints(maxHeight: 30.0, maxWidth: 35.0),
                  alignment: Alignment.center,
                  icon: const BackButtonIcon(),
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ),
            ),
    );
  }
}
