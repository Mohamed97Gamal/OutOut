import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:out_out/widgets/loading/adaptive_progress_indicator.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';
import 'package:out_out/widgets/title_text.dart';

class CustomPagedListView<T> extends StatefulWidget {
  final Future<PagedList<T>> Function(int) initPageFuture;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  final EdgeInsets padding;
  final Axis scrollDirection;

  CustomPagedListView({
    Key? key,
    required this.initPageFuture,
    required this.itemBuilder,
    this.padding = EdgeInsets.zero,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  @override
  _CustomPagedListViewState<T> createState() => _CustomPagedListViewState<T>();
}

class _CustomPagedListViewState<T> extends State<CustomPagedListView<T>> {
  var _pagingController = PagingController<int, T>(firstPageKey: 0);
  int pageKeyValue = 0;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) async {
      try {
        pageKeyValue = pageKey;
        var pagedResult = await widget.initPageFuture(pageKey);
        if (pagedResult.nextPage == null) {
          _pagingController.appendLastPage(pagedResult.records);
        } else {
          _pagingController.appendPage(pagedResult.records, pagedResult.nextPage);
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
              HorizontallyPaddedTitleText("Something Went Wrong"),
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
