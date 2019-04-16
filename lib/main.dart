import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';

import "package:tenewallet/widgets/splash.dart";

Future<Null> main() async{
  SystemChrome.setSystemUIOverlayStyle(new SystemUiOverlayStyle(
    statusBarColor: Color(0xFF1980BA) // set status bar color
  ));

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tenewallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
