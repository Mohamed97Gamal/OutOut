import 'package:flutter/material.dart';

class EditAnnouncementTextField extends StatelessWidget {
  final TextEditingController? titleController;
  final TextEditingController? bodyController;
  final bool? haveImage;
  const EditAnnouncementTextField(
      {Key? key, this.titleController, this.bodyController, this.haveImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: titleController,
            maxLines: null,
            validator: (v) {
              final trimmed = v!.trim();
              if (trimmed.isEmpty) return "Title is required.";
              if (trimmed.length < 5 || trimmed.length > 100)
                return "Title should have a minimum of 5 characters and a maximum of 100 characters.";
              return null;
            },
            decoration: const InputDecoration(labelText: "Title",labelStyle: TextStyle(
              color: Colors.grey,
            ),hintStyle: TextStyle(color: Colors.grey)),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: bodyController,
            maxLines: null,
            minLines: 3,
            validator: (v) {
              final trimmed = v!.trim();
              if (trimmed.isEmpty && haveImage!)
                return "Announcement should have at least an image or a body";
              if (trimmed.length > 1000)
                return "Body should have a maximum of 1000 characters.";
              return null;
            },
            decoration: const InputDecoration(labelText: "Body",labelStyle: TextStyle(
              color: Colors.grey,
            ),hintStyle: TextStyle(color: Colors.grey)),
          ),
        ),
      ],
    );
  }
}
