import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FileItem extends StatelessWidget {
  final String? uploadedFile;
  final String? fileName;
  final int? fileNumber;
  const FileItem({Key? key, this.uploadedFile, this.fileName, this.fileNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: uploadedFile!.endsWith(".pdf")
          ? _buildFileImage(context, isPdf: true)
          : _buildFileImage(context, path: uploadedFile, isPdf: false),
      title: Text(
        'File $fileNumber : $fileName',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildFileImage(BuildContext context, {String? path, required bool isPdf}) {
    if (isPdf)
      return SvgPicture.asset(
        "assets/imgs/icons/pdf_icon.svg",
        width: 50,
        height: 50,
        fit: BoxFit.contain,
      );
    else
      return Image.file(
        File(path!),
        width: 50,
        height: 50,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      );
  }
}
