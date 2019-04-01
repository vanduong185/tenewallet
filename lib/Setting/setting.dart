import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => new _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        title: Center(
          child: Text("Setting"),
        ),
        elevation: 0,
      ),
      body: new Container(
        child: Center(
          child: Text("Setting"),
        ),
      ),
    );
  }
}