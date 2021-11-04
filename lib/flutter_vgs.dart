import 'dart:async';

import 'package:flutter/services.dart';

class FlutterVgs {
  static const MethodChannel _channel = const MethodChannel('flutter_vgs');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> get revealVGSText async {
    final String? text = await _channel.invokeMethod('revealVGSText');
    return text;
  }
}
