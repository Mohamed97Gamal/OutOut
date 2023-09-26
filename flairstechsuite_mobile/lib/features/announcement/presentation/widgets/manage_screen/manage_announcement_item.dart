import 'package:cached_network_image/cached_network_image.dart';
import 'package:flairstechsuite_mobile/features/announcement/data/model/announcement_dto.dart';
import 'package:flairstechsuite_mobile/features/announcement/domain/entity/announcement.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_progress_indicator.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flutter/material.dart';

class AnnouncementManageItem extends StatefulWidget {
  final VoidCallback? refresh;
  final AnnouncementEntity? announcement;

  const AnnouncementManageItem({
    Key? key,
    this.announcement,
    this.refresh,
  }) : super(key: key);

  @override
  State<AnnouncementManageItem> createState() => _AnnouncementManageItemState();
}

class _AnnouncementManageItemState extends State<AnnouncementManageItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        side: BorderSide(color: Colors.grey, width: 0.7),
      ),
      child: InkWell(
        onTap: () async {
          final result = await Navigation.navToEditAnnouncement(context,
              announcement: widget.announcement as AnnouncementDTO);
          if (result == true) widget.refresh!();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.announcement!.imagePath != null &&
                widget.announcement!.imagePath!.isNotEmpty)
              Container(
                color: Colors.black12,
                child: CachedNetworkImage(
                  height: 100,
                  width: double.infinity,
                  placeholder: (_, __) =>
                  const Center(child: AdaptiveProgressIndicator()),
                  errorWidget: (context, _, __) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(Icons.error),
                              const SizedBox(height: 4.0),
                              Text("Something went wrong",
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  imageUrl: widget.announcement!.imagePath!,
                ),
              ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  top: 8, bottom: 8, start: 16, end: 16),
              child: Text(
                widget.announcement!.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                // style: theme.textTheme.headline6,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: MyColors.darkGrayColor),
              ),
            ),
            if (widget.announcement!.body != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    bottom: 8, start: 16, end: 16),
                child: Text(
                  widget.announcement!.body!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  // style: theme.textTheme.bodyText1,
                  style: TextStyle(color: MyColors.lightGrayColor),
                ),
              ),
            Theme(
              data: theme.copyWith(
                  buttonTheme: theme.buttonTheme.copyWith(height: 0)),
              child: Container(
                padding: const EdgeInsetsDirectional.only(
                    bottom: 2,end:16),
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 4,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12.0),
                        elevation: 0,
                        backgroundColor: Color(0xffD13827),shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.all(
                          Radius.circular(24.0),
                        ),
                      ),),
                      onPressed:
                      //onPressedPublish,
                          () async =>
                      await _publishUnPublish(widget.announcement),
                      child: Text((widget.announcement!.isPublished!
                          ? "UnPublish"
                          : "Publish")
                          .toUpperCase()),

                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12.0),
    elevation: 0,
    backgroundColor: Color(0xffD13827),shape: RoundedRectangleBorder(
    side: BorderSide(color: Colors.grey.shade300),
    borderRadius: BorderRadius.all(
    Radius.circular(24.0),
    ),
    ),),
                      onPressed:
                      // onPressedNotification,
                      widget.announcement!.isPublished != true
                          ? null
                          : () async {
                        return await _sendNotification(
                            widget.announcement);
                      },
                      child: Text("Send Notification".toUpperCase()),

                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _publishUnPublish(AnnouncementEntity? announcement) async {
    final response = await showFutureProgressDialog<BoolResponse>(
      context: context,
      initFuture: () async {
        if (announcement!.isPublished!) {
          return Repository().unPublishAnnouncement(announcement.id);
        } else {
          return Repository().publishAnnouncement(announcement.id);
        }
      },
    );
    if (response?.status ?? false) {
      await showAdaptiveAlertDialog(
        context: context,
        content: Text(
          "You have successfully ${announcement!.isPublished!
              ? "unpublished"
              : "published"} (${announcement.title})",
        ),
      );
      widget.refresh!();
    } else {
      await showErrorDialog(context, response);
    }
    setState(() {});
  }

  _sendNotification(AnnouncementEntity? announcement) async {
    final response = await showFutureProgressDialog<BoolResponse>(
      context: context,
      initFuture: () =>
          Repository().sendAnnouncementNotification(announcement!.id),
    );
    if (response?.status ?? false) {
      await showAdaptiveAlertDialog(
        context: context,
        content: Text(
          "You have successfully sent a notification for (${announcement!
              .title})",
        ),
      );
    } else {
      await showErrorDialog(context, response);
    }
    setState(() {});
  }
}
