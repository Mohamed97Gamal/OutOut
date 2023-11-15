import 'package:flutter/material.dart';
import 'package:out_out/widgets/containers/custom_flat_scaffold.dart';
import 'package:out_out/widgets/universal_image.dart';

class GalleryScreen extends StatefulWidget {
  final List<String> imagesUris;
  final int initialPage;

  const GalleryScreen(
    this.imagesUris, {
    required this.initialPage,
    Key? key,
  }) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return CustomFlatScaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: PageView(
          controller: _controller,
          children: [
            for (final imageUri in widget.imagesUris)
              InteractiveViewer(
                child: UniversalImage(imageUri),
              ),
          ],
        ),
      ),
    );
  }
}
