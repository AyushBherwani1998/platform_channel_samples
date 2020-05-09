import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class BatteryPlugin {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'battery',
      const StandardMethodCodec(),
      registrar.messenger,
    );
    
    final BatteryPlugin instance = BatteryPlugin();
    channel.setMethodCallHandler(
      instance.handleMethodCall,
    );
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getBattery':
        html.BatteryManager battery = await html.window.navigator.getBattery();
        return battery.level;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: "Not Implemented",
        );
    }
  }
}
