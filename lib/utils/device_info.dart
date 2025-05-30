import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

Future<String> getDeviceName() async {
  final deviceInfo = DeviceInfoPlugin();
  String deviceName = 'Unknown Device';

  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model ?? 'Unknown Android Device';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine ?? " Unknown Iso Device";
    }
  } catch (e) {
    print("Error getting device info: $e");
  }

  return deviceName;
}
