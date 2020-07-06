import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'capture_page.dart';

import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomePage extends StatefulWidget {

  final String title;
  final CameraDescription camera;

  const HomePage({Key key, this.title, @required this.camera,}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
            )
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Color(0x12ffffff ),
              borderRadius: BorderRadius.circular(4.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 120),
                child: Image(
                  width: 144,
                  image: AssetImage('images/cognixy.png'),
                ),
              ),
              Card(
                color: Color(0xff90CAF9),
                margin:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 77.0),
                child: ListTile(
                  title: Text(
                    'Capture',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff121212),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CapturePage(camera: widget.camera)),
                    );
                  },
                ),
              ),
              Card(
                color: Color(0xff90CAF9),
                margin:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 77.0),
                child: ListTile(
                  title: Text(
                    'Settings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff121212),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
