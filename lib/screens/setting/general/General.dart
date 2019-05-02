import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tenewallet/assets/fonts/tene_icon_icons.dart';

import 'package:tenewallet/screens/setting/general/Currency.dart';
import 'package:tenewallet/screens/setting/general/Network.dart';

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
        Currency(),
        Network()
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}