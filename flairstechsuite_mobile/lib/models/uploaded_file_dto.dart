import 'package:json_annotation/json_annotation.dart';

part 'uploaded_file_dto.g.dart';

@JsonSerializable()
class UploadedFileDTO {
  String? id;
  String? fullName;

  UploadedFileDTO({
    this.id,
    this.fullName,
  });


  factory UploadedFileDTO.fromJson(Map<String, dynamic> json) => _$UploadedFileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UploadedFileDTOToJson(this);


}
