import 'package:flairstechsuite_mobile/features/announcement/domain/entity/announcement.dart';
import 'package:flairstechsuite_mobile/features/announcement/presentation/widgets/view_screen/view_announcement_item.dart';
import 'package:flairstechsuite_mobile/utils/load_more_delegate.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

class ViewAnnouncementBody extends StatelessWidget {
  final VoidCallback? refresh;
  final Future<bool> Function()? onLoadMore;
  final bool? hasData;
  final List<AnnouncementEntity>? announcements;
  final int? recordsTotalCount;
  const ViewAnnouncementBody(
      {Key? key,
      this.refresh,
      this.onLoadMore,
      this.hasData,
      this.announcements,
      this.recordsTotalCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => refresh!(),
      child: LoadMore(
        delegate: const MyLoadMoreDelegate(),
        onLoadMore: onLoadMore!,
        isFinish: hasData! ? announcements!.length >= recordsTotalCount! : false,
        child: ListView.separated(
          itemCount: announcements?.length ?? 0,
          key: PageStorageKey("view_announcements_list"),
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          itemBuilder: (context, index) => AnnouncementViewItem(
              refresh: refresh, announcement: announcements![index]),
        ),
      ),
    );
  }
}