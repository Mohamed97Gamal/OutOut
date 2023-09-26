import 'package:flairstechsuite_mobile/features/announcement/data/model/announcement_dto.dart';
import 'package:flairstechsuite_mobile/features/announcement/data/repository/announcement_repo_impl.dart';
import 'package:flairstechsuite_mobile/features/announcement/presentation/widgets/edit_screen/bottom_sheet_widget.dart';
import 'package:flairstechsuite_mobile/features/announcement/presentation/widgets/edit_screen/edit_announcement_image.dart';
import 'package:flairstechsuite_mobile/features/announcement/presentation/widgets/edit_screen/edit_announcement_textfield.dart';
import 'package:flairstechsuite_mobile/features/announcement/presentation/widgets/edit_screen/image_widget.dart';
import 'package:flairstechsuite_mobile/features/announcement/presentation/widgets/edit_screen/radio_button_column.dart';
import 'package:flairstechsuite_mobile/utils/common.dart';
import 'package:flairstechsuite_mobile/widgets/basic/scale_down.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateEditAnnouncementScreen extends StatefulWidget {
  final AnnouncementDTO? announcement;

  CreateEditAnnouncementScreen({this.announcement});

  @override
  State<StatefulWidget> createState() => _CreateEditAnnouncementScreenState();
}

class _CreateEditAnnouncementScreenState
    extends State<CreateEditAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? _titleController;
  TextEditingController? _bodyController;
  _ImageEditState? _imageState;
  bool? _willPublish;
  var _willSend = false;
  var _didPressSave = false;

  @override
  void initState() {
    super.initState();
    final announcement = widget.announcement;
    _titleController ??= TextEditingController(text: announcement?.title);
    _bodyController ??= TextEditingController(text: announcement?.body);
    _willPublish ??= (announcement?.isPublished ?? false);
    if (_imageState == null) {
      _imageState = announcement?.imagePath != null
          ? _RemoteImage(url: announcement!.imagePath!)
          : _NoImage();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController!.dispose();
    _bodyController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationScaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: ScaleDown(
          child: Text(((widget.announcement == null ? "Create" : "Edit") +
                  " Announcement")
              .toUpperCase()),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
   return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: _didPressSave
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            children: [
              EditAnnouncementImage(
                buildImage: ImageWidget(
                    imageState: _imageState,
                    isFileImage: _imageState is _FileImage,
                    isNetworkImage: _imageState is _RemoteImage,
                    isNoImage: _imageState is _NoImage),
                onTap: () => _onEditImage(context),
              ),
              const SizedBox(height: 16),
              EditAnnouncementTextField(
                titleController: _titleController,
                bodyController: _bodyController,
                haveImage: _imageState is _NoImage,
              ),
              const SizedBox(height: 16),
              RadioButtonsColumn(
                announcement: widget.announcement,
                willPublish: _willPublish,
                willSend: _willSend,
                onTapPublish: () => setState(() {
                  _willPublish = !_willPublish!;
                  if (!_willPublish!) _willSend = false;
                }),
                onTapNotification: () => setState(() => _willSend = !_willSend),
              ),
              const SizedBox(height: 24),
              Container(
                constraints: const BoxConstraints(minWidth: 148),
                child: ElevatedButton(
                  child: Text(_saveLabel.toUpperCase()),
                  onPressed: _onSave,
                ),
              ),
              const SizedBox(height: 44),
            ],
          ),
        ),
      ),
    );
  }

  String get _saveLabel {
    if (widget?.announcement?.isPublished == true) {
      if (_willSend) return "Save & Send notification";
      return "Save";
    }
    if (_willSend && _willPublish!) return "Publish & Send notification";
    if (_willPublish!) return "Publish";
    return "Save";
  }

  _onEditImage(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final state = _imageState;
    final canRestore =
        state is! _RemoteImage && widget.announcement?.imagePath != null;
    final canRemove = state is! _NoImage;

    if (!canRemove && !canRestore) {
      await _openImagePicker(context, source: ImageSource.gallery);
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetWidget(
          canRemove: canRemove,
          canRestore: canRestore,
          onTapPick: () async {
             Navigator.of(context).pop();
            await _openImagePicker(context, source: ImageSource.gallery);
          },
          onTapRestore: () async {
             Navigator.of(context).pop();
            setState(() => _imageState =
                _RemoteImage(url: widget.announcement?.imagePath??""));
          },
          onTapRemove: () async {
            Navigator.of(context).pop();
            setState(() => _imageState = _NoImage());
          },
        );
      },
    );
  }

  _onSave() async {
    FocusScope.of(context).unfocus();
    setState(() => _didPressSave = true);
    if (!_formKey.currentState!.validate()) {
      // ignore: deprecated_member_use
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fix the errors in red before submitting.")),
      );
      return;
    }
    final announcementController = AnnouncementRepositoryImpl(
        context: context,
        title: _titleController?.text?.trim(),
        body: _bodyController?.text?.trim(),
        publish: _willPublish,
        imagePath: tryCast<_FileImage>(_imageState)?.path,
        sendNotification: _willSend);
    if (widget.announcement != null) {
      await announcementController.updateAnnouncement(
          widget.announcement, _imageState is! _RemoteImage);
      return;
    }
    await announcementController.createAnnouncement();
  }

  _openImagePicker(BuildContext context, {required ImageSource source}) async {
    assert(source != null);
    final imageFile = await ImagePicker().pickImage(source: source);
    if (imageFile?.path == null) return;
    setState(() => _imageState = _FileImage(path: imageFile!.path));
  }
}

abstract class _ImageEditState {
  const _ImageEditState._();
}

class _NoImage extends _ImageEditState {
  const _NoImage() : super._();
}

class _RemoteImage extends _ImageEditState {
  final String url;

  const _RemoteImage({required this.url})
      : assert(url != null),
        super._();
}

class _FileImage extends _ImageEditState {
  final String path;

  const _FileImage({required this.path})
      : assert(path != null),
        super._();
}
