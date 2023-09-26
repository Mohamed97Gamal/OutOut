// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementDTO _$AnnouncementDTOFromJson(Map<String, dynamic> json) {
  return AnnouncementDTO(
    id: json['id'] as String,
    body: json['body'] as String,
    title: json['title'] as String,
    imagePath: json['imagePath'] as String,
    isPublished: json['isPublished'] as bool,
    publishedDate: json['publishedDate'] == null
        ? null
        : DateTime.parse(json['publishedDate'] as String),
    publishedBy: json['publishedBy'] == null
        ? null
        : AnnouncementAdmin.fromJson(
            json['publishedBy'] as Map<String, dynamic>),
    createdDate: json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
    createdBy: json['createdBy'] == null
        ? null
        : AnnouncementAdmin.fromJson(json['createdBy'] as Map<String, dynamic>),
    modifiedDate: json['modifiedDate'] == null
        ? null
        : DateTime.parse(json['modifiedDate'] as String),
    modifiedBy: json['modifiedBy'] == null
        ? null
        : AnnouncementAdmin.fromJson(
            json['modifiedBy'] as Map<String, dynamic>),
    isRead: json['isRead'] as bool,
  );
}

Map<String, dynamic> _$AnnouncementDTOToJson(AnnouncementDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'title': instance.title,
      'imagePath': instance.imagePath,
      'isPublished': instance.isPublished,
      'publishedDate': instance.publishedDate?.toIso8601String(),
      'publishedBy': instance.publishedBy,
      'createdDate': instance.createdDate?.toIso8601String(),
      'createdBy': instance.createdBy,
      'modifiedDate': instance.modifiedDate?.toIso8601String(),
      'modifiedBy': instance.modifiedBy,
      'isRead': instance.isRead,
    };

AnnouncementAdmin _$AnnouncementAdminFromJson(Map<String, dynamic> json) {
  return AnnouncementAdmin(
    id: json['id'] as String,
    fullName: json['fullName'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$AnnouncementAdminToJson(AnnouncementAdmin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'title': instance.title,
    };
