import 'package:flutter/material.dart';

class GeneralSetting extends StatefulWidget {
  @override
  _GeneralSettingState createState() => _GeneralSettingState();
}

class _GeneralSettingState extends State<GeneralSetting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("General", style: TextStyle(color: Color(0xFF1980BA), fontSize: 16, fontWeight: FontWeight.w500),),
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
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(Icons.monetization_on, color: Color(0xFF4AB7E0), size: 24,),
                    ),
                    Text("Currency", style: TextStyle(color: Color(0xFF333333), fontSize: 14, fontWeight: FontWeight.w300),)
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