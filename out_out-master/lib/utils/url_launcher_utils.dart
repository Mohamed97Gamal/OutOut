import 'package:url_launcher/url_launcher.dart';

Future launchURL(String url) async {
  final hasHttp = url.startsWith("https://") || url.startsWith("http://");

  String _url;
  if (!hasHttp) {
    _url = "https://$url";
  } else {
    _url = url;
  }

  if (await canLaunch(_url)) {
    await launch(_url);
  } else {
    throw 'Could not launch $_url';
  }
}

Future launchMaps(num latitude, num longitude) async {
  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    throw 'Could not open the map.';
  }
}

Future launchTelephone(String phoneNumber) async {
  final url = "tel://$phoneNumber";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future launchMail(String emailAddress) async {
  final url = "mailto:$emailAddress";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
