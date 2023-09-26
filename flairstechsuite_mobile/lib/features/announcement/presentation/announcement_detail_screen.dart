import 'package:flairstechsuite_mobile/features/announcement/data/model/announcement_dto.dart';
import 'package:flairstechsuite_mobile/features/announcement/presentation/widgets/network_image.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/features/announcement/presentation/manager/unread_announcements_provider.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flairstechsuite_mobile/utils/url_launcher_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/basic/scale_down.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class AnnouncementDetailsScreen extends StatefulWidget {
  final String announcementId;

  AnnouncementDetailsScreen({required this.announcementId}) : assert(announcementId != null);

  @override
  _AnnouncementDetailsScreenState createState() => _AnnouncementDetailsScreenState();
}

class _AnnouncementDetailsScreenState extends State<AnnouncementDetailsScreen> {
  var didMarkAsRead = false;
  var isMarkingToRead = false;
  final _refreshableKey = GlobalKey<RefreshableState>();

  markAsReadIfNeeded(AnnouncementDTO announcement) async {
    if (announcement == null || isMarkingToRead) return;
    if (!announcement.isPublished!) return;
    if (announcement.isRead!) return;
    isMarkingToRead = true;
    final response = await Repository().markAnnouncementAsRead(announcement.id);
    isMarkingToRead = false;
    if (response.status) {
      didMarkAsRead = true;
      _refreshableKey.currentState!.refresh();
      Provider.of<UnreadAnnouncementsProvider>(context, listen: false).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(didMarkAsRead);
        return false;
      },
      child: NotificationScaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const ScaleDown(child: Text("ANNOUNCEMENT DETAILS")),
          ),
          body: Refreshable(
            key: _refreshableKey,
            child: RefreshIndicator(
              onRefresh: () async => _refreshableKey.currentState!.refresh(),
              child: CustomFutureBuilder<AnnouncementDetailsResponse>(
                  initFuture: () => Repository().getAnnouncementDetails(widget.announcementId),
                  onSuccess: (context, snapshot) {
                    final announcement = snapshot.data!.result!;
                    markAsReadIfNeeded(announcement);
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (announcement.imagePath != null && announcement.imagePath!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsetsDirectional.only(top: 16, end: 16, start: 16),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                constraints: const BoxConstraints(minHeight: 100, minWidth: double.infinity),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  color: Colors.black12,
                                ),
                                child: AnnouncementNetworkImage(url: announcement.imagePath),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 16, end: 16, start: 16),
                            child: SelectableText(
                              announcement.title!,
                              // style: theme.textTheme.headline6,
                              style: const TextStyle(fontWeight: FontWeight.bold, color: MyColors.darkGrayColor),
                              maxLines: null,
                            ),
                          ),
                          if (announcement.body != null && announcement.body!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsetsDirectional.only(top: 16, end: 16, start: 16),
                              child: MarkdownBody(
                                data: announcement.body!,
                                selectable: true,
                                onTapLink: (text, href, title) => launchURL(href!),
                              ),
                              /*SelectableText(
                                announcement.body,
                                // style: theme.textTheme.bodyText1,
                                style: const TextStyle(
                                    color: MyColors.lightGrayColor),
                              ),*/
                            ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    );
                  }),
            ),
          )),
    );
  }
}
