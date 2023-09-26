import 'package:flairstechsuite_mobile/enums/location_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requests.g.dart';

@JsonSerializable()
class AllLocationFilterRequest {
  final List<String>? searchQueries;
  final Set<String>? employeeIds;
  final Set<LocationStatus?>? statuses;

  AllLocationFilterRequest({this.statuses, this.employeeIds, this.searchQueries});

  factory AllLocationFilterRequest.fromJson(Map<String, dynamic> json) => _$AllLocationFilterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AllLocationFilterRequestToJson(this);
}
