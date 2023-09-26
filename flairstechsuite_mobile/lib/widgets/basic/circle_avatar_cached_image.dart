import 'package:flairstechsuite_mobile/widgets/basic/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleAvatarCachedImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final Color? backgroundColor;

  const CircleAvatarCachedImage(this.imageUrl, this.radius, {this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        color: backgroundColor ?? Theme.of(context).primaryColor,
        child: CustomCachedNetworkImage(
          imageUrl,
          width: radius * 2,
          height: radius * 2,
          fitMode: BoxFit.cover,
        ),
      ),
    );
  }
}
