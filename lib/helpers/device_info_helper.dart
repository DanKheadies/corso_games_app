import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

Future<Map<String, String>> getDeviceInfoHelper() async {
  String deviceOS = '';
  String deviceType = '';

  if (kIsWeb) {
    var webInfo = await DeviceInfoPlugin().webBrowserInfo;
    var browser = webInfo.browserName;
    var language = webInfo.language;
    var platform = webInfo.platform;
    var product = webInfo.product;
    deviceOS = 'Web $browser ($language)';
    deviceType = '$platform - $product';
  } else {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      deviceOS = 'Android $release (SDK $sdkInt)';
      deviceType = '$manufacturer $model';
      // print('Android $release (SDK $sdkInt), $manufacturer $model');
      // Android 9 (SDK 28), Xiaomi Redmi Note 7
    } else if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      // var name = iosInfo.data['utsname']['nodename']; // iosInfo.name;
      var name = iosInfo.name;
      var model = iosInfo.model;
      deviceOS = '$systemName $version';
      deviceType = '$name\'s $model';
      // print('$systemName $version, $name $model');
      // iOS 13.1, iPhone 11 Pro Max iPhone
    } else if (Platform.isMacOS) {
      var macInfo = await DeviceInfoPlugin().macOsInfo;
      var release = macInfo.osRelease;
      var version = macInfo.majorVersion;
      var model = macInfo.model;
      var name = macInfo.computerName;
      deviceOS = 'Mac $release (Ver. $version)';
      deviceType = '$name\'s $model';
    } else {
      print('not a registered system');
    }
  }
  return {
    'deviceOS': deviceOS,
    'deviceType': deviceType,
  };
}
