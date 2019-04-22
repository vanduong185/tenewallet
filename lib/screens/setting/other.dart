import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tenewallet/assets/fonts/tene_icon_icons.dart';

class OtherSetting extends StatefulWidget {
  @override
  _OtherSettingState createState() => _OtherSettingState();
}

class _OtherSettingState extends State<OtherSetting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Other", style: TextStyle(color: Color(0xFF1980BA), fontSize: 16, fontWeight: FontWeight.w500),),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFC7C7C7), width: 1))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(TeneIcon.support, color: Color(0xFF4AB7E0), size: 24,),
                    ),
                    Text("Get Support", style: TextStyle(color: Color(0xFF333333), fontSize: 14, fontWeight: FontWeight.w300),)
                  ],
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFC7C7C7), width: 1))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(TeneIcon.license, color: Color(0xFF4AB7E0), size: 24,),
                    ),
                    Text("Open Source License", style: TextStyle(color: Color(0xFF333333), fontSize: 14, fontWeight: FontWeight.w300),)
                  ],
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFC7C7C7), width: 1))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(TeneIcon.about, color: Color(0xFF4AB7E0), size: 24,),
                    ),
                    Text("About", style: TextStyle(color: Color(0xFF333333), fontSize: 14, fontWeight: FontWeight.w300),)
                  ],
                ),
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