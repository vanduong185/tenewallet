import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:tenewallet/Authentication/enter_pin_code.dart";
import "package:tenewallet/Authentication/create_pin_code.dart";
import "package:tenewallet/components/splash.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'dart:async';

List<CameraDescription> cameras;

Future<Null> main() async{
  SystemChrome.setSystemUIOverlayStyle(new SystemUiOverlayStyle(
    statusBarColor: Color(0xFF1980BA)
  ));

  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String pin_code;

  get_pin_code() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      pin_code = prefs.getString("my_pin_code");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Future.delayed(Duration(milliseconds: 5000), () => get_pin_code());
    //get_pin_code();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: pin_code == null ? CreatePinScreen() : EnterPinScreen(),
      home: Splash(cameras),
      debugShowCheckedModeBanner: false,
    );
  }
}
