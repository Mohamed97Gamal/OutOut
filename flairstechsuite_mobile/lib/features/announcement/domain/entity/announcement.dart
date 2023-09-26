import 'package:equatable/equatable.dart';
import 'package:flairstechsuite_mobile/features/announcement/data/model/announcement_dto.dart';
import 'package:flutter/cupertino.dart';

class AnnouncementEntity extends Equatable {
  final String? id;
  final String? body;
  final String? title;
  final String? imagePath;
  final bool? isPublished;
  final DateTime? publishedDate;
  final AnnouncementAdmin? publishedBy;
  final DateTime? createdDate;
  final AnnouncementAdmin? createdBy;
  final DateTime? modifiedDate;
  final AnnouncementAdmin? modifiedBy;
  final bool? isRead;
  AnnouncementEntity({
    required this.id,
    required this.body,
    required this.title,
    required this.imagePath,
    required this.isPublished,
    required this.isRead,
    required this.publishedDate,
    required this.publishedBy,
    required this.createdDate,
    required this.createdBy,
    required this.modifiedDate,
    required this.modifiedBy,
  });

  @override
  List<Object?> get props => [
        id,
        body,
        title,
        imagePath,
        isPublished,
        publishedDate,
        publishedBy,
        createdDate,
        createdBy,
        modifiedDate,
        modifiedBy,
        isRead,
      ];
}
