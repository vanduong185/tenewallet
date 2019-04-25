import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";
import "package:flutter/cupertino.dart";
import 'dart:async';
import 'dart:convert';

import 'package:tenewallet/screens/passcode/enter_passcode.dart';
import 'package:tenewallet/screens/passcode/create_passcode.dart';
import 'package:tenewallet/screens/index.dart';
import 'package:tenewallet/models/PassCodeInfo.dart';
import 'package:tenewallet/widgets/background.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
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

  redirect() async {
    await getPasscode();

    var duration = new Duration(seconds: 0);

    return new Timer(duration, () {
      if (passcode == null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CreatePasscode()));
      }
      else {
        if (passcode.isActive) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => EnterPasscode(passcode.code))
          );
        }
        else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Index())
          );
        }
      }
    });
  }

  @override
  initState()  {
    super.initState();
    redirect();
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
