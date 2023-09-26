// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_team_leave_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyTeamLeaveRequest _$MyTeamLeaveRequestFromJson(Map<String, dynamic> json) {
  return MyTeamLeaveRequest(
    employeesOrganizationEmails: (json['employeesOrganizationEmails'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    leaveRequest: json['leaveRequest'] as int,
    directReporteesOnly: json['directReporteesOnly'] as bool,
    from: json['from'] == null ? null : DateTime.parse(json['from'] as String),
    to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
  );
}

Map<String, dynamic> _$MyTeamLeaveRequestToJson(MyTeamLeaveRequest instance) =>
    <String, dynamic>{
      'employeesOrganizationEmails': instance.employeesOrganizationEmails,
      'leaveRequest': instance.leaveRequest,
      'directReporteesOnly': instance.directReporteesOnly,
      'from': instance.from?.toIso8601String(),
      'to': instance.to?.toIso8601String(),
    };
