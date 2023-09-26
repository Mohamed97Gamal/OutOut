import 'package:flairstechsuite_mobile/utils/theme_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveProgressIndicator extends StatelessWidget {

  const AdaptiveProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return isCupertinoTheme ? const CupertinoActivityIndicator() : const CircularProgressIndicator();
  }
}
