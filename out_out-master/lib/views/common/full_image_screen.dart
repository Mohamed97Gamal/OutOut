import 'package:flutter/material.dart';
import 'package:out_out/widgets/containers/custom_flat_scaffold.dart';
import 'package:out_out/widgets/universal_image.dart';

class FullImageScreen extends StatelessWidget {
  final String imageUri;

  const FullImageScreen(
    this.imageUri, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFlatScaffold(
      showChangeLocation: false,
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: InteractiveViewer(
          child: UniversalImage(imageUri),
        ),
      ),
    );
  }
}
