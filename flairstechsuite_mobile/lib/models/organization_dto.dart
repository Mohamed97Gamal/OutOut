import 'package:flairstechsuite_mobile/models/address_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_dto.g.dart';

@JsonSerializable()
class OrganizationDTO {
  bool? isActivated;
  String? id;
  String? key;
  String? name;
  String? logoPath;
  String? business;
  String? website;
  String? contactNumber;
  List<AddressDTO>? addresses;
  List<String>? domains;
  String? logo;

  bool get isNewEntry => id == null;

  OrganizationDTO();

  factory OrganizationDTO.newEntry() => OrganizationDTO()..addresses = [];

  factory OrganizationDTO.fromJson(Map<String, dynamic> json) => _$OrganizationDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationDTOToJson(this);

  OrganizationDTO copy() {
    return OrganizationDTO()
      ..isActivated = isActivated
      ..id = id
      ..key = key
      ..name = name
      ..logo = logo
      ..logoPath = logoPath
      ..business = business
      ..website = website
      ..contactNumber = contactNumber
      ..addresses = addresses?.toList()
      ..domains = domains?.toList();
  }
}
