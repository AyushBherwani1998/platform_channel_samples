import 'dart:async';

import 'package:flutter/services.dart';

class CounterNative {
  static const MethodChannel _channel =
      const MethodChannel('counter_native');

  static Future<int> increment(int value) async {
    final int count = await _channel.invokeMethod('increment',{"count": value});
    return count;
  }
}
