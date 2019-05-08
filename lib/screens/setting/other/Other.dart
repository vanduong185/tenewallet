import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tenewallet/screens/setting/other/About.dart';

class OtherSetting extends StatefulWidget {
  @override
  _OtherSettingState createState() => _OtherSettingState();
}

class _OtherSettingState extends State<OtherSetting> {
  @override
  void initState() {
    super.initState();
  }

  _launchEmailApp() async {
    const url = 'mailto:info@teneocto.io?subject=[Support - TeneWallet]&body=';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("fail");
      throw 'Could not launch $url';
    }
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
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: new SvgPicture.asset(
                          "lib/assets/fonts/svg/support.svg",
                          color: Color(0xFF4AB7E0)
                        ),
                      ),
                      Text("Get Support", style: TextStyle(color: Color(0xFF333333), fontSize: 14, fontWeight: FontWeight.w300),)
                    ],
                  ),
                  onTap: () {
                    _launchEmailApp();
                  },
                )
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
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: new SvgPicture.asset(
                        "lib/assets/fonts/svg/license.svg",
                        color: Color(0xFF4AB7E0)
                      ),
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
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: new SvgPicture.asset(
                          "lib/assets/fonts/svg/about.svg",
                          color: Color(0xFF4AB7E0)
                        ),
                      ),
                      Text("About", style: TextStyle(color: Color(0xFF333333), fontSize: 14, fontWeight: FontWeight.w300),)
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => About())
                    );
                  },
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