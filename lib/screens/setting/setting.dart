import 'package:flutter/material.dart';

import 'package:tenewallet/screens/setting/security.dart';
import 'package:tenewallet/screens/setting/general.dart';
import 'package:tenewallet/screens/setting/other.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => new _SettingState();
}

class _SettingState extends State<Setting> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Setting", style: TextStyle(color: Color(0xFF1980BA), fontSize: 20),),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xFF1980BA)
        ),
        bottom: PreferredSize(
          child: Container(
            height: 1,
            color: Color(0xFF1980BA),
          ), preferredSize: null,
        )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SecuritySetting(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: GeneralSetting(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: OtherSetting(),
              ),
            ],
          ),
        ),
      )
    );
  }
}