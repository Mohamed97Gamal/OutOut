import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class ChangeLocation extends StatelessWidget {
  final EdgeInsets padding;

  const ChangeLocation({
    Key? key,
    this.padding = const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentLocationDescription = context.select<MyAccountProvider, String>(
      (myAccountProvider) => myAccountProvider.applicationUserResponse.location.description,
    );
    return Hero(
      tag: "ChangeLocation",
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.white,
                child: UniversalImage(
                  IconAssets.location,
                  width: 20,
                  height: 20,
                ),
              ),
              const SizedBox(width: 8.0),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
                child: Text(
                  currentLocationDescription,
                  style: Theme.of(context).textTheme.bodyText1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                constraints: BoxConstraints(maxHeight: 30.0),
                icon: Icon(Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor),
                onPressed: () => Navigation().navToChangeLocationScreen(context),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
