import 'package:flutter/material.dart';
import 'home_page.dart';

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CapturePage extends StatefulWidget {

  final CameraDescription camera;

  const CapturePage({Key key, @required this.camera,}) : super(key: key);

  @override
  _CapturePageState createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {

  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Capture Photo')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
//            return CameraPreview(_controller);
            return ClipRect(
              child: OverflowBox(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Container(
                    width: 300,
                    height: 300/ _controller.value.aspectRatio,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CameraPreview(_controller),
                    ),
                  ),
                ),
              ),
            );






          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
          },
      ),
        floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff90CAF9),


          onPressed: () async {
            try {
              await _initializeControllerFuture;
              final path = join(
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png',
              );

              await _controller.takePicture(path);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(imagePath: path),
                ),
              );
            } catch (e) {
              print(e);
            }
          },
        )
    );
  }
}

class ResultsPage extends StatelessWidget {
  final String imagePath;

  const ResultsPage({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: <Widget>[
          Image.file(File(imagePath)),
        ],)
    );
  }
}