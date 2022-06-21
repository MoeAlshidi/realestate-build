import 'package:url_launcher/url_launcher_string.dart';

class MapUtils {
  MapUtils._();
  static Future<void> openMap(double lat, double lon) async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$lon";
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl);
    } else {
      throw 'Could not open Map';
    }
  }
}
