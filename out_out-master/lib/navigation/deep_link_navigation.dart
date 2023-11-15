import 'package:flutter/material.dart';
import 'package:out_out/config.dart';
import 'package:out_out/navigation/navigation.dart';

class DeepLinkNavigation {
  static String? initialLink;

  DeepLinkNavigation._internal();

  static navToLink(BuildContext context, {required String link}) {
    final venueDetailsMask = dynamicLinksBaseUrl + "venues/";
    if (link.startsWith(venueDetailsMask)) {
      final venueId = link.replaceAll(venueDetailsMask, "");
      Navigation().navToVenueDetailsScreen(context, venueId: venueId);
    }
    final eventDetailsMask = dynamicLinksBaseUrl + "events/";
    if (link.startsWith(eventDetailsMask)) {
      final occurrenceId = link.replaceAll(eventDetailsMask, "");
      Navigation().navToEventDetailsScreen(context, occurrenceId: occurrenceId);
    }
    final ticketDetailsMask = dynamicLinksBaseUrl + "tickets?id=";
    if (link.startsWith(ticketDetailsMask)) {
      final uri = Uri.parse(link);

      final ticketId = uri.queryParameters["id"]!;
      final secret = uri.queryParameters["se"]!;
      final userId = uri.queryParameters["userId"];
      Navigation().navToReceiveSharedTicketScreen(context,
          secret: secret, ticketId: ticketId);
    }
  }
}
