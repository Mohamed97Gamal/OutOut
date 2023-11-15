import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:out_out/config.dart';

Future<String> createLink({
  required String relativeUrl,
}) async {
  return dynamicLinksBaseUrl + relativeUrl;
}

Future<String> createDynamicLink({
  required String relativeUrl,
  required String title,
  String? description,
  String? imageUrl,
  bool short = false,
}) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: dynamicLinksUriPrefix,
    link: Uri.parse(dynamicLinksBaseUrl + relativeUrl),
    androidParameters: AndroidParameters(
      packageName: androidPackageName,
    ),
    iosParameters: IOSParameters(
      bundleId: iOSBundleId,
      appStoreId: appStoreId,
    ),
    socialMetaTagParameters: SocialMetaTagParameters(
      title: title,
      description: description,
      imageUrl: imageUrl != null ? Uri.parse(imageUrl) : null,
    ),
  );

  if (!short) {
    final Uri dynamicUrl = await FirebaseDynamicLinks.instance.buildLink(parameters);
    print("dynamicUrl: " + dynamicUrl.toString());
    return dynamicUrl.toString();
  }

  final ShortDynamicLink shortDynamicUrl = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
  return shortDynamicUrl.shortUrl.toString();
}
