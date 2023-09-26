import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../enums/quick_leaves.dart';
import '../manager/leave_files_provider.dart';
import '../manager/quick_leave_provider.dart';
import 'file_item.dart';

class FilesListView extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const FilesListView({Key? key, this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filesProvider = Provider.of<LeaveFilesProvider>(context);
    final quickLeaveProvider = Provider.of<QuickLeaveProvider>(context);

    if (quickLeaveProvider.selectedQuickLeave == QuickLeave.SickLeave) {
      return Column(
        children: [
          Stack(
            children: [
              Center(
                child: ElevatedButton(
                  child: Text("Browse Files".toUpperCase()),
                  onPressed: () async {
                    Provider.of<LeaveFilesProvider>(context, listen: false).onEditFile(context, scaffoldKey);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
           SizedBox(
            height: filesProvider.uploadedFiles.isEmpty ? 0 : 150.0,
            child: ListView.separated(
              itemCount: filesProvider.uploadedFiles.length,
              itemBuilder: (context, i) {
                final fileNo = i + 1;

                return FileItem(
                  fileName: filesProvider.fileNames[i],
                  uploadedFile: filesProvider.uploadedFiles[i],
                  fileNumber: fileNo,
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: .5,
              ),
            ),
          ),
        ],
      );
    } else {
     return SizedBox();
    }
  }
}
