import 'package:flutter/material.dart';

abstract class TabViewItem extends StatelessWidget {
  final String title;

  const TabViewItem({
    required this.title,
    Key? key,
  }) : super(key: key);
}
