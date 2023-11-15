import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/models/enums/gender.dart';
import 'package:out_out/data/view_models/auth/application_user_response_operation_result.dart';
import 'package:out_out/utils/pick_image_utils.dart';
import 'package:out_out/utils/validators.dart';
import 'package:out_out/views/profile/account/custom_dropdown_account_form_field.dart';
import 'package:out_out/views/profile/account/custom_phone_number_account_form_field.dart';
import 'package:out_out/views/profile/account/custom_text_account_form_field.dart';
import 'package:out_out/widgets/avatar.dart';
import 'package:out_out/widgets/containers/custom_flat_scaffold.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_bottom_sheet.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class EditMyAccountScreen extends StatefulWidget {
  @override
  _EditMyAccountScreenState createState() => _EditMyAccountScreenState();
}

class _EditMyAccountScreenState extends State<EditMyAccountScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return CustomFlatScaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 30.0),
            child: Card(
              elevation: 0.0,
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
            left: 0.0,
            right: 0.0,
            bottom: 8.0,
            child: FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  CustomAvatarFormField(),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      context.read<MyAccountProvider>().applicationUserResponse.fullName,
                      textAlign: TextAlign.center,
                      maxLines: 10,
                      style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  CustomTextAccountFormField(
                    name: "full_name",
                    labelText: "Full Name",
                    initialValue: context.read<MyAccountProvider>().applicationUserResponse.fullName,
                    isRequired: true,
                    icon: UniversalImage(IconAssets.profile, width: 20),
                    validators: [Validators.fullName],
                  ),
                  const SizedBox(height: 8.0),
                  CustomPhoneNumberAccountFormField(
                    codeName: "phone_number_code",
                    numberName: "phone_number_number",
                    labelText: "Phone Number",
                    initialValue: context.read<MyAccountProvider>().applicationUserResponse.phoneNumber ?? "+971",
                    isRequired: true,
                    icon: UniversalImage(IconAssets.phone, width: 20),
                  ),
                  const SizedBox(height: 8.0),
                  CustomTextAccountFormField(
                    isEnabled: false,
                    name: "email",
                    labelText: "Email",
                    initialValue: context.read<MyAccountProvider>().applicationUserResponse.email,
                    icon: UniversalImage(IconAssets.mail, color: Color(0xffc3c3c3), width: 20),
                    validators: [Validators.email],
                  ),
                  const SizedBox(height: 8.0),
                  CustomDropdownAccountFormField<Gender>(
                    isRequired: true,
                    name: "gender",
                    labelText: "Gender",
                    initialValue: context.read<MyAccountProvider>().applicationUserResponse.gender,
                    hintText: "Select Gender",
                    icon: UniversalImage(IconAssets.gender, width: 20),
                    items: Gender.availableOptions,
                    itemBuilder: (context, item) => Text(item.name),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    height: 40.0,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(shadowColor: Theme.of(context).primaryColor),
                      onPressed: () async {
                        var formState = _formKey.currentState;
                        if (formState == null) return;
                        if (!formState.saveAndValidate()) {
                          return;
                        }

                        final fullName = formState.value["full_name"];
                        final phoneNumber = formState.value["phone_number_number"] != null &&
                                formState.value["phone_number_number"] != ""
                            ? formState.value["phone_number_code"] + formState.value["phone_number_number"]
                            : "";
                        final gender = formState.value["gender"] as Gender;
                        final picked_avatar = formState.value["picked_avatar"] as XFile?;
                        final delete_avatar = formState.value["delete_avatar"] as bool?;
                        var updateAccountInfoResult =
                            await showFutureProgressDialog<ApplicationUserResponseOperationResult>(
                          context: context,
                          initFuture: () async {
                            return await ApiRepo().customersClient.updateAccountInfo(
                                  fullName: fullName,
                                  phoneNumber: phoneNumber,
                                  gender: gender.value,
                                  profileImage: picked_avatar != null ? File(picked_avatar.path) : null,
                                  removeProfileImage: delete_avatar ?? false,
                                );
                          },
                        );
                        if (updateAccountInfoResult != null && updateAccountInfoResult.status) {
                          await showAdaptiveAlertDialog(
                            context: context,
                            icon: UniversalImage(IconAssets.done),
                            title: "Changes Saved",
                            content: "Your changes have been successfully saved",
                            showCloseButton: false,
                          );
                          context.read<MyAccountProvider>().update(updateAccountInfoResult.result);
                          Navigator.of(context).maybePop();
                        } else {
                          await showAdaptiveErrorDialog(
                            context: context,
                            title: "Error",
                            content: updateAccountInfoResult?.errorMessage ?? "Unknown Error",
                          );
                        }
                      },
                      child: Text(
                        "Save",
                        style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
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
                onPressed: null,
                icon: UniversalImage(IconAssets.edit, width: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAvatarFormField extends StatefulWidget {
  const CustomAvatarFormField({
    Key? key,
  }) : super(key: key);

  @override
  _CustomAvatarFormFieldState createState() => _CustomAvatarFormFieldState();
}

class _CustomAvatarFormFieldState extends State<CustomAvatarFormField> {
  bool deleteAvatar = false;
  XFile? pickedAvatar;

  @override
  Widget build(BuildContext context) {
    String? avatarUri = context.read<MyAccountProvider>().applicationUserResponse.profileImage;
    if (pickedAvatar != null) {
      avatarUri = pickedAvatar!.path;
    }
    if (deleteAvatar) {
      avatarUri = null;
    }
    return Avatar(
      avatarUri,
      overlay: Container(
        color: Colors.black.withOpacity(0.25),
        child: InkWell(
          onTap: () => _handlePressed(context),
          child: Icon(
            Icons.camera_alt_outlined,
            color: Colors.white,
            size: 35.0,
          ),
        ),
      ),
    );
  }

  _handlePressed(BuildContext context) async {
    await showAdaptiveBottomSheet(
      context: context,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "Change Avatar",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      actions: <AdaptiveBottomSheetAction>[
        AdaptiveBottomSheetAction(
          title: "Select From Gallery",
          onPressed: () async {
            final pickedImage = await pickImageFromGallery();
            if (pickedImage != null) {
              final pickedImageBytes = await pickedImage.readAsBytes();
              if (pickedImageBytes.length > 8 * 1024 * 1024) {
                await showAdaptiveErrorDialog(
                  context: context,
                  title: "Invalid Image",
                  content: "This image size is too large, try uploading a smaller image.",
                );
                return;
              }
              FormBuilder.of(context)?.removeInternalFieldValue("delete_avatar");
              FormBuilder.of(context)?.setInternalFieldValue("picked_avatar", pickedImage);
              setState(() {
                deleteAvatar = false;
                pickedAvatar = pickedImage;
              });
            }
            Navigator.of(context).maybePop();
          },
          isPrimary: true,
        ),
        AdaptiveBottomSheetAction(
          title: "Delete Image",
          onPressed: () {
            FormBuilder.of(context)?.setInternalFieldValue("delete_avatar", true);
            FormBuilder.of(context)?.setInternalFieldValue("picked_avatar", null);
            setState(() {
              deleteAvatar = true;
              pickedAvatar = null;
            });
            Navigator.of(context).maybePop();
          },
        ),
      ],
    );
  }
}
