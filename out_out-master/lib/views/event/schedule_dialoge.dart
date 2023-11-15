import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/view_models/event/event_occurrence_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/views/event/event_action.dart';
import 'package:out_out/widgets/popups/adaptive_dialog.dart'as di;
import 'package:out_out/widgets/universal_image.dart';

Future<EventOccurrenceResponse?> showScheduleDialog({
  required BuildContext context,
  required List<EventOccurrenceResponse> occurrences,
}) async {
  return await di.showAdaptiveDialog<EventOccurrenceResponse?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.only(top: 8.0),
        content: Container(
          alignment: Alignment.topLeft,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          child: ListView.builder(
            itemCount: occurrences.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var item = occurrences[index];
              return EventAction(
                onPressed: () {
                  Navigator.of(context).pop(item);
                  Navigator.pop(context);
                  Navigation()
                      .navToEventDetailsScreen(context, occurrenceId: item.id);
                },
                icon: UniversalImage(IconAssets.clock),
                content: [
                  Text(
                    item.explainDateOnly(),
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    "${item.startTime} To ${item.endTime}",
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              );
            },
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
