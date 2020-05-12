import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget camera;
  VideoElement videoElement;
  Widget image;
  CanvasElement canvasElement;
  bool imageCaptured;

  @override
  void initState() {
    super.initState();
    imageCaptured = false;

    videoElement = VideoElement();

    ui.platformViewRegistry.registerViewFactory(
      'videoElement',
      (int id) => videoElement,
    );

    camera = HtmlElementView(key: UniqueKey(), viewType: 'videoElement');

    window.navigator.getUserMedia(video: true).then((MediaStream stream) {
      videoElement.srcObject = stream;
      videoElement.play();

      canvasElement = CanvasElement(
        height: 600,
        width: 600,
      );

      ui.platformViewRegistry.registerViewFactory(
        'canvasElement',
        (int id) => canvasElement,
      );

      image = HtmlElementView(
        key: UniqueKey(),
        viewType: 'canvasElement',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Camera Demo'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(24),
              child: camera,
            ),
          ),
          Visibility(
            visible: imageCaptured,
            child: Expanded(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(24),
                child: image,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            canvasElement.context2D.drawImageScaled(
              videoElement,
              0,
              (size.height - videoElement.videoHeight - 48) / 4,
              videoElement.videoWidth,
              videoElement.videoHeight,
            );
          });

          if (!imageCaptured) {
            setState(() {
              imageCaptured = true;
            });
          }
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
