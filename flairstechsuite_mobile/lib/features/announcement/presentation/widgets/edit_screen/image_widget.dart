import 'dart:io';

import 'package:flairstechsuite_mobile/features/announcement/presentation/widgets/network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final dynamic imageState;
  final bool isFileImage;
  final bool isNetworkImage;
  final bool isNoImage;
  const ImageWidget(
      {Key? key,
      required this.imageState,
      required this.isFileImage,
      required this.isNetworkImage,
      required this.isNoImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isFileImage) {
      return _buildFileImage(context, path: imageState.path);
    }

    if (isNetworkImage) {
      return AnnouncementNetworkImage(url: imageState.url);
    }

    if (isNoImage) {
      return Center(
          child: Text("Announcement Image",
              style: Theme.of(context).textTheme.headline6));
    }
   return SizedBox();
  }

  Widget _buildFileImage(BuildContext context, {required String path}) {
    assert(path != null);
    return Image.file(
      File(path),
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}
