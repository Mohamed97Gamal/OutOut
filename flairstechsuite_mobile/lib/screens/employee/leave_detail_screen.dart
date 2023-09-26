import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../enums/half_day_type.dart';
import '../../enums/leave_request_status.dart';
import '../../enums/leave_request_type.dart';
import '../../models/file_dto.dart';
import '../../models/leave_request_dto.dart';
import '../../repo/repository.dart';
import '../../utils/all_text_utils.dart';
import '../../utils/colors.dart';
import '../../widgets/basic/confirmation_dialog.dart';
import '../../widgets/basic/future_dialog.dart';
import '../../widgets/basic/scale_down.dart';
import '../../widgets/my_balance/note_by_manager_item.dart';
import '../../widgets/my_balance/title_value_pair_item.dart';
import '../../widgets/notification_scaffold.dart';

class LeaveDetailsScreen extends StatelessWidget {
  final LeaveRequestDTO? leaveRequestDTO;

  const LeaveDetailsScreen({Key? key, required this.leaveRequestDTO}) : super(key: key);

  String getDateFormat(String? dateTime) {
    if (dateTime != null) {
      final dateTimeConverted = DateTime.parse(dateTime).toLocal();
      final formatter = DateFormat('d  MMM yyyy');
      final formatted = formatter.format(dateTimeConverted);
      return formatted;
    } else {
      return "N/A";
    }
  }

  String getFromFormat(String? dateTime) {
    if (dateTime != null) {
      final dateTimeConverted = DateTime.parse(dateTime);
      final formatter = DateFormat('d  MMM yyyy');
      final formatted = formatter.format(dateTimeConverted.add(Duration(hours: 2)));
      return formatted;
    } else {
      return "N/A";
    }
  }

