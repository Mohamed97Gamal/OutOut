import 'package:cached_network_image/cached_network_image.dart';
import 'package:flairstechsuite_mobile/features/announcement/domain/entity/announcement.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AnnouncementViewItem extends StatelessWidget {
  final Function()? refresh;
  final AnnouncementEntity? announcement;
  const AnnouncementViewItem({Key? key, this.announcement, this.refresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUnread = !announcement!.isRead! && announcement!.isPublished!;
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      elevation: isUnread ? 4 : 1,
      shadowColor: isUnread ? Theme.of(context).primaryColor : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        side: BorderSide(
          color: isUnread ? Theme.of(context).primaryColor : Colors.grey,
          width: 0.7,
        ),
      ),
      child: InkWell(
        onTap: () async {
          final result = await Navigation.navToAnnouncementDetails(context,
              announcementId: announcement!.id);
          if (result == true) refresh!();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (announcement!.imagePath != null && announcement!.imagePath!.isNotEmpty)
              Container(
                color: Colors.black12,
                child: CachedNetworkImage(
                  height: 100,
                  width: double.infinity,
                  placeholder: (_, __) =>
                      Center(child: AdaptiveProgressIndicator()),
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
                  imageUrl: announcement!.imagePath!,
                ),
              ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  top: 8, bottom: 8, start: 16, end: 16),
              child: Text(
                announcement!.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                // style: theme.textTheme.headline6,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: MyColors.darkGrayColor),
              ),
            ),
            if (announcement!.body != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16, end: 16),
                child: MarkdownBody(
                  data: announcement!.body!,
                  selectable: true,
                ),
              ),
            const SizedBox(height: 4)
          ],
        ),
      ),
    );
  }
}
