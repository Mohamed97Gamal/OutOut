import 'package:flutter/material.dart';
import 'package:out_out/assets/image_assets.dart';
import 'package:out_out/widgets/universal_image.dart';

class RightCornerCut extends StatelessWidget {
  const RightCornerCut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "RightCornerCut",
      child: Container(
        width: 150.0,
        height: 150.0,
        child: UniversalImage(ImageAssets.right_corner_cut),
      ),
    );
  }
}

class LeftCornerCut extends StatelessWidget {
  const LeftCornerCut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "LeftCornerCut",
      child: Container(
        width: 150.0,
        height: 150.0,
        child: UniversalImage(ImageAssets.left_corner_cut),
      ),
    );
  }
}
