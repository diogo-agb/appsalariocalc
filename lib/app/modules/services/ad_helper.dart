import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "COLE AQUI O SEU ID";
    } else if (Platform.isIOS) {
      return "COLE AQUI O SEU ID";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
