import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "COLE SEU ID AQUI";
    } else if (Platform.isIOS) {
      return "COLE SEU ID AQUI";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
