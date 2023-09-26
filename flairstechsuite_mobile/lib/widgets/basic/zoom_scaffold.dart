// import 'dart:ui';
//
// import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class ZoomScaffold extends StatefulWidget {
//   final Widget menuScreen;
//   final Widget contentScreen;
//   final Widget bottomNavigationBar;
//
//   ZoomScaffold({
//     this.menuScreen,
//     this.contentScreen,
//     this.bottomNavigationBar,
//   });
//
//   @override
//   _ZoomScaffoldState createState() => _ZoomScaffoldState();
// }
//
// class _ZoomScaffoldState extends State<ZoomScaffold> with TickerProviderStateMixin {
//   Curve scaleDownCurve = Interval(0.0, 0.3, curve: Curves.easeOut);
//   Curve scaleUpCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
//   Curve slideOutCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
//   Curve slideInCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
//
//   createContentDisplay() {
//     return zoomAndSlideContent(
//       Container(
//         child: Scaffold(
//           body: GestureDetector(
//             onHorizontalDragUpdate: (details) {
//               if (details.delta.dx > 6.0) {
//                 Provider.of<menu.MenuController>(context, listen: false).open();
//               } else if (details.delta.dx < -6.0) {
//                 Provider.of<menu.MenuController>(context, listen: false).close();
//               }
//             },
//             child: widget.contentScreen,
//           ),
//           bottomNavigationBar: MyBottomNavigationBar(),
//         ),
//       ),
//     );
//   }
//
//   zoomAndSlideContent(Widget content) {
//     double slidePercent, scalePercent;
//
//     switch (Provider.of<menu.MenuController>(context, listen: true).state) {
//       case MenuState.closed:
//         slidePercent = 0.0;
//         scalePercent = 0.0;
//         break;
//       case MenuState.open:
//         slidePercent = 1.0;
//         scalePercent = 1.0;
//         break;
//       case MenuState.opening:
//         slidePercent = slideOutCurve.transform(Provider.of<menu.MenuController>(context, listen: true).percentOpen);
//         scalePercent = scaleDownCurve.transform(Provider.of<menu.MenuController>(context, listen: true).percentOpen);
//         break;
//       case MenuState.closing:
//         slidePercent = slideInCurve.transform(Provider.of<menu.MenuController>(context, listen: true).percentOpen);
//         scalePercent = scaleUpCurve.transform(Provider.of<menu.MenuController>(context, listen: true).percentOpen);
//         break;
//     }
//
//     final slideAmount = 275.0 * slidePercent;
//     final contentScale = 1.0 - (0.2 * scalePercent);
//     final cornerRadius = 16.0 * Provider.of<menu.MenuController>(context, listen: true).percentOpen;
//
//     return Transform(
//       transform: Matrix4.translationValues(slideAmount, 0.0, 0.0)..scale(contentScale, contentScale),
//       alignment: Alignment.centerLeft,
//       child: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               offset: const Offset(0.0, 5.0),
//               blurRadius: 15.0,
//               spreadRadius: 10.0,
//             ),
//           ],
//         ),
//         child: Stack(
//           children: <Widget>[
//             ClipRRect(
//               borderRadius: BorderRadius.circular(cornerRadius),
//               child: content,
//             ),
//             if (slidePercent == 1.0)
//               Positioned.fill(
//                 child: GestureDetector(
//                   onTap: () {
//                     if (slidePercent == 1.0) {
//                       Future(() => Provider.of<menu.MenuController>(context, listen: false).toggle());
//                     }
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget createMenuWidget() {
//     return Container(
//       child: Scaffold(
//         body: widget.menuScreen,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [createMenuWidget(), createContentDisplay()],
//     );
//   }
// }
//
// class ZoomScaffoldMenuController extends StatefulWidget {
//   final ZoomScaffoldBuilder builder;
//
//   ZoomScaffoldMenuController({
//     this.builder,
//   });
//
//   @override
//   ZoomScaffoldMenuControllerState createState() {
//     return ZoomScaffoldMenuControllerState();
//   }
// }
//
// class ZoomScaffoldMenuControllerState extends State<ZoomScaffoldMenuController> {
//   @override
//   Widget build(BuildContext context) {
//     return widget.builder(context, Provider.of<menu.MenuController>(context, listen: true));
//   }
// }
//
// typedef ZoomScaffoldBuilder = Widget Function(BuildContext context, MenuController menuController);
//
// class Layout {
//   final WidgetBuilder contentBuilder;
//
//   Layout({
//     this.contentBuilder,
//   });
// }
//
