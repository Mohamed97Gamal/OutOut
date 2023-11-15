import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:out_out/outout_app.dart';
import 'package:out_out/utils/default_image_utils.dart';
import 'package:out_out/widgets/loading/adaptive_progress_indicator.dart';
import 'package:out_out/widgets/universal_image_provider.dart';
import 'package:provider/provider.dart';

class UniversalImage extends StatelessWidget {
  final String imageUri;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Color? color;

  final bool cache;

  void initialize() {
    if (initialized) return;
    isSvg = imageUri.endsWith(".svg");
    isAsset = imageUri.startsWith("assets");
    isLink = imageUri.startsWith("http:") || imageUri.startsWith("https:");
    initialized = true;
  }

  bool initialized = false;
  bool isSvg = false;
  bool isAsset = false;
  bool isLink = false;

  UniversalImage(
    this.imageUri, {
    this.fit,
    this.width,
    this.height,
    this.color,
    this.cache = false,
    Key? key,
  }) : super(key: key);

  UniversalImage.avatar(
    String? avatarUri, {
    this.color,
    this.cache = true,
    Key? key,
  })  : fit = BoxFit.cover,
        width = double.maxFinite,
        height = double.maxFinite,
        imageUri = getAvatarUri(avatarUri),
        super(key: key);

  UniversalImage.category(
    String? categoryUri, {
    required bool selected,
    this.width,
    this.height,
    Key? key,
  })  : fit = BoxFit.contain,
        color = selected ? Colors.white : OutOutApp.primaryColor,
        cache = true,
        imageUri = getCategoryUri(categoryUri),
        super(key: key);

  UniversalImage.venue(
    String? venueUri, {
    this.width,
    this.height,
    this.color,
    Key? key,
  })  : fit = BoxFit.contain,
        cache = false,
        imageUri = getVenueUri(venueUri),
        super(key: key);

  UniversalImage.deals(
      String? venueUri, {
        this.width,
        this.height,
        this.color,
        Key? key,
      })  : fit = BoxFit.fill,
        cache = false,
        imageUri = getVenueUri(venueUri),
        super(key: key);
  UniversalImage.event(
    String? eventUri, {
    this.width,
    this.height,
    this.color,
    Key? key,
  })  : fit = BoxFit.cover,
        cache = false,
        imageUri = getEventUri(eventUri),
        super(key: key);

  UniversalImage.eventBackground(
    String? eventUri, {
    this.width,
    this.height,
    this.color,
    Key? key,
  })  : fit = BoxFit.cover,
        cache = false,
        imageUri = getEventUri(eventUri),
        super(key: key);

  UniversalImage.deal(
    String? dealUri, {
    this.width,
    this.height,
    this.color,
    Key? key,
  })  : fit = BoxFit.cover,
        cache = false,
        imageUri = getDealUri(dealUri),
        super(key: key);

  UniversalImage.notification(
    String? notificationUri, {
    this.width,
    this.height,
    this.color,
    Key? key,
  })  : fit = BoxFit.cover,
        cache = false,
        imageUri = getNotificationUri(notificationUri),
        super(key: key);

  UniversalImage.venueBackground(
    String? venueBackgroundUri, {
    this.width,
    this.height,
    this.color,
    Key? key,
  })  : fit = BoxFit.cover,
        cache = false,
        imageUri = getVenueBackgroundUri(venueBackgroundUri),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    initialize();

    double? size;
    try {
      size = context.read<UniversalImageSizeProvider>().size;
    } catch (ex) {}

    if (imageUri.isEmpty) {
      return Placeholder(
        fallbackWidth: width ?? size ?? 400.0,
        fallbackHeight: height ?? size ?? 400.0,
        color: color ?? Color(0xFF455A64),
      );
    }
    if (isSvg) {
      if (isAsset) {
        return SvgPicture.asset(
          imageUri,
          fit: fit ?? BoxFit.contain,
          width: width ?? size,
          height: height ?? size,
          color: color,
          placeholderBuilder: (context) => Center(
            child: AdaptiveProgressIndicator(),
          ),
        );
      } else {
        return SvgPicture.network(
          imageUri,
          fit: fit ?? BoxFit.contain,
          width: width ?? size,
          height: height ?? size,
          color: color,
          placeholderBuilder: (context) => Center(
            child: AdaptiveProgressIndicator(),
          ),
        );
      }
    }
    if (isAsset) {
      return Image.asset(
        imageUri,
        fit: fit ?? BoxFit.contain,
        width: width ?? size,
        height: height ?? size,
        color: color,
      );
    }

    if (isLink) {
      if (cache) {
        return CachedNetworkImage(
          imageUrl: imageUri,
          fit: fit ?? BoxFit.contain,
          width: width ?? size,
          height: height ?? size,
          color: color,
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return SizedBox(
              width: width ?? size,
              height: height ?? size,
              child: Center(
                child: AdaptiveProgressIndicator(
                  value: downloadProgress.progress,
                ),
              ),
            );
          },
          errorWidget: (context, url, error) {
            return Container(
              width: width ?? size,
              height: height ?? size,
              color: Colors.white,
            );
          },
        );
      }
      return Image.network(
        imageUri,
        fit: fit ?? BoxFit.contain,
        width: width ?? size,
        height: height ?? size,
        color: color,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: width,
            height: height,
            child: Center(
              child: AdaptiveProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.white,
          );
        },
      );
    }

    if (!imageUri.contains("/")) {
      //Invalid file path, doesn't have '/'
      return Placeholder(
        fallbackWidth: width ?? size ?? 400.0,
        fallbackHeight: height ?? size ?? 400.0,
        color: color ?? Color(0xFF455A64),
      );
    }

    return Image.file(
      File(imageUri),
      fit: fit ?? BoxFit.contain,
      width: width ?? size,
      height: height ?? size,
      color: color,
    );
  }
}
