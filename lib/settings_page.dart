import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;
  TimeOfDay checkInTime;
  TimeOfDay checkOutTime;

  Future<dynamic> selectTime(BuildContext context, pickedTime) async {
    picked = await showTimePicker(
        context: context,
        initialTime: _time,
    );

    setState(() {
      _time = picked;
      print(_time);
      pickedTime = _time;
    });

    return pickedTime;
  }
  
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
            subtitle: Text(checkInTime.toString()),
            dense: false,
            onTap: () {
              selectTime(context, checkInTime);
            },
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
