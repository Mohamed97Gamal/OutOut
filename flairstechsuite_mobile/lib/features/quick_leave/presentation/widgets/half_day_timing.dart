import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/constants.dart';
import '../../../../enums/quick_leaves.dart';
import '../manager/quick_leave_provider.dart';

class HalfDayTiming extends StatelessWidget {
  const HalfDayTiming({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quickLeaveProvider = Provider.of<QuickLeaveProvider>(context);
    if (quickLeaveProvider.selectedQuickLeave == QuickLeave.HalfDayLeave)
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: DropdownButtonFormField<String>(
          alignment: Alignment.center,
          // hint: Text('Half-day Timing'),
          decoration: InputDecoration(
            labelText: 'Half-day Timing',
            labelStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: TextStyle(color: Colors.black),
          value: quickLeaveProvider.halfDayTimingStringValue,
          items: <DropdownMenuItem<String>>[
            for (var index in quickLeaveProvider.halfDayTiming)
              DropdownMenuItem<String>(
                value: index,
                child: Center(
                  child: Text(
                    index,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
          ],
          onChanged: (value) {
            value == AppStrings.firstHalfOfDAY
                ? Provider.of<QuickLeaveProvider>(context, listen: false)
                    .setHalfTime(0, value)
                : Provider.of<QuickLeaveProvider>(context, listen: false)
                    .setHalfTime(1, value);
          },
        ),
      );
   return SizedBox();
  }
}
