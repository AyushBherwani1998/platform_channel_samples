import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class CounterNativePlugin {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'counter_native',
      const StandardMethodCodec(),
      registrar.messenger,
    );
    
    final CounterNativePlugin instance = CounterNativePlugin();
    channel.setMethodCallHandler(
      instance.handleMethodCall,
    );
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'increment':
        int count = call.arguments['count'];
        return count + 1;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: "Not Implemented",
        );
    }
  }
}
