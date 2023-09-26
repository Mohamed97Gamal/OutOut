// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilerResponse _$FilerResponseFromJson(Map<String, dynamic> json) {
  return FilerResponse(
    file: json['file'] as String,
    fileName: json['fileName'] as String,
  );
}

Map<String, dynamic> _$FilerResponseToJson(FilerResponse instance) =>
    <String, dynamic>{
      'file': instance.file,
      'fileName': instance.fileName,
    };
