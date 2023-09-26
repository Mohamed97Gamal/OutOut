import 'package:flutter/material.dart';

class EditAnnouncementImage extends StatelessWidget {
  final void Function()? onTap;
  final Widget? buildImage;
  const EditAnnouncementImage({Key? key, this.onTap, this.buildImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:
              const EdgeInsetsDirectional.only(top: 16, end: 16, start: 16),
          child: Container(
            clipBehavior: Clip.antiAlias,
            constraints:
                const BoxConstraints(minHeight: 100, minWidth: double.infinity),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.black12,
            ),
            child: buildImage,
          ),
        ),
        PositionedDirectional(
          end: 6,
          top: 6,
          child: Material(
            type: MaterialType.button,
            color: Colors.black,
            clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(999999)),
            ),
            child: InkWell(
              onTap: onTap,
              //() {
              //   _onEditImage(context);
              // },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.edit,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
