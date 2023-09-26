// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploaded_file_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadedFileDTO _$UploadedFileDTOFromJson(Map<String, dynamic> json) {
  return UploadedFileDTO(
    id: json['id'] as String,
    fullName: json['fullName'] as String,
  );
}

Map<String, dynamic> _$UploadedFileDTOToJson(UploadedFileDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
    };
