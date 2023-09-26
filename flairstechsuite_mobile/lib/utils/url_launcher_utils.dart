import 'package:url_launcher/url_launcher.dart';

Future launchURL(String url) async {
  final hasHttp = url.startsWith("https://") || url.startsWith("http://");
  final isTel = url.startsWith("tel://");
  final isMail = url.startsWith("mailto:");

  String _url;
  if (!hasHttp && !isTel && !isMail) {
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
