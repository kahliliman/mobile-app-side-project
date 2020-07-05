import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'settings_page.dart';
import 'capture_page.dart';

import 'package:camera/camera.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//ONE
//void main() => runApp(RemoteAttendance());
//
//class RemoteAttendance extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Mobile App Side Project',
//      theme: ThemeData.dark().copyWith(
//        primaryColor: Color(0xff121212),
//        accentColor: Color(0xff90CAF9),
//        scaffoldBackgroundColor: Color(0xff000000),
//        primaryTextTheme: TextTheme(
//          title: TextStyle(
//              color: Color(0xff90CAF9)
//          ),
//        ),
//        textTheme: TextTheme(
//            body1: TextStyle(
//                color: Color(0xff90CAF9)
//            ),
//        ),
//    ),
//      home: HomePage(title: 'Remote Attendance System'),
//    );
//  }
//}

//TWO
//Future<void> main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//
//  final cameras = await availableCameras();
//
//  final firstCamera = cameras.first;
//
//  runApp(RemoteAttendance());
//}
//
//
//class RemoteAttendance extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Mobile App Side Project',
//      theme: ThemeData.dark().copyWith(
//        primaryColor: Color(0xff121212),
//        accentColor: Color(0xff90CAF9),
//        scaffoldBackgroundColor: Color(0xff000000),
//        primaryTextTheme: TextTheme(
//          title: TextStyle(
//              color: Color(0xff90CAF9)
//          ),
//        ),
//        textTheme: TextTheme(
//            body1: TextStyle(
//                color: Color(0xff90CAF9)
//            ),
//        ),
//    ),
//      home: HomePage(title: 'Remote Attendance System', camera: firstCamera),
//    );
//  }
//}

//THREE
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final firstCamera = cameras.last;

  runApp(
      MaterialApp(
        home: HomePage(title: 'Remote Attendance System', camera: firstCamera),
        title: 'Mobile App Side Project',
        theme: ThemeData.dark().copyWith(primaryColor: Color(0xff121212),
          accentColor: Color(0xff90CAF9),
          scaffoldBackgroundColor: Color(0xff000000),
          primaryTextTheme: TextTheme(
            title: TextStyle(
                color: Color(0xff90CAF9)
            ),
          ),
          textTheme: TextTheme(
            body1: TextStyle(
                color: Color(0xff90CAF9)
            ),
          ),
        ),
      )
  );
}

