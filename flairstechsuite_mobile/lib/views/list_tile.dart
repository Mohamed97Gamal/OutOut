import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileListTile extends StatelessWidget {
  final String propertyName, propertyValue;

  const MobileListTile({
    required this.propertyName,
    required this.propertyValue,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.phone),
      title: Text("$propertyValue"),
      subtitle: Text("$propertyName"),
      onTap: () => launch("tel://$propertyValue"),
    );
  }
}
