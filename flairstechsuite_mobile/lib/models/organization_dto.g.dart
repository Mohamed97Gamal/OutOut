// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationDTO _$OrganizationDTOFromJson(Map<String, dynamic> json) {
  return OrganizationDTO()
    ..isActivated = json['isActivated'] as bool?
    ..id = json['id'] as String?
    ..key = json['key'] as String?
    ..name = json['name'] as String?
    ..logoPath = json['logoPath'] as String?
    ..business = json['business'] as String?
    ..website = json['website'] as String?
    ..contactNumber = json['contactNumber'] as String?
    ..addresses = (json['addresses'] as List?)
        ?.map((e) => AddressDTO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..domains = (json['domains'] as List)?.map((e) => e as String)?.toList()
    ..logo = json['logo'] as String?;
}

Map<String, dynamic> _$OrganizationDTOToJson(OrganizationDTO instance) =>
    <String, dynamic>{
      'isActivated': instance.isActivated,
      'id': instance.id,
      'key': instance.key,
      'name': instance.name,
      'logoPath': instance.logoPath,
      'business': instance.business,
      'website': instance.website,
      'contactNumber': instance.contactNumber,
      'addresses': instance.addresses,
      'domains': instance.domains,
      'logo': instance.logo,
    };
