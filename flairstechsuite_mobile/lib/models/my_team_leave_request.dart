import 'package:json_annotation/json_annotation.dart';

part 'my_team_leave_request.g.dart';

@JsonSerializable()
class MyTeamLeaveRequest {
  List<String?>? employeesOrganizationEmails;
  int? leaveRequest;
  bool? directReporteesOnly;
  DateTime? from;
  DateTime? to;

  MyTeamLeaveRequest({
    this.employeesOrganizationEmails,
    this.leaveRequest,
    this.directReporteesOnly,
    this.from,
    this.to,
  });

  factory MyTeamLeaveRequest.fromJson(Map<String, dynamic> json) => _$MyTeamLeaveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MyTeamLeaveRequestToJson(this);
}
