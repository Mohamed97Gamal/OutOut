import 'package:flairstechsuite_mobile/models/uploaded_file_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_request_dto.g.dart';

@JsonSerializable()
class LeaveRequestDTO {
  String? id;
  int? readableId;
  int? type;
  String? creationDate;
  String? modificationDate;
  int? status;
  String? reason;
  String? from;
  String? to;
  num? requestedDays;
  String? rejectionNote;
  String? actionBy;
  String? actionDate;
  List<UploadedFileDTO>? uploadedFiles;
  String? requester;
  String? noteByTeamManager;
  String? noteByDirectManager;
  String? cycleName;
  num? recoveredDays;
  num? addedBalance;
  int? leaveType;
  int? allocationType;
  String? chosenReason;
  String? submittedReason;
  int? halfDayType;
  String? targetEmployeeName;

  LeaveRequestDTO({
    this.id,
    this.readableId,
    this.type,
    this.addedBalance,
    this.creationDate,
    this.modificationDate,
    this.status,
    this.reason,
    this.from,
    this.to,
    this.requestedDays,
    this.rejectionNote,
    this.actionBy,
    this.actionDate,
    this.uploadedFiles,
    this.requester,
    this.noteByDirectManager,
    this.noteByTeamManager,
    this.cycleName,
    this.recoveredDays,
    this.leaveType,
    this.allocationType,
    this.submittedReason,
    this.chosenReason,
    this.halfDayType,
    this.targetEmployeeName,
  });


  factory LeaveRequestDTO.fromJson(Map<String, dynamic> json) => _$LeaveRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveRequestDTOToJson(this);


}
