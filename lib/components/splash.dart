import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";
import "package:flutter/cupertino.dart";
import 'dart:async';

import 'package:tenewallet/Authentication/enter_pin_code.dart';
import 'package:tenewallet/Authentication/create_pin_code.dart';
import 'package:tenewallet/components/background.dart';

class Splash extends StatefulWidget {
  var cameras;

  Splash(this.cameras);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String pinCode;

  getPinCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      pinCode = prefs.getString("my_pin_code");
    });
  }

  checkPinCodeAfter3s() async {
    var _duration = new Duration(seconds: 3);

    return new Timer(_duration, () {
      getPinCode().then((f) {
        if (pinCode == null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CreatePinScreen()));
        }
        else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => EnterPinScreen(widget.cameras)));
        }
      });
    });

  }

  @override
  initState()  {
    // TODO: implement initState
    super.initState();

    checkPinCodeAfter3s();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Background(
      child: Center(
          child: Image.asset("image/tenewallet-logo.png", width: (screenWidth*0.5), height: (screenHeight*0.3),)
      ),
    );
  }
}
