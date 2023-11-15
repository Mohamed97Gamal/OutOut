import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/widgets/universal_image.dart';

class Stars extends StatelessWidget {
  final int current;
  final int max;
  final bool isEnabled;

  static const size = 14.0;
  static const horizontalPadding = 1.0;

  const Stars({
    required this.current,
    required this.max,
    Key? key,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final neededWidth = (max * size) + (max * horizontalPadding * 2);
    return LayoutBuilder(
      builder: (context, constrains) {
        if (max == 5 || constrains.maxWidth > neededWidth) {
          return Row(
            children: [
              for (int i = 0; i < current; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: UniversalImage(
                    IconAssets.star_filled,
                    width: size,
                    height: size,
                    color: !isEnabled ? Colors.grey : Theme.of(context).primaryColor,
                  ),
                ),
              for (int i = 0; i < max - current; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: UniversalImage(
                    IconAssets.star,
                    width: size,
                    height: size,
                    color: !isEnabled ? Colors.grey : Theme.of(context).primaryColor,
                  ),
                ),
            ],
          );
        }
        int firstRowCurrent = current;
        int secondRowCurrent = 0;
        if (current > 5) {
          firstRowCurrent = 5;
          secondRowCurrent = current - 5;
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < firstRowCurrent; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: UniversalImage(
                      IconAssets.star_filled,
                      width: size,
                      height: size,
                      color: !isEnabled ? Colors.grey : Theme.of(context).primaryColor,
                    ),
                  ),
                for (int i = 0; i < 5 - firstRowCurrent; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: UniversalImage(
                      IconAssets.star,
                      width: size,
                      height: size,
                      color: !isEnabled ? Colors.grey : Theme.of(context).primaryColor,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < secondRowCurrent; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: UniversalImage(
                      IconAssets.star_filled,
                      width: size,
                      height: size,
                      color: !isEnabled ? Colors.grey : Theme.of(context).primaryColor,
                    ),
                  ),
                for (int i = 0; i < 5 - secondRowCurrent; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: UniversalImage(
                      IconAssets.star,
                      width: size,
                      height: size,
                      color: !isEnabled ? Colors.grey : Theme.of(context).primaryColor,
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
