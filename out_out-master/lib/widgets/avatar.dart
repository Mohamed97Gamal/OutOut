import 'package:flutter/material.dart';
import 'package:out_out/widgets/universal_image.dart';

class Avatar extends StatelessWidget {
  final String? avatarUri;
  final Widget? overlay;

  Avatar(
    this.avatarUri, {
    Key? key,
    this.overlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "avatar",
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 0.1,
                offset: Offset(-1, 1),
                color: Colors.black.withOpacity(0.10),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 50.0,
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: ClipOval(
                child: Stack(
                  children: [
                    UniversalImage.avatar(avatarUri),
                    if (overlay != null) Positioned.fill(child: overlay!),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
