import 'package:flairstechsuite_mobile/features/announcement/domain/entity/announcement.dart';
import 'package:flutter/cupertino.dart';

abstract class AnnouncementRepository {
  final BuildContext context;
  final String? title;
  final String? body;
  final bool? publish;
  final String? imagePath;
  final bool sendNotification;
  AnnouncementRepository(
      {required this.title,
      required this.body,
      required this.publish,
      required this.imagePath,
      required this.sendNotification,
      required this.context});

  Future<void> createAnnouncement();
  Future<void> updateAnnouncement(
    AnnouncementEntity announcement,
    bool imageChanged,
  );
}
