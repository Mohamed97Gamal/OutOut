import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetWidget extends StatelessWidget {
  final bool? canRestore;
  final bool? canRemove;
  final void Function()? onTapRestore;
  final void Function()? onTapRemove;
  final void Function()? onTapPick;

  const BottomSheetWidget(
      {Key? key,
      this.canRestore,
      this.canRemove,
      this.onTapRestore,
      this.onTapRemove,
      this.onTapPick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subtitle1!;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              leading: FaIcon(Icons.photo_library, color: textTheme.color),
              title: Text("Pick from Gallery", style: textTheme),
              onTap: onTapPick),
          if (canRestore!)
            ListTile(
              leading: FaIcon(Icons.restore, color: textTheme.color),
              title: Text("Restore original image", style: textTheme),
              onTap: onTapRestore,
            ),
          if (canRemove!)
            ListTile(
              leading: FaIcon(FontAwesomeIcons.solidTrashAlt,
                  color: textTheme.color),
              title: Text("Remove Image", style: textTheme),
              onTap: onTapRemove,
            ),
        ],
      ),
    );
  }
}
