import 'package:flairstechsuite_mobile/widgets/basic/adaptive_progress_indicator.dart';
import 'package:flairstechsuite_mobile/widgets/loading/custom_paged_list_view.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PagedList<T> {
  bool? hasNext;
   int? pageNumber;
  bool? hasPrevious;
   int? pageSize;
   int? recordsTotalCount;
   int? totalPages;
   List<T>? records;
}

class CustomPagedSliverListView<T> extends StatefulWidget {
  final Future<PagedList<T>> Function(int) initPageFuture;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget Function(BuildContext context)? emptyBuilder;

  CustomPagedSliverListView({
    Key? key,
    required this.initPageFuture,
    required this.itemBuilder,
    this.emptyBuilder,
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
        PagedList<T> pagedResult = await widget.initPageFuture(pageKey);
        if (pagedResult.hasNext ==false) {
          _pagingController.appendLastPage(pagedResult.records!);
        } else {
          _pagingController.appendPage(pagedResult.records!, pagedResult.pageNumber);
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
        noItemsFoundIndicatorBuilder: widget.emptyBuilder,
      ),
    );
  }
}
