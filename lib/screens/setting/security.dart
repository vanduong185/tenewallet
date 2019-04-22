import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:tenewallet/models/passcode.dart';
import 'package:tenewallet/assets/fonts/tene_icon_icons.dart';

class SecuritySetting extends StatefulWidget {
  @override
  _SecuritySettingState createState() => _SecuritySettingState();
}

class _SecuritySettingState extends State<SecuritySetting> {
  Passcode passcode;


  getPasscode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      String dataString = prefs.getString("tenewallet_passcode");

      if (dataString != null) {
        var data = jsonDecode(dataString);
        passcode = new Passcode();
        passcode.code = data["code"];
        passcode.isActive = data["isActive"];
      }
    });
  }

  updatePasscode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("tenewallet_passcode");
    await prefs.setString("tenewallet_passcode", passcode.toString());
  }

  @override
  void initState() {
    super.initState();

    passcode = new Passcode();
    passcode.isActive = false;

    getPasscode();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Security", style: TextStyle(color: Color(0xFF1980BA), fontSize: 16, fontWeight: FontWeight.w500),),
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFC7C7C7), width: 1))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(TeneIcon.passcode, color: Color(0xFF4AB7E0), size: 24,),
                    ),
                    Text("Passcode", style: TextStyle(color: Color(0xFF333333), fontSize: 14, fontWeight: FontWeight.w300),)
                  ],
                ),
                Switch(
                  value: passcode.isActive,
                  onChanged: (value) {
                    setState(() {
                      passcode.isActive = value;
                      updatePasscode();
                    });
                  },
                  activeColor: Color(0xFF1980BA),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}