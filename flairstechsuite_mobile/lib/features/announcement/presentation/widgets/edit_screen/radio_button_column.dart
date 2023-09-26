import 'package:flairstechsuite_mobile/features/announcement/domain/entity/announcement.dart';
import 'package:flutter/material.dart';

class RadioButtonsColumn extends StatelessWidget {
  final AnnouncementEntity? announcement;
  final void Function()? onTapPublish;
  final void Function()? onTapNotification;

  final bool? willPublish;
  final bool? willSend;
  const RadioButtonsColumn(
      {Key? key,
      this.announcement,
      this.onTapPublish,
      this.onTapNotification,
      this.willPublish,
      this.willSend})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Row(
            children: [
              IgnorePointer(
                child: Checkbox(
                  value: willPublish,
                  onChanged: announcement?.isPublished == true ? null : (_) {},
                ),
              ),
              const Text("Publish now")
            ],
          ),
          onTap: announcement?.isPublished == true ? null : onTapPublish,
        ),
        InkWell(
          child: Row(
            children: [
              IgnorePointer(
                child: Checkbox(
                  value: willSend,
                  onChanged: !willPublish! ? null : (_) {},
                ),
              ),
              const Text("Send notification now")
            ],
          ),
          onTap: !willPublish! ? null : onTapNotification,
        ),
      ],
    );
  }
}
