import 'package:flairstechsuite_mobile/features/announcement/domain/entity/announcement.dart';
import 'package:flairstechsuite_mobile/features/announcement/domain/repository/announcement_repo.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class AnnouncementRepositoryImpl extends AnnouncementRepository {
  AnnouncementRepositoryImpl({
    required BuildContext context,
    required String? title,
    required String? body,
    required bool? publish,
    required String? imagePath,
    required bool sendNotification,
  }) : super(
          context: context,
          title: title,
          body: body,
          publish: publish,
          imagePath: imagePath,
          sendNotification: sendNotification,
        );

  @override
  Future<void> createAnnouncement() async {
    final response =
        await showFutureProgressDialog<AnnouncementDetailsResponse>(
      context: context,
      initFuture: () => Repository().createAnnouncement(
        title: title,
        body: body,
        publish: publish,
        imagePath: imagePath,
        sendNotification: sendNotification,
      ),
    );
    String msg;
    if (publish! && sendNotification) {
      msg = "published and sent notification";
    } else if (publish!) {
      msg = "published";
    } else {
      msg = "created";
    }
    if (response?.status ?? false) {
      await showAdaptiveAlertDialog(
          context: context, content: Text("Announcement $msg successfully"));
      Navigator.of(context).pop(true);
    } else {
      await showErrorDialog(context, response);
    }
  }

  @override
  Future<void> updateAnnouncement(
    AnnouncementEntity? announcement,
    bool imageChanged,
  ) async {
    final response =
        await showFutureProgressDialog<AnnouncementDetailsResponse>(
      context: context,
      initFuture: () => Repository().updateAnnouncement(
        id: announcement!.id,
        imageChanged: imageChanged,
        title: title,
        body: body,
        publish: publish,
        imagePath: imagePath,
        sendNotification: sendNotification,
      ),
    );
    String msg;
    if (publish! && !announcement!.isPublished! && sendNotification) {
      msg = "published and sent notification";
    } else if (publish! && !announcement!.isPublished!) {
      msg = "published";
    } else if (publish! && sendNotification) {
      msg = "edited and sent notification";
    } else {
      msg = "edited";
    }
    if (response?.status ?? false) {
      await showAdaptiveAlertDialog(
          context: context, content: Text("Announcement $msg successfully"));
      Navigator.of(context).pop(true);
    } else {
      await showErrorDialog(context, response);
    }
  }
}
