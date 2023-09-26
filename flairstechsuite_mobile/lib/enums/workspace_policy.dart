import 'package:json_annotation/json_annotation.dart';

enum WorkspacePolicy {
  @JsonValue(0)
  PersonalLocationsAndOffices,
  @JsonValue(1)
  OnlyOffices
}
