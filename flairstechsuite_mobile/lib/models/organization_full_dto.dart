import 'package:flairstechsuite_mobile/models/address_dto.dart';
import 'package:flairstechsuite_mobile/models/organization_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_full_dto.g.dart';

@JsonSerializable()
class OrganizationFullDTO extends OrganizationDTO {
  int? adminsCount;
  int? employeesCount;

  OrganizationFullDTO();

  factory OrganizationFullDTO.fromJson(Map<String, dynamic> json) => _$OrganizationFullDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrganizationFullDTOToJson(this);
}
