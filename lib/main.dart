import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(RemoteAttendance());

class RemoteAttendance extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App Side Project',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xff121212),
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
      home: HomePage(title: 'Remote Attendance System'),
    );
  }
}

