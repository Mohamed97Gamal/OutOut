import 'package:out_out/config.dart';
import 'package:share/share.dart';

Future shareApp() => Share.share(websiteUrl);

Future share(String content, {String? subject}) => Share.share(content, subject: subject);
