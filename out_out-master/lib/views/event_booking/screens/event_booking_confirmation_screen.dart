// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:out_out/data/view_models/event/single_event_occurrence_response.dart';
// import 'package:out_out/views/event_booking/ticket_image_view.dart';
// import 'package:out_out/views/event_booking/ticket_item.dart';
// import 'package:out_out/views/event_booking/ticket_share_button.dart';
// import 'package:out_out/widgets/containers/custom_scaffold.dart';
//
// class EventBookingConfirmationScreen extends StatelessWidget {
//   final SingleEventOccurrenceResponse singleEventOccurrenceResponse;
//
//   const EventBookingConfirmationScreen({
//     Key? key,
//     required this.singleEventOccurrenceResponse,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       headerHeight: 130,
//       header: Align(
//         alignment: Alignment.bottomLeft,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 20),
//           child: Text(
//             "Confirmation",
//             style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Make a Booking",
//                   style: Theme.of(context).textTheme.headline5!.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                 ),
//                 TicketShareButton(),
//               ],
//             ),
//             Text(
//               "Date : Tuesday 23 Feb",
//               style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20.0),
//             Text(
//               "Quantity : 1 of 3",
//               style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20.0),
//             Text(
//               "Time : 8:00 Pm | 11:00 Pm",
//               style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20.0),
//             Text(
//               "Total Amount : 599.00 AED",
//               style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20.0),
//             Text(
//               "Location : The Ritz-Carlton DIFC, Dubai",
//               style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             const SizedBox(height: 40.0),
//             Center(
//               child: DottedLine(
//                 dashLength: 10,
//                 dashGapLength: 5,
//                 dashColor: Colors.grey,
//                 lineLength: MediaQuery.of(context).size.width * 0.7,
//               ),
//             ),
//             const SizedBox(height: 20.0),
//             Center(
//               child: Text(
//                 "You can use this Qr code to enter the event ",
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20.0),
//                 child: TicketImageView(singleEventOccurrenceResponse: singleEventOccurrenceResponse),
//               ),
//             ),
//             TicketItem(
//               singleEventOccurrenceResponse: singleEventOccurrenceResponse,
//               index: 1,
//             ),
//             const SizedBox(height: 10.0),
//             TicketItem(
//               singleEventOccurrenceResponse: singleEventOccurrenceResponse,
//               index: 0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
