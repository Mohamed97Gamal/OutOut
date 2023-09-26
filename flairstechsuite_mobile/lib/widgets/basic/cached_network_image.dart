import 'dart:io';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width, height;
  final String? defaultImage;
  final BoxFit fitMode;

  const CustomCachedNetworkImage(
    this.imageUrl, {
    this.defaultImage,
    this.height,
    this.width,
    this.fitMode = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if ((imageUrl ?? "").isEmpty) {
     return SizedBox(
        height: height,
        width: width,
        child: (defaultImage ?? "").isEmpty
            ? Image.asset(
                ResourcesUtils.appLogo,
                width: width,
                height: height,
              )
            : CustomCachedNetworkImage(
                defaultImage,
                width: width,
                height: height,
                defaultImage: "",
              ),
      );
    }
    if (Platform.isAndroid || Platform.isIOS) {
      return CachedNetworkImage(
        fit: fitMode,
        imageUrl: imageUrl ?? "",
        placeholder: (context, s) {
         return SizedBox(
            height: height,
            width: width,
            child: Center(
              child: AdaptiveProgressIndicator(),
            ),
          );
        },
        errorWidget: (context, s, exception) {
         return SizedBox(
            height: height,
            width: width,
            child: (defaultImage ?? "").isEmpty
                ? Image.asset(
                    ResourcesUtils.appLogo,
                    width: width,
                    height: height,
                  )
                : CustomCachedNetworkImage(
                    defaultImage,
                    width: width,
                    height: height,
                    defaultImage: "",
                  ),
          );
        },
        height: height,
        width: width,
      );
    }
    return Image.network(
      imageUrl ?? "",
      fit: fitMode,
      height: height,
      width: width,
    );
  }
}

class AvatarNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width, height;
  final BoxFit fitMode;

  const AvatarNetworkImage(
    this.imageUrl, {
    this.height,
    this.width,
    this.fitMode = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if ((imageUrl ?? "").isEmpty) {
      return ClipOval(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(
          height: height,
          width: width,
          child: Image.asset(
            ResourcesUtils.avatar,
            width: width,
            height: height,
          ),
        ),
      );
    }
    if (Platform.isAndroid || Platform.isIOS) {
      return ClipOval(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CachedNetworkImage(
          fit: fitMode,
          imageUrl: imageUrl ?? "",
          placeholder: (context, s) {
           return SizedBox(
              height: height,
              width: width,
              child: const Center(child: AdaptiveProgressIndicator()),
            );
          },
          errorWidget: (context, s, exception) {
           return SizedBox(
              height: height,
              width: width,
              child: Image.asset(
                ResourcesUtils.avatar,
                width: width,
                height: height,
              ),
            );
          },
          height: height,
          width: width,
        ),
      );
    }
    return ClipOval(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.network(
        imageUrl ?? "",
        fit: fitMode,
        height: height,
        width: width,
      ),
    );
  }
}
