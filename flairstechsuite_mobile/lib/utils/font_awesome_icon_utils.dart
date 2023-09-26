import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData getSocialMediaIcon(String type) {
  switch (type) {
    case "Facebook":
      return FontAwesomeIcons.facebook;
    case "Twitter":
      return FontAwesomeIcons.twitter;
    case "Instagram":
      return FontAwesomeIcons.instagram;
    case "LinkedIn":
      return FontAwesomeIcons.linkedin;
    case "Github":
      return FontAwesomeIcons.github;
    default:
      return FontAwesomeIcons.link;
  }
}
