
import 'package:flutter/material.dart';
import 'package:battery_native/battery_native.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double battery = 0;

  @override
  void initState() {
    getBatteryLevel();
    super.initState();
  }

  getBatteryLevel(){
    BatteryPlugin.getBattery.then((value){
      setState((){
        battery= value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Battery Level is : ${battery * 100}'),
        ),
      ),
    );
  }
}
