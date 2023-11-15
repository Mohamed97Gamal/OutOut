import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:out_out/widgets/loading/adaptive_progress_indicator.dart';
import 'package:out_out/widgets/loading/custom_paged_list_view.dart';

class PagedList<T> {
  int? nextPage;
  late int pageNumber;
  int? previousPage;
  late int pageSize;
  late int recordsTotalCount;
  late int totalPages;
  late List<T> records;
}

class CustomPagedSliverListView<T> extends StatefulWidget {
  final Future<PagedList<T>> Function(int) initPageFuture;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  CustomPagedSliverListView({
    Key? key,
    required this.initPageFuture,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  _CustomPagedSliverListViewState<T> createState() => _CustomPagedSliverListViewState<T>();
}

class _CustomPagedSliverListViewState<T> extends State<CustomPagedSliverListView<T>> {
  var _pagingController = PagingController<int, T>(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) async {
      try {
        var pagedResult = await widget.initPageFuture(pageKey);
        if (pagedResult.nextPage == null) {
          _pagingController.appendLastPage(pagedResult.records);
        } else {
          _pagingController.appendPage(pagedResult.records, pagedResult.nextPage);
        }
      } catch (ex) {
        _pagingController.error = "Error loading content";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PagedSliverList<int, T>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<T>(
        firstPageErrorIndicatorBuilder: (context) {
          return CustomPagedListViewErrorIndicatorBuilder(pagingController: _pagingController);
        },
        newPageErrorIndicatorBuilder: (context) {
          return CustomPagedListViewErrorIndicatorBuilder(pagingController: _pagingController);
        },
        firstPageProgressIndicatorBuilder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: AdaptiveProgressIndicator(),
            ),
          );
        },
        newPageProgressIndicatorBuilder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: AdaptiveProgressIndicator(),
            ),
          );
        },
        itemBuilder: widget.itemBuilder,
      ),
    );
  }
}
