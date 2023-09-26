// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_full_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationFullDTO _$OrganizationFullDTOFromJson(Map<String, dynamic> json) {
  return OrganizationFullDTO()
    ..isActivated = json['isActivated'] as bool
    ..id = json['id'] as String
    ..key = json['key'] as String
    ..name = json['name'] as String
    ..logoPath = json['logoPath'] as String
    ..business = json['business'] as String
    ..website = json['website'] as String
    ..contactNumber = json['contactNumber'] as String
    ..addresses = (json['addresses'] as List?)
        ?.map((e) => AddressDTO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..domains = (json['domains'] as List)?.map((e) => e as String)?.toList()
    ..logo = json['logo'] as String
    ..adminsCount = json['adminsCount'] as int
    ..employeesCount = json['employeesCount'] as int;
}

Map<String, dynamic> _$OrganizationFullDTOToJson(
        OrganizationFullDTO instance) =>
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
      'adminsCount': instance.adminsCount,
      'employeesCount': instance.employeesCount,
    };
