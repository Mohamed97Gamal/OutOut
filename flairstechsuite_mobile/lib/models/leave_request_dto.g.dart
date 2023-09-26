// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveRequestDTO _$LeaveRequestDTOFromJson(Map<String, dynamic> json) {
  return LeaveRequestDTO(
    id: json['id'] as String?,
    readableId: json['readableId'] as int?,
    type: json['type'] as int?,
    addedBalance: json['addedBalance'] as num?,
    creationDate: json['creationDate'] as String?,
    modificationDate: json['modificationDate'] as String?,
    status: json['status'] as int?,
    reason: json['reason'] as String?,
    from: json['from'] as String?,
    to: json['to'] as String?,
    requestedDays: json['requestedDays'] as num?,
    rejectionNote: json['rejectionNote'] as String?,
    actionBy: json['actionBy'] as String?,
    actionDate: json['actionDate'] as String?,
    uploadedFiles: (json['uploadedFiles'] as List?)
        ?.map((e) =>  UploadedFileDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    requester: json['requester'] as String?,
    noteByDirectManager: json['noteByDirectManager'] as String?,
    noteByTeamManager: json['noteByTeamManager'] as String?,
    cycleName: json['cycleName'] as String?,
    recoveredDays: json['recoveredDays'] as num?,
    leaveType: json['leaveType'] as int?,
    allocationType: json['allocationType'] as int?,
    submittedReason: json['submittedReason'] as String?,
    chosenReason: json['chosenReason'] as String?,
    halfDayType: json['halfDayType'] as int?,
    targetEmployeeName: json['targetEmployeeName'] as String?,
  );
}

Map<String, dynamic> _$LeaveRequestDTOToJson(LeaveRequestDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'readableId': instance.readableId,
      'type': instance.type,
      'creationDate': instance.creationDate,
      'modificationDate': instance.modificationDate,
      'status': instance.status,
      'reason': instance.reason,
      'from': instance.from,
      'to': instance.to,
      'requestedDays': instance.requestedDays,
      'rejectionNote': instance.rejectionNote,
      'actionBy': instance.actionBy,
      'actionDate': instance.actionDate,
      'uploadedFiles': instance.uploadedFiles,
      'requester': instance.requester,
      'noteByTeamManager': instance.noteByTeamManager,
      'noteByDirectManager': instance.noteByDirectManager,
      'cycleName': instance.cycleName,
      'recoveredDays': instance.recoveredDays,
      'addedBalance': instance.addedBalance,
      'leaveType': instance.leaveType,
      'allocationType': instance.allocationType,
      'chosenReason': instance.chosenReason,
      'submittedReason': instance.submittedReason,
      'halfDayType': instance.halfDayType,
      'targetEmployeeName': instance.targetEmployeeName,
    };
