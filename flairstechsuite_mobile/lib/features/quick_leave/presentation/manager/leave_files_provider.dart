import 'dart:io';

import 'package:file_picker/file_picker.dart';
import '../../../../widgets/basic/adaptive_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeaveFilesProvider with ChangeNotifier {
  List<String?> uploadedFiles = [];
  List<String?> fileNames = [];

  double totalSize = 0.0;
  double fileSizeInMb = 0.0;

  bool isFileOverSize = false;

  _openFilePicker(BuildContext context,
      {required FileType type, List<String>? allowedExtensions}) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: type,
      allowedExtensions: allowedExtensions,
      //['png', 'pdf', 'jpg', 'jpeg'],
    );
    if (result == null) return;
    _calculateFileSize(result.files, context);
    if (totalSize < 3 && totalSize != 0.0) {
      if (!isFileOverSize) {
        if (uploadedFiles.isEmpty) {
          if (result.names.isNotEmpty) {
            fileNames = result.names;

            final files = result.paths.map((path) => path).toList();
            uploadedFiles = files;
          }
        } else {
          for (var name in result.names) {
            fileNames.add(name);
          }
          for (var file in result.files) {
            uploadedFiles.add(file.path);
          }
        }
      }
    }
    notifyListeners();
  }

  void _calculateFileSize(List<PlatformFile> files, BuildContext context) {
    var allFilesSizes = 0.0;
    for (var file in files) {
      final f = File(file.path!);
      final sizeInBytes = f.lengthSync();
      final sizeInMb = sizeInBytes / (1024 * 1024);
      allFilesSizes += sizeInMb;
    }
    if ((totalSize + allFilesSizes) < 3) {
      totalSize += allFilesSizes;
      isFileOverSize = false;
    } else {
      isFileOverSize = true;
      showAdaptiveAlertDialog(
          context: context, content: Text("Maximum Files size is 3 MB"));
    }
  }

  onEditFile(BuildContext context, GlobalKey<ScaffoldState>? scaffoldKey) async {
    FocusScope.of(context).unfocus();
    final canRestore = uploadedFiles.isNotEmpty;
    final canRemove = uploadedFiles.isNotEmpty;

    if (!canRemove && !canRestore) {
      await _openFilePicker(context,
          type: FileType.custom,
          allowedExtensions: ['png', 'pdf', 'jpg', 'jpeg']);
      return;
    }

    final textTheme = Theme.of(context).textTheme.subtitle1;
    showModalBottomSheet(
      context: scaffoldKey!.currentContext!,
      builder: (dialogContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: FaIcon(Icons.file_copy_sharp, color: textTheme!.color),
                title: Text("Pick Files", style: textTheme),
                onTap: () async {
                   Navigator.of(dialogContext).pop();
                  await _openFilePicker(context,
                      type: FileType.custom,
                      allowedExtensions: ['png', 'pdf', 'jpg', 'jpeg']);
                },
              ),
              if (Platform.isIOS)
                ListTile(
                  leading: FaIcon(Icons.photo_library, color: textTheme.color),
                  title: Text("Pick Images", style: textTheme),
                  onTap: () async {
                     Navigator.of(context).pop();
                    await _openFilePicker(context, type: FileType.media);
                  },
                ),
              if (canRemove)
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.solidTrashAlt,
                      color: textTheme.color),
                  title: Text("Remove Files", style: textTheme),
                  onTap: () async {
                     Navigator.of(dialogContext).pop();

                    uploadedFiles.clear();
                    fileNames.clear();
                    totalSize = 0;
                    notifyListeners();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
