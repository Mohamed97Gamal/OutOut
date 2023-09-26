import 'dart:math';
import 'package:flutter/material.dart';

class PageViewWithIndicator extends StatefulWidget {
  final List<Widget> _pages;
  final double height;

  const PageViewWithIndicator(this._pages, {this.height = 135.0});

  @override
  _PageViewWithIndicatorState createState() => _PageViewWithIndicatorState();
}

class _PageViewWithIndicatorState extends State<PageViewWithIndicator> {
  final _controller = PageController(viewportFraction: 1.0);
  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
         SizedBox(
          height: widget.height,
          child: PageView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _controller,
            itemCount: widget._pages.length,
            itemBuilder: (context, index) {
              return widget._pages[index];
            },
          ),
        ),
        Container(
          height: 25.0,
          color: Theme.of(context).primaryColorLight,
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: DotsIndicator(
              controller: _controller,
              itemCount: widget._pages.length,
              onPageSelected: (page) {
                _controller.animateToPage(
                  page,
                  duration: _kDuration,
                  curve: _kCurve,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  const DotsIndicator({
    required this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color = Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int? itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int>? onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 5.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 3.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(BuildContext context, int index) {
    final selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    final zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
   return SizedBox(
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: color,
          type: MaterialType.circle,
          child: SizedBox(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: InkWell(
              onTap: () => onPageSelected!(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount!, (index) => _buildDot(context, index)),
    );
  }
}
