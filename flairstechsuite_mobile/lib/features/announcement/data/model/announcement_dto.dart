import 'dart:async';

import 'package:flairstechsuite_mobile/features/announcement/domain/entity/announcement.dart';
import 'package:flairstechsuite_mobile/utils/common.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'announcement_dto.g.dart';

final announcementReadStatusStream = StreamController<void>.broadcast();

@JsonSerializable()
class AnnouncementDTO extends AnnouncementEntity {
  AnnouncementDTO({
    final String? id,
    final String? body,
    final String? title,
    final String? imagePath,
    final bool? isPublished,
    final DateTime? publishedDate,
    final AnnouncementAdmin? publishedBy,
    final DateTime? createdDate,
    final AnnouncementAdmin? createdBy,
    final DateTime? modifiedDate,
    final AnnouncementAdmin? modifiedBy,
    final bool? isRead,
  }) : super(
            body: body,
            title: title,
            imagePath: imagePath,
            isPublished: isPublished,
            publishedDate: publishedDate,
            publishedBy: publishedBy,
            createdDate: createdDate,
            createdBy: createdBy,
            modifiedDate: modifiedDate,
            modifiedBy: modifiedBy,
            isRead: isRead,
            id: id);

  factory AnnouncementDTO.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementDTOToJson(this);
}

@JsonSerializable()
class AnnouncementAdmin {
  final String id;
  final String? fullName;
  final String? title;

  AnnouncementAdmin({
    required this.id,
    String? fullName,
    String? title,
  })  : assert(id != null),
        fullName = nullIfEmpty(fullName),
        title = nullIfEmpty(title);

  factory AnnouncementAdmin.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementAdminFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementAdminToJson(this);
}
