import 'package:flairstechsuite_mobile/views/splash_art.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

class MyLoadMoreDelegate extends LoadMoreDelegate {
  const MyLoadMoreDelegate();

  @override
  double widgetHeight(LoadMoreStatus status) => 0.0;

  @override
  Widget buildChild(LoadMoreStatus status, {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.chinese}) {
    if (status == LoadMoreStatus.fail) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.error),
            SizedBox(height: 4.0),
            Text("Something went wrong", textAlign: TextAlign.center),
            Text("Tap to try again"),
          ],
        ),
      );
    }
    if (status == LoadMoreStatus.loading) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: const SplashArt(),
      );
    }
    return SizedBox.shrink();
  }
}
