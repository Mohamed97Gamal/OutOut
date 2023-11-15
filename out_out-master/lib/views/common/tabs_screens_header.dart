import 'package:flutter/material.dart';
import 'package:out_out/widgets/custom_chip.dart';
import 'package:out_out/widgets/title_text.dart';

class TabsScreensHeaders extends StatelessWidget {
  final String title;
  final bool hasChips;

  const TabsScreensHeaders({
    Key? key,
    required this.title,
    required this.hasChips,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(),
          const SizedBox(height: 10.0),
          if (hasChips)
             SizedBox(
              height: 50.0,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 8.0),
                itemBuilder: (context, index) {
                  return CustomChip(
                    label: Text("Chip #$index"),
                    avatar: Icon(Icons.style),
                    selected: index % 2 == 0,
                    onSelected: (newSelected) {},
                  );
                },
              ),
            ),
          const SizedBox(height: 10.0),
          HorizontallyPaddedTitleText(title),
        ],
      ),
    );
  }
}
