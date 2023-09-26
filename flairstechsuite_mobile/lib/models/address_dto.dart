import 'package:flairstechsuite_mobile/utils/common.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_dto.g.dart';

@JsonSerializable()
class AddressDTO {
  final String? name;
  final String? description;

  AddressDTO({String? name, String? description})
      : name = nullIfEmpty(name),
        description = nullIfEmpty(description);

  factory AddressDTO.fromJson(Map<String, dynamic> json) => _$AddressDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDTOToJson(this);

  AddressDTO copyWith({String? name, String? description}) {
    return AddressDTO(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
