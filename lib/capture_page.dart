import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

bool showSpinner = false;
final _firestore = Firestore.instance;

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

//class ResultsPage extends StatelessWidget {
//  final String imagePath;
//
//  const ResultsPage({Key key, this.imagePath}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('Result')),
//      // The image is stored as a file on the device. Use the `Image.file`
//      // constructor with the given path to display the image.
//      body: Column(
//        children: <Widget>[
//          Flexible(child: Image.file(File(imagePath))),
//          FloatingActionButton.extended(
//            backgroundColor: Color(0xff90CAF9),
//            onPressed: () {
//
//
//
//
//              Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
//            },
//            icon: Icon(Icons.done),
//            label: Text("Submit"),
//          ),
//        ],
//      )
//    );
//  }
//}

class ResultsPage extends StatefulWidget {
  final String imagePath;

  ResultsPage({Key key, this.imagePath}) : super(key: key);
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          appBar: AppBar(title: Text('Result')),
          // The image is stored as a file on the device. Use the `Image.file`
          // constructor with the given path to display the image.
          body: Column(
            children: <Widget>[
              Flexible(child: Image.file(File(widget.imagePath))),
              FloatingActionButton.extended(
                backgroundColor: Color(0xff90CAF9),
                onPressed: () {

                  try {
                    setState(() {
                      showSpinner = true;
                    });

                    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('${DateTime.now()}.png');
                    final StorageUploadTask task = firebaseStorageRef.putFile(File(widget.imagePath));

                    _firestore.collection('capture').add({
                      'created_at': DateTime.now(),
                      'path': 'gs://remote-attendance-mobile.appspot.com/${DateTime.now()}.png'
                    });

                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                  }

                  catch (e) {
                    print(e);

                    setState(() {
                      showSpinner = false;
                    });
                  }
                },
                icon: Icon(Icons.done),
                label: Text("SUBMIT"),
              ),
//              FloatingActionButton.extended(
//                onPressed: null,
//                label: Text("RETAKE"),
//                icon: Icon(Icons.refresh),
//              )
            ],
          )
      ),
    );
  }
}
