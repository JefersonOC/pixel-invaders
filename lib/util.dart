import 'package:url_launcher/url_launcher.dart';

class Util {
  static bool isNullOrEmpty(String str) {
    return (str == null) || str.isEmpty;
  }

  static launchURL(String url) async {
    String encoded = Uri.encodeFull(url);
    if (await canLaunch(encoded)) {
      await launch(encoded);
    } else {
      print('Could not launch $url');
    }
  }
}
