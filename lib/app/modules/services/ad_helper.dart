import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3759109354437166/9256718316";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3759109354437166/8817734619";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
