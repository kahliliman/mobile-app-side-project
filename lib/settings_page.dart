import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('Check In Time'),
            subtitle: Text('08:00'),
            dense: false,
          ),
          ListTile(
            title: Text('Check Out Time'),
            subtitle: Text('17:00'),
            dense: false,
          ),
        ],
      ),
    );
  }
}
