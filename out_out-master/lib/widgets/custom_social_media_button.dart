import 'package:flutter/material.dart';
import 'package:out_out/utils/url_launcher_utils.dart';

class CustomSocialMediaButton extends StatelessWidget {
  final String url;
  final Widget icon;

  const CustomSocialMediaButton({
    Key? key,
    required this.url,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => launchURL(url),
        child: Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.grey[400],
          ),
          child: icon,
        ),
      ),
    );
  }
}
