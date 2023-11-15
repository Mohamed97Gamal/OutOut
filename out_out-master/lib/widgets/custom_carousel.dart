import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarouselItem extends StatelessWidget {
  final Widget content;
  final Widget? subContent;

  CustomCarouselItem({
    required this.content,
    this.subContent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: content,
          ),
          if (subContent != null) subContent!,
        ],
      ),
    );
  }
}

class CustomCarousel extends StatefulWidget {
  final List<Widget> items;
  final bool fullscreenMode;
  final bool showIndicator;
  final double borderRadius;
  final double aspectRatio;
  final bool withCards;
  final ValueChanged<int>? onChanged;
  final int initialPage;
  final bool enableInfiniteScroll;

  const CustomCarousel({
    Key? key,
    required this.items,
    this.borderRadius = 20.0,
    this.aspectRatio = 2.0,
    this.fullscreenMode = true,
    this.showIndicator = true,
    this.withCards = true,
    this.onChanged,
    this.initialPage =0,
    this.enableInfiniteScroll = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomCarouselState();
  }
}

class _CustomCarouselState extends State<CustomCarousel> {
  int _current = 0;

  @override
  void initState() {
    _current = widget.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: [
            if (widget.withCards)
              for (var item in widget.items)
                Card(
                  elevation: 2.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius),
                    ),
                  ),
                  child: item,
                ),
            if (!widget.withCards)
              for (var item in widget.items) item,
          ],
          options: CarouselOptions(
            initialPage: widget.initialPage,
            viewportFraction: 0.90,
            autoPlay: false,
            disableCenter: true,
            enlargeCenterPage: false,
            enableInfiniteScroll: widget.enableInfiniteScroll,
            aspectRatio: widget.aspectRatio,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(_current);
              }
            },
          ),
        ),
        if (widget.showIndicator) const SizedBox(height: 4.0),
        if (widget.showIndicator)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int index = 0; index < widget.items.length; index++) CustomCarouselIndicator(_current == index),
            ],
          ),
      ],
    );
  }
}

class CustomCarouselIndicator extends StatelessWidget {
  final bool active;

  CustomCarouselIndicator(this.active);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.pink : Color.fromRGBO(0, 0, 0, 0.2),
      ),
    );
  }
}
