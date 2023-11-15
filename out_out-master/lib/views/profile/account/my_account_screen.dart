import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/assets/image_assets.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/avatar.dart';
import 'package:out_out/widgets/containers/custom_flat_scaffold.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAccountProvider = context.watch<MyAccountProvider>();
    return Refreshable(
      refreshNotifier: myAccountProvider.refreshNotifier,
      child: CustomFlatScaffold(
        body: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height - 80.0,
              padding: const EdgeInsets.only(top: 30.0),
              child: Card(
                elevation: 8.0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              bottom: 8.0,
              child: Column(
                children: [
                  Avatar(
                    myAccountProvider.applicationUserResponse.profileImage,
                    overlay: GestureDetector(
                      onTap: () {
                        if (myAccountProvider.applicationUserResponse.profileImage == null ||
                            myAccountProvider.applicationUserResponse.profileImage!.isEmpty) {
                          Navigation().navToFullImageScreen(
                            context,
                            imageUri: ImageAssets.defaultAvatar,
                          );
                          return;
                        }
                        Navigation().navToFullImageScreen(
                          context,
                          imageUri: myAccountProvider.applicationUserResponse.profileImage!,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      myAccountProvider.applicationUserResponse.fullName,
                      textAlign: TextAlign.center,
                      maxLines: 10,
                      style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  CustomAccountField(
                    icon: UniversalImage(IconAssets.phone, width: 20),
                    value: myAccountProvider.applicationUserResponse.phoneNumber ?? "N/A",
                  ),
                  const SizedBox(height: 8.0),
                  CustomAccountField(
                    icon: UniversalImage(IconAssets.mail, color: Colors.grey, width: 20),
                    value: myAccountProvider.applicationUserResponse.email,
                  ),
                  const SizedBox(height: 8.0),
                  if (myAccountProvider.applicationUserResponse.gender != null)
                    CustomAccountField(
                      icon: UniversalImage(IconAssets.gender, width: 20),
                      value: myAccountProvider.applicationUserResponse.gender!.name,
                    ),
                ],
              ),
            ),
            Positioned(
              right: 20.0,
              top: 50.0,
              child: Material(
                shape: CircleBorder(),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {
                    Navigation().navToEditMyProfileScreen(context);
                  },
                  icon: UniversalImage(IconAssets.edit),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAccountField extends StatelessWidget {
  const CustomAccountField({
    Key? key,
    required this.icon,
    required this.value,
  }) : super(key: key);

  final String? value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          enabled: false,
          initialValue: value,
          style: TextStyle(color: Colors.grey),
          cursorColor: Colors.black,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            filled: false,
            hintStyle: TextStyle(color: Colors.grey),
            prefixIconConstraints: BoxConstraints(minWidth: 40.0),
            prefixIcon: icon,
          ),
        ),
      ),
    );
  }
}
