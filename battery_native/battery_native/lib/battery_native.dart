import 'dart:async';

import 'package:flutter/services.dart';

class BatteryPlugin {
  static const MethodChannel _channel =
      const MethodChannel('battery');

  static Future<double> get getBattery async {
    final double battery = await _channel.invokeMethod('getBattery');
    return battery;
  }
}
