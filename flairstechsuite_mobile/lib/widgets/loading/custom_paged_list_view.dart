import 'package:flairstechsuite_mobile/widgets/basic/adaptive_progress_indicator.dart';
import 'package:flairstechsuite_mobile/widgets/loading/custom_paged_sliver_list_view.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CustomPagedListView<T> extends StatefulWidget {
  final Future<PagedList<T>> Function(int) initPageFuture;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget Function(BuildContext context)? emptyBuilder;

  final EdgeInsets padding;
  final Axis scrollDirection;

  CustomPagedListView({
    Key? key,
    required this.initPageFuture,
    required this.itemBuilder,
    this.emptyBuilder,
    this.padding = EdgeInsets.zero,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  @override
  _CustomPagedListViewState<T> createState() => _CustomPagedListViewState<T>();
}

class _CustomPagedListViewState<T> extends State<CustomPagedListView<T>> {
  final _pagingController = PagingController<int, T>(firstPageKey: 0);
  int pageKeyValue = 0;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) async {
      try {
        pageKeyValue = pageKey;
        PagedList<T> pagedResult = await widget.initPageFuture(pageKey);
        if (pageKey == pagedResult.totalPages! - 1) {
          _pagingController.appendLastPage(pagedResult.records!);
        } else {
          _pagingController.appendPage(pagedResult.records!, pagedResult.pageNumber);
        }
      } catch (ex) {
        print(ex.toString());
        _pagingController.error = "Error loading content";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, T>(
      padding: widget.padding,
      scrollDirection: widget.scrollDirection,
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

class CustomPagedListViewErrorIndicatorBuilder extends StatelessWidget {
  final PagingController pagingController;

  const CustomPagedListViewErrorIndicatorBuilder({
    required this.pagingController,
    Key? key,
  })  : _pagingController = pagingController,
        super(key: key);

  final PagingController _pagingController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: InkWell(
        onTap: () => _pagingController.retryLastFailedRequest(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Something Went Wrong"),
              const SizedBox(height: 20.0),
              Text(
                "Network error",
                style: TextStyle(fontSize: 20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh, color: Theme.of(context).primaryColor),
                  Text("Retry", style: TextStyle(color: Theme.of(context).primaryColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