  String getToFormat(String? dateTime) {
    if (dateTime != null) {
      var dateTimeConverted = DateTime.parse(dateTime);
      dateTimeConverted = DateTime(dateTimeConverted.year, dateTimeConverted.month, dateTimeConverted.day);
      final formatter = DateFormat('d  MMM yyyy');
      final formatted = formatter.format(dateTimeConverted);
      return formatted;
    } else {
      return "N/A";
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ScaleDown(child: Text("Leave Details".toUpperCase())),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TitleValuePairItem(
                title: "ID",
                value: leaveRequestDTO!.readableId.toString(),
              ),
              TitleValuePairItem(
                title: "Type",
                value: LeaveRequestType.fromJson(leaveRequestDTO!.type).name,
              ),
             if (leaveRequestDTO!.halfDayType != null)
                TitleValuePairItem(
                  title: "Half-day timing",
                  value: HalfDayType.fromJson(leaveRequestDTO!.halfDayType).name,
                ),
              TitleValuePairItem(
                title: "Creation Date",
                value: getDateFormat(leaveRequestDTO!.creationDate),
              ),
              leaveRequestDTO!.requester != null
                  ? TitleValuePairItem(
                title: "Requester",
                value: leaveRequestDTO!.requester.toString(),
              )
                  : Container(),
              leaveRequestDTO!.leaveType != null
                  ? TitleValuePairItem(
                title: "leaveType",
                value: LeaveRequestType.fromJson(leaveRequestDTO!.leaveType).name,
              )
                  : Container(),
              // leaveRequestDTO.allocationType != null
              //     ? TitleValuePairItem(
              //         title: "allocationType",
              //         value: LeaveAllocationType.fromJson(leaveRequestDTO.allocationType).name,
              //       )
              //     : Container(),
              leaveRequestDTO!.from == null && leaveRequestDTO!.to == null
                  ? Container()
                  : Column(
                children: [
                  TitleValuePairItem(
                    title: "From",
                    value: getFromFormat(leaveRequestDTO!.from),
                  ),
                  TitleValuePairItem(
                    title: "To",
                    value: getToFormat(leaveRequestDTO!.to),
                  ),
                ],
              ),
              leaveRequestDTO!.cycleName != null
                  ? TitleValuePairItem(
                title: "cycleName",
                value: leaveRequestDTO!.cycleName,
              )
                  : Container(),
              leaveRequestDTO!.actionBy != null
                  ? NoteByManagerItem(
                title: "Action by",
                value: leaveRequestDTO!.actionBy,
              )
                  : Container(),
              leaveRequestDTO!.actionDate != null
                  ? TitleValuePairItem(
                title: "action Date",
                value: getDateFormat(leaveRequestDTO!.actionDate),
              )
                  : Container(),
              TitleValuePairItem(
                title: "Status",
                value: LeaveRequestStatus.fromJson(leaveRequestDTO!.status).name,
                valueColor: LeaveRequestStatus.fromJson(leaveRequestDTO!.status).color,
              ),
              leaveRequestDTO!.addedBalance != null && leaveRequestDTO!.type == LeaveRequestType.allocation.value
                  ? TitleValuePairItem(
                  title: "Added Balance",
                  value: "${leaveRequestDTO!.addedBalance}")
                  : Container(),
              leaveRequestDTO!.requestedDays == null && leaveRequestDTO!.recoveredDays == null
                  ? Container()
                  : TitleValuePairItem(
                  title: leaveRequestDTO!.type == LeaveRequestType.balanceManagement.value ? "Count of Recovered Days" : "Count of Days",
                  value: "${leaveRequestDTO!.requestedDays ?? leaveRequestDTO!.recoveredDays}"),
              leaveRequestDTO!.uploadedFiles != null && leaveRequestDTO!.uploadedFiles!.isNotEmpty
                  ? Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: RedBoldTitleText(text: "Attachments", size: 22.0)),
                      Expanded(
                        child: ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: leaveRequestDTO!.uploadedFiles!.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                      "${leaveRequestDTO!.uploadedFiles![index].fullName ?? "N/A"}",
                                      style: TextStyle(overflow: TextOverflow.ellipsis),
                                    )),
                                InkWell(
                                  onTap: () async {
                                    var isPdf = false;
                                    String? fileName = "";
                                    await showFutureProgressDialog<void>(
                                      context: context,
                                      nullable: true,
                                      message: "Downloading your attachment",
                                      initFuture: () async {
                                        final response = await Repository()
                                            .downloadBase64File(fileId: leaveRequestDTO!.uploadedFiles![index].id, requestId: leaveRequestDTO!.id);
                                        response.result!.fileName!.endsWith("pdf")
                                            ? await saveFile(Base64Decoder().convert(response.result!.file!), response.result!.fileName)
                                            : await _saveImage(response.result);
                                        isPdf = response.result!.fileName!.endsWith("pdf");
                                        fileName = response.result!.fileName;
                                      },
                                    );
                                    if (!isPdf) {
                                      await showConfirmationDialog(
                                          context: context,
                                          actionText: "$fileName  has been downloaded successfully",
                                          icon: FontAwesomeIcons.download,
                                          showFalseAction: false,
                                          showTitle: false,
                                          title: "",
                                          trueTitle: "OK");
                                    }
                                  },
                                  child: Icon(Icons.download),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    color: MyColors.grayColor,
                    height: 0.5,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 16.0),
                ],
              )
                  : Container(),
              leaveRequestDTO!.reason != null ? NoteByManagerItem(title: "Reason", value: leaveRequestDTO!.reason) : Container(),
              leaveRequestDTO!.rejectionNote != null
                  ? NoteByManagerItem(
                title: "rejection Note",
                value: leaveRequestDTO!.rejectionNote,
              )
                  : Container(),
              leaveRequestDTO!.noteByTeamManager != null
                  ? NoteByManagerItem(
                title: "note By Team Manager",
                value: leaveRequestDTO!.noteByTeamManager,
              )
                  : Container(),
              leaveRequestDTO!.noteByDirectManager != null
                  ? NoteByManagerItem(
                title: "note By Direct Manager",
                value: leaveRequestDTO!.noteByDirectManager,
              )
                  : Container(),
              leaveRequestDTO!.submittedReason != null
                  ? NoteByManagerItem(
                title: "Submitted Reason",
                value: leaveRequestDTO!.submittedReason,
              )
                  : Container(),
              leaveRequestDTO!.chosenReason != null
                  ? NoteByManagerItem(
                title: "Chosen Reason",
                value: leaveRequestDTO!.chosenReason,
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  _saveImage(FilerResponse? filerResponse) async {
    PermissionStatus permission = await Permission.storage.request();
    if (permission == PermissionStatus.granted) {
      final result =
      await ImageGallerySaver.saveImage(Uint8List.fromList(Base64Decoder().convert(filerResponse!.file!)), quality: 100, name: filerResponse.fileName);
      print(result);
    } else {
      print("Permission not found");
    }
  }

  Future<void> saveFile(List<int> bytes, String? fileName) async {
    PermissionStatus permission = await Permission.storage.request();
    if (permission == PermissionStatus.granted) {
      final path = (Platform.isIOS ? await getApplicationDocumentsDirectory() : await getExternalStorageDirectory())!.path;
      final file = File('$path/$fileName');
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open('$path/$fileName');
    } else {
      print("Permission not found");
    }
  }
}